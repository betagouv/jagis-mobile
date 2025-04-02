import 'package:app/core/presentation/widgets/composants/question_stepper.dart';
import 'package:app/features/action/domain/action.dart';
import 'package:app/features/actions/domain/action_type.dart';
import 'package:app/features/car_simulator/presentation/car_simulator_result/bloc/car_simulator_result_bloc.dart';
import 'package:app/features/car_simulator/presentation/car_simulator_result/bloc/car_simulator_result_event.dart';
import 'package:app/features/car_simulator/presentation/car_simulator_result/widgets/car_simulator_result.dart';
import 'package:app/features/know_your_customer/core/domain/question.dart';
import 'package:app/features/know_your_customer/core/domain/question_code.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/input_controller.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/question_controller.dart';
import 'package:app/features/know_your_customer/detail/presentation/form/question_form.dart';
import 'package:app/features/questions_manager/bloc/questions_manager_bloc.dart';
import 'package:app/features/questions_manager/bloc/questions_manager_event.dart';
import 'package:app/features/questions_manager/bloc/questions_manager_state.dart';
import 'package:app/features/questions_manager/domain/cursor.dart';
import 'package:app/features/questions_manager/infrastructure/questions_manager.dart';
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
        (final context) => QuestionsManagerBloc(
          application: QuestionsManager(
            client: context.read(),
            type: ActionType.simulator,
            code: ActionSimulatorId.carSimulator.apiString,
          ),
        )..add(const QuestionsManagerFirstQuestionRequested()),
    child: _View(isDone: isDone),
  );
}

class _View extends StatelessWidget {
  const _View({required this.isDone});

  final bool isDone;

  @override
  Widget build(final context) => BlocConsumer<QuestionsManagerBloc, QuestionsManagerState>(
    builder:
        (final context, final state) => switch (state) {
          QuestionsManagerInitial() => const SizedBox.shrink(),
          QuestionsManagerLoadSuccess() => _Success(questionManager: state, isDone: isDone),
          QuestionManagerFinished() => const CarSimulatorResult(),
        },
    listener: (final context, final state) {
      if (state is QuestionManagerFinished) {
        context.read<CarSimulatorResultBloc>().add(const CarSimulatorGetCurrentCarResult());
      }
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: DsfrSpacings.s1v,
        children: [
          if (isDone)
            Padding(
              padding: const EdgeInsets.only(bottom: DsfrSpacings.s4w),
              child: DsfrAlert(
                severity: DsfrAlertSeverity.info,
                description: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Vous avez déjà fait ce simulateur', style: DsfrTextStyle.bodyMd()),
                    DsfrLink.md(
                      label: 'Voir mes résultats',
                      onTap: () => context.read<QuestionsManagerBloc>().add(const QuestionsManagerLastQuestionRequested()),
                    ),
                  ],
                ),
              ),
            ),
          QuestionStepper(current: cursor.index + 1, total: cursor.total),
          _QuestionWidget(key: ValueKey(cursor.element), code: cursor.element!.code, cursor: cursor),
        ],
      ),
    );
  }
}

class _QuestionWidget extends StatefulWidget {
  const _QuestionWidget({super.key, required this.code, required this.cursor});

  final QuestionCode code;
  final Cursor<Question> cursor;

  @override
  State<_QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<_QuestionWidget> {
  final _questionController = QuestionController();
  final _inputController = InputController();

  @override
  void dispose() {
    _questionController.dispose();
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(final context) => Column(
    spacing: DsfrSpacings.s3w,
    children: [
      QuestionForm(
        questionId: widget.code.value,
        questionController: _questionController,
        inputController: _inputController,
        onSaved: () {
          context.read<QuestionsManagerBloc>().add(const QuestionsManagerNextRequested());
        },
      ),
      _ButtonsControllerWidget(cursor: widget.cursor, questionController: _questionController, inputController: _inputController),
    ],
  );
}

class _ButtonsControllerWidget extends StatefulWidget {
  const _ButtonsControllerWidget({required this.cursor, required this.questionController, required this.inputController});

  final Cursor<Question> cursor;
  final QuestionController questionController;
  final InputController inputController;

  @override
  State<_ButtonsControllerWidget> createState() => _ButtonsControllerWidgetState();
}

class _ButtonsControllerWidgetState extends State<_ButtonsControllerWidget> {
  var _inputIsEmpty = false;

  @override
  void initState() {
    super.initState();
    widget.inputController.addListener(_listener);
  }

  void _listener() => setState(() {
    _inputIsEmpty = widget.inputController.isEmpty;
  });

  @override
  void dispose() {
    widget.inputController.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(final context) => Row(
    children: [
      if (!widget.cursor.isStart)
        DsfrButtonIcon(
          icon: DsfrIcons.systemArrowLeftLine,
          semanticLabel: Localisation.questionPrecedente,
          variant: DsfrButtonVariant.tertiaryWithoutBorder,
          size: DsfrButtonSize.lg,
          onPressed: () => context.read<QuestionsManagerBloc>().add(const QuestionsManagerPreviousRequested()),
        ),
      if (_inputIsEmpty)
        DsfrButton(
          label: Localisation.passerLaQuestion,
          variant: DsfrButtonVariant.secondary,
          size: DsfrButtonSize.lg,
          onPressed: () => context.read<QuestionsManagerBloc>().add(const QuestionsManagerNextRequested()),
        )
      else
        DsfrButton(
          label: Localisation.questionSuivante,
          variant: DsfrButtonVariant.primary,
          size: DsfrButtonSize.lg,
          onPressed: widget.questionController.save,
        ),
    ],
  );
}
