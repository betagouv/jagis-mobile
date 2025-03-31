import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/core/presentation/widgets/fondamentaux/shadows.dart';
import 'package:app/features/action/domain/action.dart';
import 'package:app/features/action/presentation/bloc/action_bloc.dart';
import 'package:app/features/action/presentation/bloc/action_event.dart';
import 'package:app/features/action/presentation/bloc/action_state.dart';
import 'package:app/features/action/presentation/widgets/action_aids_view.dart';
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
    required final String title,
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
  Widget build(final context) => BlocProvider(
    create: (final context) => ActionBloc(repository: context.read())..add(ActionLoadRequested(id: id, type: type)),
    child: const _View(),
  );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final context) => FnvScaffold(
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
  Widget build(final context) => ListView(
    children: [
      const SizedBox(height: DsfrSpacings.s3w),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
        child: ActionTitleWithSubTitleView(title: action.title, subTitle: action.subTitle, type: action.type),
      ),
      const SizedBox(height: DsfrSpacings.s3w),
      DecoratedBox(
        decoration: const BoxDecoration(color: Colors.white, boxShadow: actionOmbre),
        child: Column(
          children: [
            const SizedBox(height: DsfrSpacings.s3w),
            switch (action) {
              final ActionClassic a => ActionClassicView(action: a),
              final ActionSimulator a => ActionSimulatorView(action: a),
              final ActionQuiz a => ActionQuizView(action: a),
              final ActionPerformance a => ActionPerformanceView(action: a),
            },
            if (action.aidSummaries.isNotEmpty) ...[
              const SizedBox(height: DsfrSpacings.s3w),
              ActionAidsView(aidSummaries: action.aidSummaries),
            ],
            if (action.faq != null && action.faq!.isNotEmpty) ...[
              const SizedBox(height: DsfrSpacings.s3w),
              ActionFAQView(faq: action.faq!),
            ],
            const SizedBox(height: DsfrSpacings.s3w),
          ],
        ),
      ),
      const SizedBox(height: DsfrSpacings.s3w),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
        child: ActionScoreInstructionView(action: action),
      ),
      const SafeArea(child: SizedBox(height: DsfrSpacings.s3w)),
    ],
  );
}
