import 'package:app/app/router/router.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/widgets.dart';

/// Page that allows user to stake his native token.
class StakingPage extends StatelessWidget {
  const StakingPage({
    required this.accountAddress,
    super.key,
  });

  final Address accountAddress;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const DefaultAppBar(),
        body: BlocProvider<ActionStakingBloc>(
          create: (_) => ActionStakingBloc(
            accountAddress: accountAddress,
            nekotonRepository: inject(),
            stakingService: inject(),
            storage: inject(),
          )..add(const ActionStakingBlocEvent.init()),
          child: BlocProvider<StakingBloc>(
            create: (context) => StakingBloc(
              context: context,
              accountAddress: accountAddress,
              nekotonRepository: inject(),
              currencyConvert: inject(),
              currenciesService: inject(),
              stakingService: inject(),
              actionBloc: context.read<ActionStakingBloc>(),
            )..add(const StakingBlocEvent.init()),
            child: Stack(
              children: [
                Positioned.fill(
                  bottom: DimensSizeV2.d90,
                  child: _stakingViewBuilder(),
                ),
                Positioned(
                  bottom: DimensSizeV2.d0,
                  right: DimensSizeV2.d0,
                  left: DimensSizeV2.d0,
                  child: Container(
                    padding: const EdgeInsets.all(DimensSizeV2.d16),
                    color: theme.colors.background0,
                    child: _buttonBuilder(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: long-method
  Widget _stakingViewBuilder() {
    return Builder(
      builder: (context) {
        final theme = context.themeStyleV2;

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
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: LocaleKeys.stakeEverReceiverStever.tr(),
                      style: theme.textStyles.paragraphMedium.copyWith(
                        color: theme.colors.content3,
                      ),
                    ),
                    const WidgetSpan(
                      child: SizedBox(width: DimensSizeV2.d4),
                    ),
                    TextSpan(
                      text: LocaleKeys.howItWorks.tr(),
                      style: theme.textStyles.paragraphMedium.copyWith(
                        color: theme.colors.primaryA,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => showStEverHowItWorksSheet(context),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: DimensSizeV2.d24),
              BlocBuilder<StakingBloc, StakingBlocState>(
                builder: (context, state) {
                  return state.when(
                    preparing: () => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(DimensSizeV2.d16),
                        child: CommonCircularProgressIndicator(
                          size: CircularIndicatorSize.large,
                        ),
                      ),
                    ),
                    subscribeError: (error) => Center(
                      child: WalletSubscribeErrorWidget(error: error),
                    ),
                    initError: () => Center(
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
                    data: StakingView.new,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // ignore: long-method
  Widget _buttonBuilder() {
    return BlocConsumer<ActionStakingBloc, ActionStakingBlocState>(
      listener: (context, state) {
        state.whenOrNull(
          showHowItWorksSheet: () => showStEverHowItWorksSheet(context),
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
                      LocaleKeys.stEverAppearInMinutes.tr(),
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
                  tokenWalletSendResultMessageQueryParam: LocaleKeys
                      .withdrawHoursProgress
                      .tr(args: [withdrawHours.toString()]),
                },
              ),
            );
          },
        );
      },
      builder: (context, actionState) {
        final isLoading = actionState.maybeWhen(
          inProgress: () => true,
          orElse: () => false,
        );

        return BlocBuilder<StakingBloc, StakingBlocState>(
          builder: (context, state) {
            final (text, canPress) = state.maybeWhen(
              data: (
                type,
                _,
                __,
                canSubmitAction,
                ___,
                ____,
                _____,
                ______,
                _______,
                ________,
                _________,
                __________,
                ___________,
              ) =>
                  switch (type) {
                StakingPageType.stake => (
                    LocaleKeys.stakeWord.tr(),
                    canSubmitAction,
                  ),
                StakingPageType.unstake => (
                    LocaleKeys.unstakeWord.tr(),
                    canSubmitAction,
                  ),
                StakingPageType.inProgress => (null, false),
              },
              orElse: () => (null, false),
            );

            if (text == null) return const SizedBox.shrink();

            return AccentButton(
              buttonShape: ButtonShape.pill,
              title: text,
              isLoading: isLoading,
              onPressed: canPress
                  ? () => context
                      .read<StakingBloc>()
                      .add(const StakingBlocEvent.doAction())
                  : null,
            );
          },
        );
      },
    );
  }
}
