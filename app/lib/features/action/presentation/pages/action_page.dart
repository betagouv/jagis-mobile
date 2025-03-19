import 'package:app/core/infrastructure/markdown.dart';
import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/card.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/core/presentation/widgets/fondamentaux/shadows.dart';
import 'package:app/features/action/domain/action.dart';
import 'package:app/features/action/presentation/bloc/action_bloc.dart';
import 'package:app/features/action/presentation/bloc/action_event.dart';
import 'package:app/features/action/presentation/bloc/action_state.dart';
import 'package:app/features/action/presentation/widgets/action_aids_view.dart';
import 'package:app/features/action/presentation/widgets/action_classic_view.dart';
import 'package:app/features/action/presentation/widgets/action_quiz_view.dart';
import 'package:app/features/action/presentation/widgets/action_simulator_view.dart';
import 'package:app/features/action/presentation/widgets/action_title_with_sub_title_view.dart';
import 'package:app/features/actions/domain/action_type.dart';
import 'package:app/features/gamification/presentation/widgets/points.dart';
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
    create: (final context) => ActionBloc(repository: context.read())..add(ActionLoadRequested(id, type)),
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
            ActionLoadSuccess() => _Success(state),
            ActionLoadFailure(:final errorMessage) => Center(child: Text(errorMessage)),
          },
    ),
  );
}

class _Success extends StatelessWidget {
  const _Success(this.state);

  final ActionLoadSuccess state;

  @override
  Widget build(final context) {
    final action = state.action;

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s4w, horizontal: DsfrSpacings.s2w),
          child: ActionTitleWithSubTitleView(title: action.title, subTitle: action.subTitle),
        ),
        DecoratedBox(
          decoration: const BoxDecoration(color: Colors.white, boxShadow: actionOmbre),
          child: Column(
            spacing: DsfrSpacings.s2w,
            children: [
              switch (action) {
                ActionClassic() => ActionClassicView(action: action),
                ActionSimulator() => ActionSimulatorView(action: action),
                ActionQuiz() => ActionQuizView(action: action),
              },
              if (action.aidSummaries.isNotEmpty) ActionAidsView(aidSummaries: action.aidSummaries),
            ],
          ),
        ),
        _ScoreInstructionView(action: action),
      ],
    );
  }
}

class _ScoreInstructionView extends StatelessWidget {
  const _ScoreInstructionView({required this.action});

  final Action action;

  @override
  Widget build(final BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s4w, horizontal: DsfrSpacings.s2w),
    child: FnvCard(
      child: Padding(
        padding: const EdgeInsets.all(DsfrSpacings.s2w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: DsfrSpacings.s1w,
          children: [
            if (action.isDone) ...[
              const Text('Bravo ! 🎉', style: DsfrTextStyle.headline3()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(action.instructionWhenDone, style: const DsfrTextStyle.bodyMd()),
                  Points(points: action.score, alreadyEarned: true),
                ],
              ),
            ] else ...[
              const Text('On se lance le défi ?', style: DsfrTextStyle.headline3()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child: Text(action.instruction, style: const DsfrTextStyle.bodyMd())),
                  Points(points: action.score),
                ],
              ),
            ],
            DecoratedBox(
              decoration: const BoxDecoration(border: Border(top: BorderSide(color: DsfrColors.blueFrance950))),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: DsfrSpacings.s1w),
                child:
                    action.nbActionsDone > 1
                        ? switch (action) {
                          ActionClassic() => FnvMarkdown(data: action.scoreLabel, p: const DsfrTextStyle.bodyMd()),
                          ActionSimulator() || ActionQuiz() => Text.rich(
                            TextSpan(
                              text: '${action.nbActionsDone} ${action.scoreLabel}',
                              style: const DsfrTextStyle.bodyMdBold(),
                              children: const [
                                TextSpan(text: ' faites par la communautées', style: DsfrTextStyle.bodyMdItalic()),
                              ],
                            ),
                          ),
                        }
                        : const Text('Sois le ou la première à relever ce défi !', style: DsfrTextStyle.bodyMdItalic()),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

