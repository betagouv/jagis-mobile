import 'package:app/core/navigation/extensions/go_router.dart';
import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/progress_bar.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/features/environmental_performance/questions/presentation/infrastructure/environmental_performance_questions_manager.dart';
import 'package:app/features/environmental_performance/summary/presentation/page/environmental_performance_summary_page.dart';
import 'package:app/features/questions_manager/bloc/questions_manager_bloc.dart';
import 'package:app/features/questions_manager/bloc/questions_manager_event.dart';
import 'package:app/features/questions_manager/bloc/questions_manager_state.dart';
import 'package:app/features/questions_manager/presentation/questions_manager_question_view.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EnvironmentalPerformanceQuestionPage extends StatelessWidget {
  const EnvironmentalPerformanceQuestionPage({super.key, required this.categoryId});

  static const name = 'bilan-question';
  static const path = '$name/:categoryId';

  static GoRoute get route => GoRoute(
    path: path,
    name: name,
    builder:
        (final context, final state) => EnvironmentalPerformanceQuestionPage(
          categoryId:
              state.pathParameters['categoryId']
              // FIXME(erolley): what if categoryId is null?
              ??
              '',
        ),
  );

  final String categoryId;

  @override
  Widget build(final context) => FnvScaffold(
    appBar: FnvAppBar(),
    body: BlocProvider(
      create:
          (final context) => QuestionsManagerBloc(
            application: EnvironmentalPerformanceQuestionsManager(client: context.read(), categoryId: categoryId),
          )..add(const QuestionsManagerFirstQuestionRequested()),
      child: const _View(),
    ),
  );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final context) => BlocConsumer<QuestionsManagerBloc, QuestionsManagerState>(
    builder:
        (final context, final state) => switch (state) {
          QuestionsManagerInitial() || QuestionManagerFinished() => const SizedBox.shrink(),
          QuestionsManagerLoadSuccess() => _LoadSuccess(state),
        },
    listener: (final context, final state) {
      if (state is QuestionManagerFinished) {
        GoRouter.of(context).popUntilNamed<void>(EnvironmentalPerformanceSummaryPage.name);
      }
    },
  );
}

class _LoadSuccess extends StatelessWidget {
  const _LoadSuccess(this.state);

  final QuestionsManagerLoadSuccess state;

  @override
  Widget build(final context) {
    final cursor = state.cursor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: DsfrSpacings.s1v,
      children: [
        FnvProgressBar(current: cursor.index, total: cursor.elements.length),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s4w, horizontal: DsfrSpacings.s2w),
          child: QuestionsManagerQuestionView(key: ValueKey(cursor.element), cursor: cursor),
        ),
        const SafeArea(child: SizedBox.shrink()),
      ],
    );
  }
}
