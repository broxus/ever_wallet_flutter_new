import 'package:app/feature/add_seed_to_app/check_seed_phrase/check_seed_phrase.dart';
import 'package:app/feature/onboarding/widgets/onboarding_app_bar.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Callback that will be called when user correctly check seed phrase.
/// And navigation will be called to go to correct screen.
typedef CheckSeedPhraseNavigationCallback = void Function(BuildContext context);

/// Screen that allows user to check seed phrase for correctness.
class CheckSeedPhraseView extends StatefulWidget {
  const CheckSeedPhraseView({
    required this.phrase,
    required this.navigateToPassword,
    super.key,
  });

  /// Seed phrase that must be checked
  final List<String> phrase;

  /// Action that will be called when user correctly check seed phrase.
  final CheckSeedPhraseNavigationCallback navigateToPassword;

  @override
  State<CheckSeedPhraseView> createState() => _CheckSeedPhraseViewState();
}

class _CheckSeedPhraseViewState extends State<CheckSeedPhraseView> {
  late CheckSeedPhraseCubit cubit;

  @override
  void initState() {
    cubit = CheckSeedPhraseCubit(widget.phrase, _navigateToPassword)
      ..initAnswers();
    super.initState();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  void _navigateToPassword() => widget.navigateToPassword(context);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.themeStyle.colors;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: OnboardingAppBar(
        actions: [
          CommonButton.ghostNoPadding(
            text: l10n.skip_word,
            onPressed: _navigateToPassword,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.check_seed_phrase,
                style: StyleRes.pageTitle.copyWith(color: colors.textPrimary),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.check_seed_phrase_correctly,
                style: StyleRes.bodyText.copyWith(color: colors.textSecondary),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: BlocBuilder<CheckSeedPhraseCubit,
                    CheckSeedPhraseCubitState>(
                  bloc: cubit,
                  builder: (context, state) => state.when(
                    initial: Container.new,
                    answer: (available, user, index) => _buildCheckBody(
                      available,
                      user,
                      l10n,
                      colors,
                      currentIndex: index,
                    ),
                    correct: (available, user) => _buildCheckBody(
                      available,
                      user,
                      l10n,
                      colors,
                    ),
                    error: (available, user) => _buildCheckBody(
                      available,
                      user,
                      l10n,
                      colors,
                      isError: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckBody(
    List<String> available,
    List<CheckSeedCorrectAnswer> userAnswers,
    AppLocalizations localization,
    ColorsPalette colors, {
    int? currentIndex,
    bool isError = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckSeedAnswersWidget(
          userAnswers: userAnswers,
          currentIndex: currentIndex,
          clearAnswer: cubit.clearAnswer,
        ),
        if (isError)
          Text(
            localization.seed_is_wrong,
            style: StyleRes.bodyText.copyWith(color: colors.textNegative),
          ),
        const Spacer(),
        CheckSeedAvailableAnswersWidget(
          availableAnswers: available,
          selectedAnswers: userAnswers.map((e) => e.word).toList(),
          selectAnswer: cubit.answerQuestion,
        ),
      ],
    );
  }
}
