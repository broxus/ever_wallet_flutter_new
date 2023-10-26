import 'package:app/app/router/router.dart';
import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/ton_wallet_asset/ton_wallet_asset_cubit.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/ton_wallet_asset/ton_wallet_icon.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/wallet_asset_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Widget that stores information about native token and display its balance
class TonWalletAssetWidget extends StatelessWidget {
  const TonWalletAssetWidget({
    required this.tonWallet,
    super.key,
  });

  final TonWalletAsset tonWallet;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TonWalletAssetCubit>(
      create: (_) => TonWalletAssetCubit(
        tonWallet: tonWallet,
        balanceService: inject<BalanceService>(),
        currencyConvertService: inject<CurrencyConvertService>(),
        nekotonRepository: inject<NekotonRepository>(),
        balanceStorage: inject(),
      ),
      child: BlocBuilder<TonWalletAssetCubit, TonWalletAssetState>(
        builder: (context, state) {
          return state.when(
            data: (iconPath, fiatBalance, tokenBalance) {
              return WalletAssetWidget(
                tokenBalance: tokenBalance,
                fiatBalance: fiatBalance,
                icon: TonWalletIconWidget(path: iconPath),
                onPressed: () => context.goFurther(
                  AppRoute.tonWalletDetails.pathWithData(
                    pathParameters: {
                      tonWalletDetailsAddressPathParam:
                          tonWallet.address.address,
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
