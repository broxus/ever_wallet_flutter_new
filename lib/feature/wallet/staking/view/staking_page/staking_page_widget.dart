import 'package:app/app/router/router.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/staking/models/models.dart';
import 'package:app/feature/wallet/staking/staking.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/widgets.dart';

/// Page that allows user to stake his native token.
class StakingPageWidget extends ElementaryWidget<StakingPageWidgetModel> {
  const StakingPageWidget({
    required this.accountAddress,
    Key? key,
    WidgetModelFactory wmFactory = defaultStakingPageWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final Address accountAddress;

  @override
  Widget build(StakingPageWidgetModel wm) {
    final theme = wm.theme;

    return GestureDetector(
      onTap: wm.unfocus,
      child: Scaffold(
        appBar: const DefaultAppBar(),
        body: BlocProvider(
          create: (_) => ActionStakingBloc(
            accountAddress: accountAddress,
            nekotonRepository: inject(),
            stakingService: inject(),
            storage: inject(),
          )..add(const ActionStakingBlocEvent.init()),
          child: Stack(
            children: [
              Positioned.fill(
                bottom: DimensSizeV2.d90,
                child: _StakingViewWidget(wm: wm),
              ),
              Positioned(
                bottom: DimensSizeV2.d0,
                right: DimensSizeV2.d0,
                left: DimensSizeV2.d0,
                child: Container(
                  padding: const EdgeInsets.all(DimensSizeV2.d16),
                  color: theme.colors.background0,
                  child: _ButtonWidget(wm: wm),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StakingViewWidget extends StatelessWidget {
  const _StakingViewWidget({
    required this.wm,
  });

  final StakingPageWidgetModel wm;

  @override
  Widget build(BuildContext context) {
    final theme = wm.theme;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: DimensSizeV2.d16,
        vertical: DimensSizeV2.d8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.simpleLiquidStaking.tr(),
            style: theme.textStyles.headingXLarge,
          ),
          const SizedBox(height: DimensSizeV2.d12),
          EntityStateNotifierBuilder(
            listenableEntityState: wm.info,
            loadingBuilder: (_, __) => const Center(
              child: Padding(
                padding: EdgeInsets.all(DimensSizeV2.d16),
                child: CommonCircularProgressIndicator(
                  size: CircularIndicatorSize.large,
                ),
              ),
            ),
            errorBuilder: (_, __, ___) => Center(
              child: Padding(
                padding: const EdgeInsets.all(DimensSizeV2.d16),
                child: Text(
                  LocaleKeys.stakingInitError.tr(),
                  style: theme.textStyles.paragraphMedium.copyWith(
                    color: theme.colors.negative,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            builder: (_, info) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: LocaleKeys.stakeEverReceiverStever.tr(
                          args: [
                            wm.currency.symbol,
                            info?.tokenWallet.symbol.name ?? '',
                          ],
                        ),
                        style: theme.textStyles.paragraphMedium.copyWith(
                          color: theme.colors.content3,
                        ),
                      ),
                      const WidgetSpan(child: SizedBox(width: DimensSizeV2.d4)),
                      TextSpan(
                        text: LocaleKeys.howItWorks.tr(),
                        style: theme.textStyles.paragraphMedium.copyWith(
                          color: theme.colors.primaryA,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = wm.showHowItWorksSheet,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: DimensSizeV2.d24),
                StateNotifierBuilder(
                  listenableState: wm.data,
                  builder: (_, data) => StakingView(
                    info: info!,
                    data: data!,
                    receive: wm.receive,
                    requests: wm.requests,
                    inputController: wm.inputController,
                    onMaxAmount: wm.onMaxAmount,
                    onTabChanged: wm.onTabChanged,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ButtonWidget extends StatelessWidget {
  const _ButtonWidget({
    required this.wm,
  });

  final StakingPageWidgetModel wm;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActionStakingBloc, ActionStakingBlocState>(
      listener: (context, state) {
        state.whenOrNull(
          showHowItWorksSheet: wm.showHowItWorksSheet,
          goStake: (
            payload,
            amount,
            destination,
            sender,
            accountKey,
            attachedFee,
          ) {
            context.goFurther(
              AppRoute.tonWalletSend.pathWithData(
                queryParameters: {
                  tonWalletSendAddressQueryParam: sender.address,
                  tonWalletSendPublicKeyQueryParam: accountKey.publicKey,
                  tonWalletSendCommentQueryParam: payload,
                  tonWalletSendDestinationQueryParam: destination.address,
                  tonWalletSendAmountQueryParam: amount.toString(),
                  tonWalletSendAttachedAmountQueryParam: attachedFee.toString(),
                  tonWalletSendResultMessageQueryParam:
                      LocaleKeys.stEverAppearInMinutes.tr(
                    args: [wm.tokenCurrency?.symbol ?? ''],
                  ),
                },
              ),
            );
          },
          goUnstake: (
            payload,
            amount,
            destination,
            sender,
            accountKey,
            attachedFee,
            withdrawHours,
            stakingRootContractAddress,
          ) {
            context.goFurther(
              AppRoute.tokenWalletSend.pathWithData(
                queryParameters: {
                  tokenWalletSendOwnerQueryParam: sender.address,
                  tokenWalletSendContractQueryParam:
                      stakingRootContractAddress.address,
                  tokenWalletSendPublicKeyQueryParam: accountKey.publicKey,
                  tokenWalletSendCommentQueryParam: payload,
                  tokenWalletSendDestinationQueryParam: destination.address,
                  tokenWalletSendAmountQueryParam: amount.toString(),
                  tokenWalletSendAttachedAmountQueryParam:
                      attachedFee.toString(),
                  tokenWalletSendResultMessageQueryParam:
                      LocaleKeys.withdrawHoursProgress.tr(
                    args: [wm.currency.symbol, withdrawHours.toString()],
                  ),
                },
              ),
            );
          },
        );
      },
      builder: (_, actionState) {
        final isLoading = actionState.maybeWhen(
          inProgress: () => true,
          orElse: () => false,
        );

        return ValueListenableBuilder(
          valueListenable: wm.tab,
          builder: (_, tab, __) => StateNotifierBuilder(
            listenableState: wm.validation,
            builder: (_, validation) => _InnerButtonWidget(
              tab: tab,
              isLoading: isLoading,
              validation: validation,
              onSubmit: wm.onSubmit,
            ),
          ),
        );
      },
    );
  }
}

class _InnerButtonWidget extends StatelessWidget {
  const _InnerButtonWidget({
    required this.tab,
    required this.isLoading,
    required this.validation,
    required this.onSubmit,
  });

  final StakingTab tab;
  final bool isLoading;
  final ValidationState? validation;
  final void Function(ActionStakingBloc) onSubmit;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final title = switch (tab) {
      StakingTab.stake => LocaleKeys.stakeWord.tr(),
      StakingTab.unstake => LocaleKeys.unstakeWord.tr(),
      _ => null,
    };

    if (title == null) return const SizedBox.shrink();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (validation?.message != null)
          Padding(
            padding: const EdgeInsets.only(
              bottom: DimensSizeV2.d8,
            ),
            child: PrimaryCard(
              padding: const EdgeInsets.all(DimensSizeV2.d16),
              borderRadius: BorderRadius.circular(DimensRadiusV2.radius16),
              color: theme.colors.backgroundNegative,
              child: Text(
                validation!.message!,
                style: theme.textStyles.labelSmall.copyWith(
                  color: theme.colors.contentNegative,
                ),
              ),
            ),
          ),
        AccentButton(
          buttonShape: ButtonShape.pill,
          title: title,
          isLoading: isLoading,
          onPressed: (validation?.isValid ?? false)
              ? () => onSubmit(context.read<ActionStakingBloc>())
              : null,
        ),
      ],
    );
  }
}
