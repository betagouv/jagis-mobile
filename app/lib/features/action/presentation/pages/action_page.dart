import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/core/presentation/widgets/fondamentaux/shadows.dart';
import 'package:app/features/action/domain/action.dart';
import 'package:app/features/action/presentation/bloc/action_bloc.dart';
import 'package:app/features/action/presentation/bloc/action_event.dart';
import 'package:app/features/action/presentation/bloc/action_state.dart';
import 'package:app/features/action/presentation/widgets/action_aids_view.dart';
import 'package:app/features/action/presentation/widgets/action_classic_view.dart';
import 'package:app/features/action/presentation/widgets/action_quiz_view.dart';
import 'package:app/features/action/presentation/widgets/action_score_instruction_view.dart';
import 'package:app/features/action/presentation/widgets/action_simulator_view.dart';
import 'package:app/features/action/presentation/widgets/action_title_with_sub_title_view.dart';
import 'package:app/features/actions/domain/action_type.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ActionPage extends StatelessWidget {
  const ActionPage({super.key, required this.id, required this.type});

  static const name = 'action';
  static const path = 'action/:type/:titre/:id';

  static Map<String, String> pathParameters({
    required final ActionType type,
    required final String title,
    required final String id,
  }) => {'type': actionTypeToAPIString(type), 'titre': title, 'id': id};

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
          (final context, final state) => switch (state) {
            ActionInitial() || ActionLoadInProgress() => const Center(child: CircularProgressIndicator()),
            ActionLoadSuccess(:final action) => _Success(action),
            ActionLoadFailure(:final errorMessage) => Center(child: Text(errorMessage)),
            // FIXME(erolley): find a way to only the score section when the action is done instead of reloading the whole page
            ActionMarkedAsDone(:final action) => _Success(action, reload: true),
          },
    ),
  );
}

class _Success extends StatelessWidget {
  const _Success(this.action, {this.reload = false});

  final Action action;
  final bool reload;

  @override
  Widget build(final context) {
    if (reload) {
      context.read<ActionBloc>().add(ActionLoadRequested(id: action.id, type: action.type));
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s4w, horizontal: DsfrSpacings.s2w),
          child: ActionTitleWithSubTitleView(title: action.title, subTitle: action.subTitle, type: action.type),
        ),
        DecoratedBox(
          decoration: const BoxDecoration(color: Colors.white, boxShadow: actionOmbre),
          child: Column(
            spacing: DsfrSpacings.s2w,
            children: [
              switch (action) {
                ActionClassic() => ActionClassicView(action: action as ActionClassic),
                ActionSimulator() => ActionSimulatorView(action: action as ActionSimulator),
                ActionQuiz() => ActionQuizView(action: action as ActionQuiz),
              },
              if (action.aidSummaries.isNotEmpty) ActionAidsView(aidSummaries: action.aidSummaries),
            ],
          ),
        ),
        ActionScoreInstructionView(action: action),
      ],
    );
  }
}
