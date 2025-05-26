import 'package:app/core/presentation/widgets/composants/question_stepper.dart';
import 'package:app/core/question_flow/bloc/question_flow_bloc.dart';
import 'package:app/core/question_flow/bloc/question_flow_event.dart';
import 'package:app/core/question_flow/bloc/question_flow_state.dart';
import 'package:app/core/question_flow/infrastructure/question_flow_manager.dart';
import 'package:app/core/question_flow/presentation/questions_manager_question_view.dart';
import 'package:app/features/car_simulator/presentation/car_simulator_result/bloc/car_simulator_result_bloc.dart';
import 'package:app/features/car_simulator/presentation/car_simulator_result/bloc/car_simulator_result_event.dart';
import 'package:app/features/car_simulator/presentation/car_simulator_result/widgets/car_simulator_result.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarSimulatorWidget extends StatelessWidget {
  const CarSimulatorWidget({super.key, required this.sequenceId, this.isDone = false});

  final String sequenceId;
  final bool isDone;

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (final context) =>
        QuestionFlowBloc(QuestionFlowManager(context.read(), sequenceId: sequenceId))..add(const QuestionFlowFirstRequested()),
    child: _View(isDone: isDone),
  );
}

class _View extends StatelessWidget {
  const _View({required this.isDone});

  final bool isDone;

  @override
  Widget build(final BuildContext context) => BlocConsumer<QuestionFlowBloc, QuestionFlowState>(
    builder: (final context, final state) => switch (state) {
      QuestionFlowInitial() => const SizedBox.shrink(),
      QuestionFlowLoadSuccess() => _Success(questionManager: state, isDone: isDone),
      QuestionFlowFinished() => const CarSimulatorResult(),
    },
    listener: (final context, final state) {
      if (state is QuestionFlowFinished) {
        context.read<CarSimulatorResultBloc>().add(const CarSimulatorGetCurrentCarResult());
      }
    },
  );
}

class _Success extends StatelessWidget {
  const _Success({required this.questionManager, required this.isDone});

  final QuestionFlowLoadSuccess questionManager;
  final bool isDone;

  @override
  Widget build(final BuildContext context) {
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
                      onTap: () => context.read<QuestionFlowBloc>().add(const QuestionFlowLastRequested()),
                    ),
                  ],
                ),
              ),
            ),
          QuestionStepper(current: cursor.index, total: cursor.total),
          QuestionsManagerQuestionView(key: ValueKey(cursor.element), cursor: cursor),
        ],
      ),
    );
  }
}
