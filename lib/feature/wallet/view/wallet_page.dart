import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/network/network.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Entry point for wallet screen (root tab)
class WalletPage extends StatelessWidget {
  const WalletPage({
    this.initialIndex,
    super.key,
  });

  /// Index of account that should be selected on start
  final int? initialIndex;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WalletCubit(
        inject<CurrentAccountsService>(),
        inject<NekotonRepository>(),
        initialIndex,
      )..init(),
      child: Scaffold(
        appBar: const DefaultAppBar(
          leading: NetworkSelectionCard(),
          leadingWidth: DimensSize.d168,
        ),
        body: BlocBuilder<WalletCubit, WalletState>(
          builder: (context, state) {
            return state.maybeWhen(
              accounts: (
                list,
                currentKey,
                currentAccount,
                controller,
              ) =>
                  WalletView(
                publicKey: currentKey,
                controller: controller,
                list: list,
                currentAccount: currentAccount,
              ),
              orElse: () => const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }
}
