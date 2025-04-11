import 'package:app/core/presentation/widgets/composants/question_stepper.dart';
import 'package:app/features/action/domain/action.dart';
import 'package:app/features/action/infrastructure/action_questions_manager.dart';
import 'package:app/features/actions/domain/action_type.dart';
import 'package:app/features/car_simulator/presentation/car_simulator_result/bloc/car_simulator_result_bloc.dart';
import 'package:app/features/car_simulator/presentation/car_simulator_result/bloc/car_simulator_result_event.dart';
import 'package:app/features/car_simulator/presentation/car_simulator_result/widgets/car_simulator_result.dart';
import 'package:app/features/questions_manager/bloc/questions_manager_bloc.dart';
import 'package:app/features/questions_manager/bloc/questions_manager_event.dart';
import 'package:app/features/questions_manager/bloc/questions_manager_state.dart';
import 'package:app/features/questions_manager/presentation/questions_manager_question_view.dart';
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
          application: ActionQuestionsManager(
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
                type: DsfrAlertType.info,
                description: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(Localisation.vousAvezDejaFaitCeSimulateur, style: DsfrTextStyle.bodyMd()),
                    DsfrLink.md(
                      label: Localisation.voirMesResultats,
                      onTap: () => context.read<QuestionsManagerBloc>().add(const QuestionsManagerLastQuestionRequested()),
                    ),
                  ],
                ),
              ),
            ),
          QuestionStepper(current: cursor.index + 1, total: cursor.total),
          QuestionsManagerQuestionView(key: ValueKey(cursor.element), cursor: cursor),
        ],
      ),
    );
  }
}
