import 'package:app/app/router/router.dart';
import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/account_asset_tab_cubit.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/token_wallet_asset/token_wallet_asset_widget.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/ton_wallet_asset/ton_wallet_asset_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Tab from <WalletBottomPanel> that allows display list of assets(tokens)
/// related to [account] and manage them.
class AccountAssetsTab extends StatelessWidget {
  const AccountAssetsTab({
    required this.account,
    super.key,
  });

  final KeyAccount account;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountAssetTabCubit>(
      create: (_) => AccountAssetTabCubit(
        account,
        inject<AssetsService>(),
      ),
      child: BlocBuilder<AccountAssetTabCubit, AccountAssetTabState>(
        builder: (context, state) {
          final assets = state.when(
            empty: () => <Widget>[],
            accounts: (tonWallet, contracts) {
              return <Widget>[
                TonWalletAssetWidget(tonWallet: tonWallet),
                ...?contracts?.map(
                  (e) => TokenWalletAssetWidget(
                    key: ValueKey(e.address),
                    asset: e,
                    owner: tonWallet.address,
                  ),
                ),
              ];
            },
          );

          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: assets.length + 1,
            separatorBuilder: (_, __) => const SizedBox(height: DimensSize.d24),
            itemBuilder: (context, index) {
              if (index == assets.length) {
                return Padding(
                  padding: const EdgeInsets.only(top: DimensSizeV2.d16),
                  child: PrimaryButton(
                    buttonShape: ButtonShape.pill,
                    title: LocaleKeys.manageAssets.tr(),
                    onPressed: () => context.goFurther(
                      AppRoute.selectNewAsset.pathWithData(
                        pathParameters: {
                          selectNewAssetAddressPathParam:
                              account.address.address,
                        },
                      ),
                    ),
                  ),
                );
              }

              return assets[index];
            },
          );
        },
      ),
    );
  }
}
