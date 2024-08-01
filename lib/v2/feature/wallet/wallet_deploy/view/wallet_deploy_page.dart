import 'package:app/app/router/router.dart';
import 'package:app/di/di.dart';
import 'package:app/v2/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Page that allows deploy wallet with [address] and [publicKey]
class WalletDeployPage extends StatelessWidget {
  const WalletDeployPage({
    required this.address,
    required this.publicKey,
    super.key,
  });

  final Address address;
  final PublicKey publicKey;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WalletDeployBloc(
        address: address,
        publicKey: publicKey,
        nekotonRepository: inject(),
      ),
      child: BlocConsumer<WalletDeployBloc, WalletDeployState>(
        listener: (context, state) {
          state.whenOrNull(
            deployed: (_, __, ___, ____, _____) =>
                context.goNamed(AppRoute.wallet.name),
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            subscribeError: (error) => _scaffold(
              WalletSubscribeErrorWidget(error: error),
            ),
            standard: () => _scaffold(const WalletDeployStandardBody()),
            multisig: (custodians, requireConfirmations) => _scaffold(
              WalletDeployMultisigBody(
                custodians: custodians,
                requireConfirmations: requireConfirmations,
              ),
            ),
            calculatingError:
                (error, fee, balance, custodians, requireConfirmations) =>
                    _scaffold(
              WalletDeployConfirmView(
                publicKey: publicKey,
                balance: balance,
                feeError: error,
                fee: fee,
                custodians: custodians,
                requireConfirmations: requireConfirmations,
              ),
              canPrev: true,
            ),
            readyToDeploy: (fee, balance, custodians, requireConfirmations) =>
                _scaffold(
              WalletDeployConfirmView(
                publicKey: publicKey,
                balance: balance,
                fee: fee,
                custodians: custodians,
                requireConfirmations: requireConfirmations,
              ),
              canPrev: true,
            ),
            deployed:
                (fee, balance, transaction, custodians, requireConfirmations) =>
                    _scaffold(
              WalletDeployConfirmView(
                publicKey: publicKey,
                balance: balance,
                fee: fee,
                custodians: custodians,
                requireConfirmations: requireConfirmations,
              ),
            ),
            deploying: (canClose) => Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(DimensSize.d16),
                child: TransactionSendingWidget(canClose: canClose),
              ),
            ),
            orElse: () => _scaffold(const SizedBox(), canPrev: true),
          );
        },
      ),
    );
  }

  Widget _scaffold(Widget body, {bool canPrev = false}) {
    return Builder(
      builder: (context) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: DefaultAppBar(
              titleText: canPrev
                  ? LocaleKeys.deployWallet.tr()
                  : LocaleKeys.selectWalletType.tr(),
              // ignore: prefer-extracting-callbacks
              onClosePressed: (context) {
                if (canPrev) {
                  context
                      .read<WalletDeployBloc>()
                      .add(const WalletDeployEvent.goPrevStep());
                } else {
                  context.pop();
                }
              },
            ),
            body: body,
          ),
        );
      },
    );
  }
}
