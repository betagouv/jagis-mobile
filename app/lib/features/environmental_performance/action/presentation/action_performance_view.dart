import 'package:app/core/question_flow/bloc/question_flow_bloc.dart';
import 'package:app/core/question_flow/bloc/question_flow_event.dart';
import 'package:app/core/question_flow/bloc/question_flow_state.dart';
import 'package:app/core/question_flow/infrastructure/question_flow_manager.dart';
import 'package:app/features/action/domain/action.dart';
import 'package:app/features/action/presentation/bloc/action_bloc.dart';
import 'package:app/features/action/presentation/bloc/action_event.dart';
import 'package:app/features/actions/domain/action_type.dart';
import 'package:app/features/environmental_performance/action/presentation/action_performance_finished.dart';
import 'package:app/features/environmental_performance/action/presentation/action_performance_success.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionPerformanceView extends StatelessWidget {
  const ActionPerformanceView({super.key, required this.action});

  final ActionPerformance action;

  @override
  Widget build(final BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
    child: BlocProvider(
      create:
          (final context) =>
              QuestionFlowBloc(QuestionFlowManager(context.read(), sequenceId: action.sequenceId))
                ..add(const QuestionFlowFirstRequested()),
      child: _View(themeType: action.themeType, type: action.type, code: action.id),
    ),
  );
}

class _View extends StatelessWidget {
  const _View({required this.themeType, required this.type, required this.code});

  final ThemeType themeType;
  final ActionType type;
  final String code;

  @override
  Widget build(final BuildContext context) => BlocConsumer<QuestionFlowBloc, QuestionFlowState>(
    builder:
        (final context, final state) => switch (state) {
          QuestionFlowInitial() => const SizedBox.shrink(),
          QuestionFlowLoadSuccess() => ActionPerformanceSuccess(questionManager: state),
          QuestionFlowFinished() => ActionPerformanceFinished(themeType: themeType),
        },
    listener: (final context, final state) {
      if (state is QuestionFlowFinished) {
        context.read<ActionBloc>().add(ActionMarkAsDone(id: code, type: type));
      }
    },
  );
}
