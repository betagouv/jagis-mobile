import 'dart:ui';

import 'package:app/core/assets/images.dart';
import 'package:app/core/infrastructure/markdown.dart';
import 'package:app/core/infrastructure/svg.dart';
import 'package:app/core/presentation/widgets/animation_shake.dart';
import 'package:app/core/presentation/widgets/composants/card.dart';
import 'package:app/core/presentation/widgets/composants/loader.dart';
import 'package:app/features/actions_recommanded/infrastructure/actions_recommanded_manager.dart';
import 'package:app/features/know_your_customer/core/domain/question_code.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/question_controller.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/question_form.dart';
import 'package:app/features/questions_manager/bloc/questions_manager_bloc.dart';
import 'package:app/features/questions_manager/bloc/questions_manager_event.dart';
import 'package:app/features/questions_manager/bloc/questions_manager_state.dart';
import 'package:app/features/theme/core/domain/theme_info.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionsRecommandedSection extends StatelessWidget {
  const ActionsRecommandedSection({super.key, required this.theme});

  final ThemeInfo theme;

  @override
  Widget build(final BuildContext context) => ColoredBox(
    color: const Color(0xFFF3EDE5),
    child: Padding(
      padding: const EdgeInsets.only(
        left: DsfrSpacings.s2w,
        top: DsfrSpacings.s4w,
        right: DsfrSpacings.s2w,
        bottom: DsfrSpacings.s6w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(Localisation.mesActionsRecommandees, style: DsfrTextStyle.headline3()),
          const SizedBox(height: DsfrSpacings.s1w),
          const Text(Localisation.mesActionsRecommandeesDescription, style: DsfrTextStyle.bodyMd()),
          const SizedBox(height: DsfrSpacings.s2w),
          if (theme.isQuestionsNeeded) _QuestionsPart(sequenceId: theme.sequenceId),
        ],
      ),
    ),
  );
}

class _QuestionsPart extends StatelessWidget {
  const _QuestionsPart({required this.sequenceId});

  final String sequenceId;

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create:
        (final context) =>
            QuestionsManagerBloc(application: ActionsRecommandedQuestionsManager(client: context.read(), sequenceId: sequenceId))
              ..add(const QuestionsManagerFirstQuestionRequested()),
    child: const _Questions(),
  );
}

class _Questions extends StatelessWidget {
  const _Questions();

  @override
  Widget build(final BuildContext context) => BlocBuilder<QuestionsManagerBloc, QuestionsManagerState>(
    builder:
        (final context, final state) => switch (state) {
          QuestionsManagerInitial() => const SizedBox.shrink(),
          QuestionsManagerLoadSuccess() => _QuestionsSuccess(data: state),
        },
  );
}

class _QuestionsSuccess extends StatefulWidget {
  const _QuestionsSuccess({required this.data});

  final QuestionsManagerLoadSuccess data;

  @override
  State<_QuestionsSuccess> createState() => _QuestionsSuccessState();
}

class _QuestionsSuccessState extends State<_QuestionsSuccess> {
  var _isExpanded = true;

  @override
  Widget build(final BuildContext context) {
    final cursor = widget.data.cursor;
    final element = cursor.element;
    if (element == null) {
      return const Column(
        children: [FnvLoader(), Text('Nous préparons vos recommandations personnalisées...', style: DsfrTextStyle.bodyLg())],
      );
    }
    final question = ColoredBox(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(DsfrSpacings.s2w),
        child: Column(
          spacing: DsfrSpacings.s4w,
          children: [
            DsfrStepper(title: element.label, current: cursor.index + 1, total: cursor.total),
            _QuestionWidget(key: ValueKey(element), code: element.code),
          ],
        ),
      ),
    );

    return _isExpanded
        ? Stack(
          children: [
            ImageFiltered(imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), child: question),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s4w),
                child: _GetStarted(onPressed: () => setState(() => _isExpanded = false)),
              ),
            ),
          ],
        )
        : question;
  }
}

class _QuestionWidget extends StatefulWidget {
  const _QuestionWidget({super.key, required this.code});

  final QuestionCode code;

  @override
  State<_QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<_QuestionWidget> {
  final _controller = QuestionController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(final context) => Column(
    spacing: DsfrSpacings.s3w,
    children: [
      QuestionForm(
        questionId: widget.code.value,
        withoutTitle: true,
        controller: _controller,
        onSaved: () {
          context.read<QuestionsManagerBloc>().add(const QuestionsManagerNextRequested());
        },
      ),
      Row(
        spacing: DsfrSpacings.s1w,
        children: [
          DsfrButtonIcon(
            icon: DsfrIcons.systemArrowLeftLine,
            semanticLabel: Localisation.questionPrecedente,
            variant: DsfrButtonVariant.secondary,
            size: DsfrButtonSize.lg,
            onPressed: () => context.read<QuestionsManagerBloc>().add(const QuestionsManagerPreviousRequested()),
          ),
          DsfrButton(
            label: Localisation.questionSuivante,
            variant: DsfrButtonVariant.primary,
            size: DsfrButtonSize.lg,
            onPressed: _controller.save,
          ),
        ],
      ),
    ],
  );
}

class _GetStarted extends StatelessWidget {
  const _GetStarted({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(final context) => FnvCard(
    child: Padding(
      padding: const EdgeInsets.only(
        left: DsfrSpacings.s3w,
        top: DsfrSpacings.s3w,
        right: DsfrSpacings.s3w,
        bottom: DsfrSpacings.s4w,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(Localisation.envieDAvoirUnVraiImpact, style: DsfrTextStyle.headline5()),
          const SizedBox(height: DsfrSpacings.s1v),
          const FnvMarkdown(data: Localisation.envieDAvoirUnVraiImpactDescription, p: DsfrTextStyle.bodyMd()),
          const SizedBox(height: DsfrSpacings.s2w),
          AnimationShake(
            child: DsfrRawButton(
              variant: DsfrButtonVariant.primary,
              size: DsfrButtonSize.lg,
              onPressed: onPressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Flexible(child: Text(Localisation.commencer)),
                  const SizedBox(width: DsfrSpacings.s1w),
                  FnvSvg.asset(AssetImages.leaf),
                  const Text('+90'),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
