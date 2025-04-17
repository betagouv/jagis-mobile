import 'package:app/core/assets/images.dart';
import 'package:app/core/infrastructure/markdown.dart';
import 'package:app/core/infrastructure/message_bus.dart';
import 'package:app/core/infrastructure/svg.dart';
import 'package:app/core/presentation/widgets/animation_shake.dart';
import 'package:app/core/presentation/widgets/composants/loader.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/shadows.dart';
import 'package:app/features/actions_recommanded/infrastructure/actions_recommanded_manager.dart';
import 'package:app/features/questions_manager/bloc/questions_manager_bloc.dart';
import 'package:app/features/questions_manager/bloc/questions_manager_event.dart';
import 'package:app/features/questions_manager/bloc/questions_manager_state.dart';
import 'package:app/features/questions_manager/presentation/questions_manager_question_view.dart';
import 'package:app/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:app/features/theme/presentation/bloc/theme_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionsRecommandedQuestions extends StatelessWidget {
  const ActionsRecommandedQuestions({super.key, required this.sequenceId});

  final String sequenceId;

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create:
        (final context) =>
            QuestionsManagerBloc(application: ActionsRecommandedQuestionsManager(client: context.read(), sequenceId: sequenceId))
              ..add(const QuestionsManagerFirstQuestionRequested()),
    child: const _Questions(),
  );
}

class _Questions extends StatelessWidget {
  const _Questions();

  @override
  Widget build(final BuildContext context) => BlocConsumer<QuestionsManagerBloc, QuestionsManagerState>(
    builder:
        (final context, final state) => switch (state) {
          QuestionsManagerInitial() => const SizedBox.shrink(),
          QuestionsManagerLoadSuccess() => _QuestionsSuccess(data: state),
          QuestionManagerFinished() => const _Loader(),
        },
    listener: (final context, final state) {
      if (state is QuestionManagerFinished) {
        context.read<ThemeBloc>().add(const ThemeRefreshRequested());
      }
    },
  );
}

class _QuestionsSuccess extends StatefulWidget {
  const _QuestionsSuccess({required this.data});

  final QuestionsManagerLoadSuccess data;

  @override
  State<_QuestionsSuccess> createState() => _QuestionsSuccessState();
}

class _QuestionsSuccessState extends State<_QuestionsSuccess> {
  var _isExpanded = true;

  @override
  Widget build(final BuildContext context) {
    final cursor = widget.data.cursor;
    final element = cursor.element;
    if (element == null) {
      return const _Loader();
    }

    return _isExpanded
        ? _GetStarted(
          onPressed: () {
            context.read<MessageBus>().publish(startFirstTimeQuestionsToPersonalizeActionsTopic);
            setState(() => _isExpanded = false);
          },
        )
        : ColoredBox(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(DsfrSpacings.s2w),
            child: Column(
              spacing: DsfrSpacings.s4w,
              children: [
                DsfrStepper(title: element.label, current: cursor.index + 1, total: cursor.total),
                QuestionsManagerQuestionView(key: ValueKey(element), cursor: cursor, withoutTitle: true),
              ],
            ),
          ),
        );
  }
}

class _Loader extends StatelessWidget {
  const _Loader();

  @override
  Widget build(final BuildContext context) => const SizedBox(
    height: 200,
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: DsfrSpacings.s1w,
        children: [
          FnvLoader(),
          Text(
            Localisation.nousPreparonsVosRecommandationsPersonnalisees,
            style: DsfrTextStyle.bodyLg(),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

class _GetStarted extends StatelessWidget {
  const _GetStarted({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(color: FnvColors.carteFond, boxShadow: cardBoxShadow),
    child: Padding(
      padding: const EdgeInsets.only(
        left: DsfrSpacings.s3w,
        top: DsfrSpacings.s3w,
        right: DsfrSpacings.s3w,
        bottom: DsfrSpacings.s4w,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(Localisation.envieDAvoirUnVraiImpact, style: DsfrTextStyle.headline5()),
          const SizedBox(height: DsfrSpacings.s1v),
          const FnvMarkdown(data: Localisation.envieDAvoirUnVraiImpactDescription),
          const SizedBox(height: DsfrSpacings.s2w),
          AnimationShake(
            child: DsfrRawButton(
              variant: DsfrButtonVariant.primary,
              size: DsfrComponentSize.lg,
              onPressed: onPressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Flexible(child: Text(Localisation.commencer)),
                  const SizedBox(width: DsfrSpacings.s1w),
                  FnvSvg.asset(AssetImages.leaf),
                  const Text('+25'),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
