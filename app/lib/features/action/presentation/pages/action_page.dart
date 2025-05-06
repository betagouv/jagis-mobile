import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/core/presentation/widgets/fondamentaux/shadows.dart';
import 'package:app/features/action/domain/action.dart';
import 'package:app/features/action/presentation/bloc/action_bloc.dart';
import 'package:app/features/action/presentation/bloc/action_event.dart';
import 'package:app/features/action/presentation/bloc/action_state.dart';
import 'package:app/features/action/presentation/widgets/action_aids_view.dart';
import 'package:app/features/action/presentation/widgets/action_articles.dart';
import 'package:app/features/action/presentation/widgets/action_classic_view.dart';
import 'package:app/features/action/presentation/widgets/action_faq_view.dart';
import 'package:app/features/action/presentation/widgets/action_quiz_view.dart';
import 'package:app/features/action/presentation/widgets/action_score_instruction_view.dart';
import 'package:app/features/action/presentation/widgets/action_simulator_view.dart';
import 'package:app/features/action/presentation/widgets/action_title_with_sub_title_view.dart';
import 'package:app/features/actions/domain/action_type.dart';
import 'package:app/features/environmental_performance/action/presentation/action_performance_view.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ActionPage extends StatelessWidget {
  const ActionPage({super.key, required this.id, required this.type});

  static const name = 'action';
  static const path = 'action/:type/:title/:id';

  static Map<String, String> pathParameters({
    required final ActionType type,
    // Le titre est uniquement ajouté pour être iso avec le web et permettre le deeplink
    final String title = 'titre-action',
    required final String id,
  }) => {'type': actionTypeToAPIString(type), 'title': title, 'id': id};

  final String id;
  final ActionType type;

  static GoRoute get route => GoRoute(
    path: path,
    name: name,
    builder:
        (final context, final state) =>
            ActionPage(id: state.pathParameters['id']!, type: actionTypeFromAPIString(state.pathParameters['type']!)),
  );

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (final context) => ActionBloc(repository: context.read())..add(ActionLoadRequested(id: id, type: type)),
    child: const _View(),
  );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final BuildContext context) => FnvScaffold(
    appBar: FnvAppBar(),
    body: BlocBuilder<ActionBloc, ActionState>(
      builder:
          (final context, final state) => switch (state.status) {
            ActionStatus.initial || ActionStatus.inProgress => const Center(child: CircularProgressIndicator()),
            ActionStatus.success => _Success(state.action!),
            ActionStatus.failure => Center(child: Text(state.errorMessage!)),
          },
    ),
  );
}

class _Success extends StatelessWidget {
  const _Success(this.action);

  final Action action;

  @override
  // TODO(lsaudon): Si on utilise un ListView, ça rebuild le quiz et du coup on perd l'avancement
  // ignore: prefer-using-list-view
  Widget build(final BuildContext context) => SingleChildScrollView(
    child: Column(
      children: [
        const SizedBox(height: DsfrSpacings.s3w),
        _PaddingHorizontal(child: ActionTitleWithSubTitleView(title: action.title, subTitle: action.subTitle, type: action.type)),
        const SizedBox(height: DsfrSpacings.s3w),
        DecoratedBox(
          decoration: const BoxDecoration(color: Colors.white, boxShadow: cardShadow),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: DsfrSpacings.s3w,
            children: [
              const SizedBox(height: DsfrSpacings.s1w),
              switch (action) {
                final ActionClassic a => ActionClassicView(action: a),
                final ActionSimulator a => ActionSimulatorView(action: a),
                final ActionQuiz a => ActionQuizView(action: a),
                final ActionPerformance a => ActionPerformanceView(action: a),
              },
              if (action.aidSummaries.isNotEmpty) _PaddingHorizontal(child: ActionAidsView(aidSummaries: action.aidSummaries)),
              if (action.faq != null && action.faq!.isNotEmpty) _PaddingHorizontal(child: ActionFAQView(action: action)),
              const SizedBox(height: DsfrSpacings.s1w),
            ],
          ),
        ),
        const SizedBox(height: DsfrSpacings.s3w),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
          child: ActionScoreInstructionView(action: action),
        ),
        if (action.articles.isNotEmpty) ...[const SizedBox(height: DsfrSpacings.s3w), ActionArticles(articles: action.articles)],
        const SafeArea(child: SizedBox(height: DsfrSpacings.s3w)),
      ],
    ),
  );
}

class _PaddingHorizontal extends StatelessWidget {
  const _PaddingHorizontal({required this.child});

  final Widget child;

  @override
  Widget build(final BuildContext context) =>
      Padding(padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w), child: child);
}
