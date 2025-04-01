import 'package:app/core/assets/images.dart';
import 'package:app/core/infrastructure/svg.dart';
import 'package:app/features/quiz/presentation/bloc/quizzes/quizzes_bloc.dart';
import 'package:app/features/quiz/presentation/bloc/quizzes/quizzes_event.dart';
import 'package:app/features/quiz/presentation/bloc/quizzes/quizzes_state.dart';
import 'package:app/features/quiz/presentation/widgets/panel.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class QuizzesCompletedWidget extends StatelessWidget {
  const QuizzesCompletedWidget({super.key, required this.completedState, required this.name, required this.congratulatoryText});

  final QuizzesCompleted completedState;
  final String name;
  final String congratulatoryText;

  void _pop(final BuildContext context) => GoRouter.of(context).pop();
  void _repeatQuiz(final BuildContext context) => context.read<QuizzesBloc>().add(const QuizzesRepeatRequested());

  String _getBackText(final BuildContext context) {
    final matches = GoRouter.of(context).routerDelegate.currentConfiguration.matches;

    return matches.any((final element) => element.matchedLocation.contains('actions'))
        ? Localisation.revenirAuCatalogue
        : Localisation.revenirALaThematique;
  }

  @override
  Widget build(final context) {
    final goBackText = _getBackText(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FnvSvg.asset(AssetImages.flags),
        const SizedBox(height: DsfrSpacings.s1w),
        _CompletedQuizTitle(name: name),
        const SizedBox(height: DsfrSpacings.s4w),
        if (completedState.isCompleted)
          _SuccessContent(
            completedState: completedState,
            congratulatoryText: congratulatoryText,
            goBackText: goBackText,
            onGoBack: () => _pop(context),
            onRepeatQuiz: () => _repeatQuiz(context),
          )
        else
          _FailureContent(
            completedState: completedState,
            goBackText: goBackText,
            onGoBack: () => _pop(context),
            onRepeatQuiz: () => _repeatQuiz(context),
          ),
      ],
    );
  }
}

class _CompletedQuizTitle extends StatelessWidget {
  const _CompletedQuizTitle({required this.name});

  final String name;

  @override
  Widget build(final context) => Text.rich(
    TextSpan(
      text: Localisation.vousAvezTermineLeQuiz,
      children: [TextSpan(text: ' "$name"', style: const DsfrTextStyle.bodyLgBold(color: DsfrColors.blueFranceSun113))],
    ),
    style: const DsfrTextStyle.bodyLg(color: DsfrColors.blueFranceSun113),
  );
}

class _SuccessContent extends StatelessWidget {
  const _SuccessContent({
    required this.completedState,
    required this.congratulatoryText,
    required this.goBackText,
    required this.onGoBack,
    required this.onRepeatQuiz,
  });

  final QuizzesCompleted completedState;
  final String congratulatoryText;
  final String goBackText;
  final VoidCallback onGoBack;
  final VoidCallback onRepeatQuiz;

  @override
  Widget build(final context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _ScorePanel(
        scoreText: Localisation.vousAvezObtenuUnScoreOkDe,
        correctAnswerCount: completedState.correctAnswerCount,
        totalQuestionsCount: completedState.totalQuestionsCount,
        backgroundColor: const Color(0xFFFAFCED),
        borderColor: const Color(0xFFCBE1AA),
      ),
      const SizedBox(height: DsfrSpacings.s2w),
      _MessagePanel(message: congratulatoryText),
      const SizedBox(height: DsfrSpacings.s4w),
      _PrimaryButton(label: goBackText, onPressed: onGoBack),
      const SizedBox(height: DsfrSpacings.s2w),
      _SecondaryButton(label: Localisation.recommencerLeQuiz, onPressed: onRepeatQuiz),
    ],
  );
}

class _FailureContent extends StatelessWidget {
  const _FailureContent({
    required this.completedState,
    required this.goBackText,
    required this.onGoBack,
    required this.onRepeatQuiz,
  });

  final QuizzesCompleted completedState;
  final String goBackText;
  final VoidCallback onGoBack;
  final VoidCallback onRepeatQuiz;

  @override
  Widget build(final context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _ScorePanel(
        scoreText: Localisation.vousAvezObtenuUnScoreKoDe,
        correctAnswerCount: completedState.correctAnswerCount,
        totalQuestionsCount: completedState.totalQuestionsCount,
        backgroundColor: const Color(0xFFFEF7F7),
        borderColor: const Color(0xFFFFCACA),
      ),
      const SizedBox(height: DsfrSpacings.s2w),
      const _MessagePanel(message: Localisation.retentezVotreChancePourValiderCetteAction),
      const SizedBox(height: DsfrSpacings.s4w),
      _PrimaryButton(label: Localisation.recommencerLeQuiz, onPressed: onRepeatQuiz),
      const SizedBox(height: DsfrSpacings.s2w),
      _SecondaryButton(label: goBackText, onPressed: onGoBack),
    ],
  );
}

class _ScorePanel extends StatelessWidget {
  const _ScorePanel({
    required this.scoreText,
    required this.correctAnswerCount,
    required this.totalQuestionsCount,
    required this.backgroundColor,
    required this.borderColor,
  });

  final String scoreText;
  final int correctAnswerCount;
  final int totalQuestionsCount;
  final Color backgroundColor;
  final Color borderColor;

  @override
  Widget build(final context) => Panel(
    backgroundColor: backgroundColor,
    borderColor: borderColor,
    child: Text.rich(
      TextSpan(
        text: scoreText,
        children: [TextSpan(text: ' $correctAnswerCount/$totalQuestionsCount', style: const DsfrTextStyle.bodyMdBold())],
      ),
      style: const DsfrTextStyle.bodyMd(),
    ),
  );
}

class _MessagePanel extends StatelessWidget {
  const _MessagePanel({required this.message});

  final String message;

  @override
  Widget build(final context) => Panel(child: Text(message, style: const DsfrTextStyle.bodyMd()));
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(final context) =>
      DsfrButton(label: label, variant: DsfrButtonVariant.primary, size: DsfrButtonSize.lg, onPressed: onPressed);
}

class _SecondaryButton extends StatelessWidget {
  const _SecondaryButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(final context) =>
      DsfrButton(label: label, variant: DsfrButtonVariant.secondary, size: DsfrButtonSize.lg, onPressed: onPressed);
}
