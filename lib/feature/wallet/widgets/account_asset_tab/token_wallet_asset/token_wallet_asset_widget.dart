import 'package:app/app/router/router.dart';
import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/token_wallet_asset/token_wallet_asset_cubit.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/token_wallet_asset/token_wallet_icon.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/wallet_asset_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Widget that stores information about additional token and display its
/// balances.
class TokenWalletAssetWidget extends StatelessWidget {
  const TokenWalletAssetWidget({
    required this.asset,
    required this.owner,
    super.key,
  });

  final TokenContractAsset asset;
  final Address owner;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TokenWalletAssetCubit>(
      create: (_) => TokenWalletAssetCubit(
        owner: owner,
        asset: asset,
        balanceService: inject<BalanceService>(),
        currencyConvertService: inject<CurrencyConvertService>(),
        nekotonRepository: inject<NekotonRepository>(),
        balanceStorage: inject(),
      ),
      child: BlocBuilder<TokenWalletAssetCubit, TokenWalletAssetState>(
        builder: (context, state) {
          return state.when(
            data: (fiatBalance, tokenBalance) {
              return WalletAssetWidget(
                tokenBalance: tokenBalance,
                fiatBalance: fiatBalance,
                icon: TokenWalletIconWidget(
                  logoURI: asset.logoURI,
                  address: asset.address,
                  version: asset.version,
                ),
                onPressed: () => context.goFurther(
                  AppRoute.tokenWalletDetails.pathWithData(
                    pathParameters: {
                      tokenWalletDetailsOwnerAddressPathParam: owner.address,
                      tokenWalletDetailsContractAddressPathParam:
                          asset.address.address,
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
