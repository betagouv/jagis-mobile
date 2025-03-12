import 'package:app/features/car_simulator/infrastructure/car_simulator_questions_manager.dart';
import 'package:app/features/car_simulator/presentation/car_simulator_result/bloc/car_simulator_result_bloc.dart';
import 'package:app/features/car_simulator/presentation/car_simulator_result/bloc/car_simulator_result_event.dart';
import 'package:app/features/car_simulator/presentation/car_simulator_result/widgets/car_simulator_result.dart';
import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:app/features/know_your_customer/core/domain/question_code.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/question_controller.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/question_form.dart';
import 'package:app/features/questions_manager/bloc/questions_manager_bloc.dart';
import 'package:app/features/questions_manager/bloc/questions_manager_event.dart';
import 'package:app/features/questions_manager/bloc/questions_manager_state.dart';
import 'package:app/features/questions_manager/domain/cursor.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarSimulatorWidget extends StatelessWidget {
  const CarSimulatorWidget({super.key, this.isDone = false});

  final bool isDone;

  @override
  Widget build(final context) => BlocProvider(
    create:
        (final context) =>
            QuestionsManagerBloc(application: CarSimulatorQuestionsManager(client: context.read()))
              ..add(const QuestionsManagerFirstQuestionRequested()),
    child: _View(isDone: isDone),
  );
}

class _View extends StatelessWidget {
  const _View({required this.isDone});

  final bool isDone;

  @override
  Widget build(final context) => BlocBuilder<QuestionsManagerBloc, QuestionsManagerState>(
    builder:
        (final context, final state) => switch (state) {
          QuestionsManagerInitial() => const SizedBox.shrink(),
          QuestionsManagerLoadSuccess() => _Success(questionManager: state, isDone: isDone),
        },
  );
}

class _Success extends StatelessWidget {
  const _Success({required this.questionManager, required this.isDone});

  final QuestionsManagerLoadSuccess questionManager;
  final bool isDone;

  @override
  Widget build(final context) {
    final cursor = questionManager.cursor;

    if (cursor.isEnd) {
      if (!isDone) {
        context.read<CarSimulatorResultBloc>().add(const CarSimulatorActionMarkAsDone());
      }
      context.read<CarSimulatorResultBloc>().add(const CarSimulatorGetCurrentCarResult());

      return const CarSimulatorResult();
    }

    return Padding(
      padding: const EdgeInsets.all(DsfrSpacings.s2w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: DsfrSpacings.s1v,
        children: [
          if (isDone)
            DsfrButton(
              label: Localisation.allerDirectementAuxResultats,
              icon: DsfrIcons.systemArrowRightLine,
              iconLocation: DsfrButtonIconLocation.right,
              variant: DsfrButtonVariant.secondary,
              size: DsfrButtonSize.md,
              onPressed: () => context.read<QuestionsManagerBloc>().add(const QuestionsManagerLastQuestionRequested()),
            ),
          const SizedBox(height: DsfrSpacings.s2w),
          _QuestionStepper(current: cursor.index + 1, total: cursor.total),
          _QuestionWidget(key: ValueKey(cursor.element), code: cursor.element!.code, cursor: cursor),
        ],
      ),
    );
  }
}

class _QuestionStepper extends StatelessWidget {
  const _QuestionStepper({required this.current, required this.total});

  final int current;
  final int total;

  @override
  Widget build(final context) => Text.rich(
    TextSpan(
      text: 'Question ',
      style: const DsfrTextStyle.bodyLg(color: DsfrColors.blueFranceSun113),
      children: [
        TextSpan(text: '$current sur $total', style: const DsfrTextStyle.bodyLgBold(color: DsfrColors.blueFranceSun113)),
      ],
    ),
  );
}

class _QuestionWidget extends StatefulWidget {
  const _QuestionWidget({super.key, required this.code, required this.cursor});

  final QuestionCode code;
  final Cursor<Question> cursor;

  @override
  State<_QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<_QuestionWidget> {
  final _controller = QuestionController();

  var questionHasBeenEdited = false;

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
        controller: _controller,
        onSaved: () {
          context.read<QuestionsManagerBloc>().add(const QuestionsManagerNextRequested());
        },
        onEdit: () {
          print('onEdit');
          // FIXME: the input is refreshed when the question is edited
          setState(() => questionHasBeenEdited = true);
        },
      ),
      Column(
        children: [
          Row(
            children: [
              if (!widget.cursor.isStart)
                DsfrButtonIcon(
                  icon: DsfrIcons.systemArrowLeftLine,
                  semanticLabel: Localisation.questionPrecedente,
                  variant: DsfrButtonVariant.tertiaryWithoutBorder,
                  size: DsfrButtonSize.lg,
                  onPressed: () => context.read<QuestionsManagerBloc>().add(const QuestionsManagerPreviousRequested()),
                ),
              if (questionHasBeenEdited || widget.cursor.element!.responsesDisplay().isNotEmpty)
                Expanded(
                  child: DsfrButton(
                    label: Localisation.questionSuivante,
                    variant: DsfrButtonVariant.primary,
                    size: DsfrButtonSize.lg,
                    onPressed: _controller.save,
                  ),
                )
              else
                DsfrButton(
                  label: Localisation.passerLaQuestion,
                  variant: DsfrButtonVariant.secondary,
                  size: DsfrButtonSize.lg,
                  onPressed: () => context.read<QuestionsManagerBloc>().add(const QuestionsManagerNextRequested()),
                ),
            ],
          ),
        ],
      ),
    ],
  );
}
