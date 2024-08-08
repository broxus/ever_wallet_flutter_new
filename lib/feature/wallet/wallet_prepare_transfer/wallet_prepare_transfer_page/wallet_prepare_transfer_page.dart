import 'package:app/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page/data/wallet_prepare_transfer_asset.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page/data/wallet_prepare_transfer_data.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page/wallet_prepare_transfer_page_wm.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page/widgets/wallet_prepare_transfer_view.dart';
import 'package:app/feature/wallet/widgets/wallet_subscribe_error_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';

class WalletPrepareTransferPage
    extends ElementaryWidget<WalletPrepareTransferPageWidgetModel> {
  WalletPrepareTransferPage({
    required this.address,
    this.rootTokenContract,
    this.tokenSymbol,
    Key? key,
    WidgetModelFactory<WalletPrepareTransferPageWidgetModel>? wmFactory,
  })  : assert(
          rootTokenContract == null && tokenSymbol == null ||
              rootTokenContract != null && tokenSymbol != null,
          // ignore: lines_longer_than_80_chars
          'rootTokenContract and tokenSymbol must be provided or not provided together',
        ),
        super(
          wmFactory ??
              (ctx) => defaultWalletPrepareTransferPageWidgetModelFactory(
                    ctx,
                    address,
                    rootTokenContract,
                  ),
          key: key,
        );

  /// Address of account, that should be used to send funds
  final Address address;

  /// Contract of token (native or not) that will be locked to send funds
  final Address? rootTokenContract;

  /// Symbol that is used together with [rootTokenContract] because native token
  /// and wraped native token has the same contract address and this leads to
  /// error.
  final String? tokenSymbol;

  @override
  Widget build(WalletPrepareTransferPageWidgetModel wm) {
    return EntityStateNotifierBuilder<WalletPrepareTransferData?>(
      listenableEntityState: wm.screenState,
      loadingBuilder: (_, __) => const _DefaultBody(),
      errorBuilder: (_, Exception? error, __) {
        return Center(
          child: WalletSubscribeErrorWidget(error: error ?? ''),
        );
      },
      builder: (_, data) {
        if (data == null || data.isEmpty) {
          return _DefaultBody(
            child: _EmptyText(address: address),
          );
        }

        return _DataBody(
          wm,
          account: data.account,
          selectedCustodian: data.selectedCustodian,
          localCustodians: data.localCustodians,
          selectedAsset: data.selectedAsset,
          assets: data.assets,
          walletName: data.walletName,
        );
      },
    );
  }
}

class _DefaultBody extends StatelessWidget {
  const _DefaultBody({
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(),
      body: child,
    );
  }
}

class _DataBody extends StatelessWidget {
  const _DataBody(
    this._wm, {
    this.account,
    this.localCustodians,
    this.selectedCustodian,
    this.selectedAsset,
    this.assets,
    this.walletName,
  });

  final WalletPrepareTransferPageWidgetModel _wm;
  final KeyAccount? account;
  final List<PublicKey>? localCustodians;
  final PublicKey? selectedCustodian;
  final WalletPrepareTransferAsset? selectedAsset;
  final List<WalletPrepareTransferAsset>? assets;
  final String? walletName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: DefaultAppBar(
          titleText: walletName,
          subtitleBottomText: account?.address.toEllipseString(),
        ),
        body: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DimensSize.d16,
              ),
              child: WalletPrepareTransferView(
                _wm,
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
  }
}

class _EmptyText extends StatelessWidget {
  const _EmptyText({
    required this.address,
  });

  final Address address;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        LocaleKeys.accountNotFound.tr(args: [address.address]),
        style: StyleRes.primaryBold.copyWith(
          color: context.themeStyle.colors.textPrimary,
        ),
      ),
    );
  }
}
