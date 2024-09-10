import 'package:app/app/router/router.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Page that allows user to stake his native token.
class StakingPage extends StatelessWidget {
  const StakingPage({
    required this.accountAddress,
    super.key,
  });

  final Address accountAddress;

  @override
  Widget build(BuildContext context) {
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
                  bottom: commonButtonHeight + DimensSize.d16,
                  child: _stakingViewBuilder(),
                ),
                Positioned(
                  bottom: DimensSize.d16,
                  right: DimensSize.d16,
                  left: DimensSize.d16,
                  child: _buttonBuilder(),
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
        final colors = context.themeStyle.colors;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(DimensSize.d16),
          child: SeparatedColumn(
            separatorSize: DimensSize.d16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.simpleLiquidStaking.tr(),
                style: StyleRes.h1.copyWith(color: colors.textPrimary),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: LocaleKeys.stakeEverReceiverStever.tr(),
                      style: StyleRes.primaryRegular
                          .copyWith(color: colors.textPrimary),
                    ),
                    const WidgetSpan(
                      child: SizedBox(width: DimensSize.d4),
                    ),
                    TextSpan(
                      text: LocaleKeys.howItWorks.tr(),
                      style:
                          StyleRes.primaryRegular.copyWith(color: colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => showStEverHowItWorksSheet(context),
                    ),
                  ],
                ),
              ),
              BlocBuilder<StakingBloc, StakingBlocState>(
                builder: (context, state) {
                  return state.when(
                    preparing: () => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(DimensSize.d16),
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
                        padding: const EdgeInsets.all(DimensSize.d16),
                        child: Text(
                          LocaleKeys.stakingInitError.tr(),
                          style: StyleRes.primaryRegular
                              .copyWith(color: colors.textPrimary),
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
                      .withdrawHousProgress
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
                ____________,
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

            return CommonButton.primary(
              text: text,
              fillWidth: true,
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
