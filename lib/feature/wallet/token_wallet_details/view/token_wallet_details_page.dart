import 'package:app/app/router/router.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Details page of the [TokenWallet], that is used to look though transactions
/// history and to send/receive tokens.
class TokenWalletDetailsPage extends StatefulWidget {
  const TokenWalletDetailsPage({
    required this.owner,
    required this.rootTokenContract,
    super.key,
  });

  final Address owner;
  final Address rootTokenContract;

  @override
  State<TokenWalletDetailsPage> createState() => _TokenWalletDetailsPageState();
}

class _TokenWalletDetailsPageState extends State<TokenWalletDetailsPage> {
  final controller = ScrollController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<TokenWalletDetailsCubit>(
        create: (_) => TokenWalletDetailsCubit(
          owner: widget.owner,
          rootTokenContract: widget.rootTokenContract,
          nekotonRepository: inject(),
          currencyConvertService: inject(),
          balanceService: inject(),
          assetsService: inject(),
        ),
        child: BlocBuilder<TokenWalletDetailsCubit, TokenWalletDetailsState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              empty: () => const SizedBox.shrink(),
              subscribeError: (contractName, error, isLoading) => _Body(
                owner: widget.owner,
                rootTokenContract: widget.rootTokenContract,
                contractName: contractName,
                error: error,
                isLoadingError: isLoading,
                controller: controller,
              ),
              data: (
                contractName,
                tokenBalance,
                fiatBalance,
                canSend,
              ) =>
                  _Body(
                owner: widget.owner,
                rootTokenContract: widget.rootTokenContract,
                contractName: contractName,
                tokenBalance: tokenBalance,
                fiatBalance: fiatBalance,
                canSend: canSend,
                controller: controller,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.owner,
    required this.rootTokenContract,
    required this.contractName,
    required this.controller,
    this.tokenBalance,
    this.fiatBalance,
    this.canSend = false,
    this.error,
    this.isLoadingError = false,
  });

  final Address owner;
  final Address rootTokenContract;
  final String contractName;
  final Money? tokenBalance;
  final Money? fiatBalance;
  final bool canSend;
  final Object? error;
  final bool isLoadingError;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Stack(
            children: [
              const _Background(),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const DefaultAppBar(),
                  Text(
                    contractName,
                    style: theme.textStyles.labelSmall.copyWith(
                      color: theme.colors.content3,
                    ),
                  ),
                  const SizedBox(height: DimensSizeV2.d12),
                  if (tokenBalance != null)
                    AmountWidget.fromMoney(
                      amount: tokenBalance!,
                      includeSymbol: false,
                      style: theme.textStyles.headingXLarge,
                    ),
                  const SizedBox(height: DimensSizeV2.d4),
                  if (fiatBalance != null)
                    AmountWidget.dollars(
                      amount: fiatBalance!,
                      style: theme.textStyles.labelXSmall,
                    ),
                  const SizedBox(height: DimensSizeV2.d16),
                  SizedBox(
                    height: DimensSizeV2.d74,
                    child: SeparatedRow(
                      separator: VerticalDivider(
                        width: DimensStroke.small,
                        thickness: DimensStroke.small,
                        color: theme.colors.borderAlpha,
                      ),
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        WalletActionButton(
                          label: LocaleKeys.receiveWord.tr(),
                          icon: LucideIcons.arrowDown,
                          onPressed: () =>
                              showReceiveFundsSheet(context, owner),
                        ),
                        if (canSend && tokenBalance != null)
                          WalletActionButton(
                            label: LocaleKeys.sendWord.tr(),
                            icon: LucideIcons.arrowUp,
                            onPressed: () => _onSend(context),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: DimensSizeV2.d48),
                ],
              ),
            ],
          ),
        ),
        DecoratedSliver(
          decoration: BoxDecoration(
            color: theme.colors.background0,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(DimensRadiusV2.radius24),
            ),
          ),
          sliver: SliverPadding(
            padding: const EdgeInsets.all(DimensSizeV2.d16),
            sliver: error == null
                ? TokenWalletTransactionsWidget(
                    rootTokenContract: rootTokenContract,
                    owner: owner,
                    scrollController: controller,
                  )
                : null,
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
            color: theme.colors.background0,
            padding: const EdgeInsets.symmetric(
              horizontal: DimensSizeV2.d16,
            ),
            child: error != null
                ? Center(
                    child: WalletSubscribeErrorWidget(
                      error: error!,
                      isLoadingError: isLoadingError,
                      onRetryPressed: (context) =>
                          context.read<TokenWalletDetailsCubit>().retry(),
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }

  void _onSend(BuildContext context) => context.goFurther(
        AppRoute.walletPrepareTransferSpecified.pathWithData(
          pathParameters: {
            walletPrepareTransferAddressPathParam: owner.address,
            walletPrepareTransferRootTokenAddressPathParam:
                rootTokenContract.address,
            walletPrepareTransferSymbolPathParam:
                tokenBalance!.currency.isoCode,
          },
        ),
      );
}

class _Background extends StatelessWidget {
  const _Background();

  @override
  Widget build(BuildContext context) => Positioned.fill(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d28),
            child: Image.asset(
              Assets.images.walletBg.walletBg.path,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
}
