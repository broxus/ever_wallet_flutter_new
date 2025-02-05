import 'package:app/app/router/router.dart';
import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/account_asset_tab_cubit.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/select_tokens/select_tokens_modal.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/token_wallet_asset/token_wallet_asset_widget.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/ton_wallet_asset/ton_wallet_asset_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/gestures.dart';
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
    required this.isShowingNewTokens,
    required this.confirmImportCallback,
    required this.manifestUrl,
    super.key,
  });

  final KeyAccount account;
  final bool isShowingNewTokens;
  final VoidCallback confirmImportCallback;
  final String manifestUrl;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return BlocProvider<AccountAssetTabCubit>(
      key: ValueKey(manifestUrl),
      create: (_) => AccountAssetTabCubit(
        account,
        inject<TokenWalletsService>(),
        inject<AssetsService>(),
        isShowingNewTokens: isShowingNewTokens,
      ),
      child: BlocBuilder<AccountAssetTabCubit, AccountAssetTabState>(
        builder: (context, state) {
          final assets = state.when(
            empty: () => <Widget>[],
            accounts: (tonWallet, contracts, _) {
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

          final lastIndex = assets.length - 1;

          return SliverMainAxisGroup(
            slivers: [
              DecoratedSliver(
                decoration: BoxDecoration(
                  color: theme.colors.background1,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(DimensRadiusV2.radius16),
                    bottom: Radius.circular(DimensRadiusV2.radius16),
                  ),
                ),
                sliver: SliverList.separated(
                  itemCount: assets.length,
                  separatorBuilder: (_, index) {
                    if (index == lastIndex) {
                      return const SizedBox(height: DimensSizeV2.d12);
                    }
                    return Container(
                      height: DimensSize.d24,
                      color: theme.colors.background1,
                    );
                  },
                  itemBuilder: (context, index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: theme.colors.background1,
                        borderRadius: BorderRadius.vertical(
                          top: index == 0
                              ? const Radius.circular(DimensRadiusV2.radius16)
                              : Radius.zero,
                          bottom: index == lastIndex
                              ? const Radius.circular(DimensRadiusV2.radius16)
                              : Radius.zero,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: index == 0 ? DimensSizeV2.d16 : 0,
                          bottom: index == lastIndex ? DimensSizeV2.d16 : 0,
                        ),
                        child: assets[index],
                      ),
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: _FooterAssetsWidget(
                  address: account.address,
                  isShowingNewTokens: isShowingNewTokens,
                  confirmImportCallback: confirmImportCallback,
                  numberNewTokens: state.when(
                    empty: () => null,
                    accounts: (_, __, newTokens) => newTokens,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _FooterAssetsWidget extends StatelessWidget {
  const _FooterAssetsWidget({
    required this.address,
    required this.isShowingNewTokens,
    required this.confirmImportCallback,
    required this.numberNewTokens,
  });

  final Address address;
  final bool isShowingNewTokens;
  final VoidCallback confirmImportCallback;
  final int? numberNewTokens;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: DimensSizeV2.d6),
        if (isShowingNewTokens && numberNewTokens == null)
          const ProgressIndicatorWidget(size: DimensSizeV2.d18),
        if (isShowingNewTokens && (numberNewTokens ?? 0) > 0)
          Padding(
            padding: const EdgeInsets.only(top: DimensSizeV2.d6),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: theme.textStyles.paragraphSmall,
                children: [
                  TextSpan(
                    text: LocaleKeys.newTokensLabel
                        .tr(args: ['$numberNewTokens']),
                    style: theme.textStyles.paragraphSmall
                        .copyWith(color: theme.colors.content0),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        showSelectTokesModal(
                          context,
                          address,
                          confirmImportCallback,
                        );
                      },
                  ),
                  TextSpan(
                    text: ' ${LocaleKeys.foundInThisAccountLabel.tr()}',
                  ),
                  const TextSpan(
                    text: '\n',
                  ),
                ],
              ),
            ),
          ),
        Text(
          LocaleKeys.dontSeeYourToken.tr(),
          style: theme.textStyles.paragraphSmall,
        ),
        const SizedBox(height: DimensSizeV2.d2),
        SeparatedRow(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                showSelectTokesModal(
                  context,
                  address,
                  confirmImportCallback,
                );
              },
              child: Text(
                LocaleKeys.refreshToFind.tr(),
                style: theme.textStyles.labelSmall,
              ),
            ),
            Text(
              LocaleKeys.orWord.tr(),
              style: theme.textStyles.paragraphSmall,
            ),
            GestureDetector(
              onTap: () => context.goFurther(
                AppRoute.selectNewAsset.pathWithData(
                  pathParameters: {
                    selectNewAssetAddressPathParam: address.address,
                  },
                ),
              ),
              child: Text(
                LocaleKeys.manageAssets.tr(),
                style: theme.textStyles.labelSmall,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
