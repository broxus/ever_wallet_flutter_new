import 'package:app/app/router/router.dart';
import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';

/// Screen that allows to prepare sending tokens from Ton/Token Wallets
/// to any other address.
/// To make this page correct, Ton/Token Wallet subscriptions must be created
/// before on starting page.
class WalletPrepareTransferPage extends StatelessWidget {
  const WalletPrepareTransferPage({
    required this.address,
    this.rootTokenContract,
    super.key,
  });

  /// Address of account, that should be used to send funds
  final Address address;

  /// Contract of token (native or not) that will be locked to send funds
  final Address? rootTokenContract;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WalletPrepareTransferCubit>(
      create: (_) => WalletPrepareTransferCubit(
        address: address,
        rootTokenContract: rootTokenContract,
        nekotonRepository: inject(),
        balanceService: inject(),
        assetsService: inject(),
      ),
      child:
          BlocConsumer<WalletPrepareTransferCubit, WalletPrepareTransferState>(
        listener: (context, state) {
          state.whenOrNull(
            goNext: (
              walletName,
              account,
              selectedCustodian,
              localCustodians,
              selectedAsset,
              assets,
              receiveAddress,
              amount,
              comment,
            ) {
              if (selectedAsset.isNative) {
                context.goFurther(
                  AppRoute.tonWalletSend.pathWithQuery(
                    {
                      tonWalletSendAddressQueryParam: address.address,
                      tonWalletSendPublicKeyQueryParam:
                          selectedCustodian.publicKey,
                      if (comment != null)
                        tonWalletSendCommentQueryParam: comment,
                      tonWalletSendDestinationQueryParam:
                          receiveAddress.address,
                      tonWalletSendAmountQueryParam:
                          amount.minorUnits.toString(),
                    },
                  ),
                );
              } else {
                inject<MessengerService>()
                    .show(Message.successful(message: 'Go send token'));
              }
            },
          );
        },
        builder: (context, state) {
          return state.when(
            loading: _defaultBody,
            empty: () => _defaultBody(_emptyText()),
            data: _dataBody,
            goNext: (
              walletName,
              account,
              selectedCustodian,
              localCustodians,
              selectedAsset,
              assets,
              receiveAddress,
              amount,
              comment,
            ) {
              return _dataBody(
                walletName,
                account,
                selectedCustodian,
                localCustodians,
                selectedAsset,
                assets,
              );
            },
          );
        },
      ),
    );
  }

  Widget _dataBody(
    String walletName,
    KeyAccount account,
    PublicKey selectedCustodian,
    List<PublicKey> localCustodians,
    WalletPrepareTransferAsset selectedAsset,
    List<WalletPrepareTransferAsset> assets,
  ) {
    return Builder(
      builder: (context) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: DefaultAppBar(
              titleText: walletName,
              subtitleBottomText: account.address.toEllipseString(),
            ),
            body: Builder(
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DimensSize.d16,
                  ),
                  child: WalletPrepareTransferView(
                    account: account,
                    selectedCustodian: selectedCustodian,
                    localCustodians: localCustodians,
                    selectedAsset: selectedAsset,
                    assets: assets,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _defaultBody([Widget? body]) {
    return Scaffold(
      appBar: const DefaultAppBar(),
      body: body,
    );
  }

  Widget _emptyText() {
    return Builder(
      builder: (context) {
        final colors = context.themeStyle.colors;

        return Center(
          child: Text(
            LocaleKeys.accountNotFound.tr(args: [address.address]),
            style: StyleRes.primaryBold.copyWith(color: colors.textPrimary),
          ),
        );
      },
    );
  }
}
