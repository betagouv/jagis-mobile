import 'package:app/core/navigation/extensions/go_router.dart';
import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/core/question_flow/bloc/question_flow_bloc.dart';
import 'package:app/core/question_flow/bloc/question_flow_event.dart';
import 'package:app/core/question_flow/bloc/question_flow_state.dart';
import 'package:app/core/question_flow/infrastructure/question_flow_manager.dart';
import 'package:app/core/question_flow/presentation/questions_manager_question_view.dart';
import 'package:app/features/environmental_performance/summary/presentation/page/environmental_performance_summary_page.dart';
import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:go_router/go_router.dart';

class EnvironmentalPerformanceQuestionPage extends StatelessWidget {
  const EnvironmentalPerformanceQuestionPage({super.key, required this.categoryId});

  static const name = 'bilan-question';
  static const path = '$name/:categoryId';

  static GoRoute get route => GoRoute(
    path: path,
    name: name,
    builder: (final context, final state) =>
        EnvironmentalPerformanceQuestionPage(categoryId: state.pathParameters['categoryId']!),
  );

  final String categoryId;

  @override
  Widget build(final BuildContext context) => FnvScaffold(
    appBar: FnvAppBar(),
    body: BlocProvider(
      create: (final context) =>
          QuestionFlowBloc(QuestionFlowManager(context.read(), sequenceId: categoryId))..add(const QuestionFlowFirstRequested()),
      child: const _View(),
    ),
  );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final BuildContext context) => BlocConsumer<QuestionFlowBloc, QuestionFlowState>(
    builder: (final context, final state) => switch (state) {
      QuestionFlowInitial() || QuestionFlowFinished() => const SizedBox.shrink(),
      QuestionFlowLoadSuccess() => _LoadSuccess(state),
    },
    listener: (final context, final state) {
      if (state is QuestionFlowFinished) {
        GoRouter.of(context).popUntilNamed<void>(EnvironmentalPerformanceSummaryPage.name);
      }
    },
  );
}

class _LoadSuccess extends StatelessWidget {
  const _LoadSuccess(this.state);

  final QuestionFlowLoadSuccess state;

  @override
  Widget build(final BuildContext context) {
    final cursor = state.cursor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: DsfrSpacings.s1v,
      children: [
        FnvProgressBar(current: cursor.index, total: cursor.total),
        Flexible(
          child: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s4w, horizontal: DsfrSpacings.s2w),
                child: QuestionsManagerQuestionView(key: ValueKey(cursor.element), cursor: cursor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
