import 'package:app/core/assets/images.dart';
import 'package:app/core/infrastructure/markdown.dart';
import 'package:app/core/infrastructure/svg.dart';
import 'package:app/core/presentation/widgets/animation_shake.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/question_flow/bloc/question_flow_bloc.dart';
import 'package:app/core/question_flow/bloc/question_flow_event.dart';
import 'package:app/core/question_flow/bloc/question_flow_state.dart';
import 'package:app/core/question_flow/domain/current_question.dart';
import 'package:app/core/question_flow/domain/cursor.dart';
import 'package:app/core/question_flow/infrastructure/question_flow_manager.dart';
import 'package:app/core/question_flow/presentation/questions_manager_question_view.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:app/features/theme/presentation/bloc/theme_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class ActionsRecommandedQuestions extends StatelessWidget {
  const ActionsRecommandedQuestions({super.key, required this.themeType, required this.sequenceId});

  final String sequenceId;
  final ThemeType themeType;

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (final context) =>
        QuestionFlowBloc(QuestionFlowManager(context.read(), sequenceId: sequenceId))..add(const QuestionFlowFirstRequested()),
    child: _Questions(themeType: themeType),
  );
}

class _Questions extends StatelessWidget {
  const _Questions({required this.themeType});

  final ThemeType themeType;

  @override
  Widget build(final BuildContext context) => BlocConsumer<QuestionFlowBloc, QuestionFlowState>(
    builder: (final context, final state) => switch (state) {
      QuestionFlowInitial() => const SizedBox.shrink(),
      QuestionFlowLoadSuccess() => _QuestionsSuccess(themeType: themeType, data: state),
      QuestionFlowFinished() => const _Loader(),
    },
    listener: (final context, final state) {
      if (state is QuestionFlowFinished) {
        context.read<ThemeBloc>().add(const ThemeRefreshRequested());
      }
    },
  );
}

class _QuestionsSuccess extends StatefulWidget {
  const _QuestionsSuccess({required this.themeType, required this.data});

  final ThemeType themeType;
  final QuestionFlowLoadSuccess data;

  @override
  State<_QuestionsSuccess> createState() => _QuestionsSuccessState();
}

class _QuestionsSuccessState extends State<_QuestionsSuccess> {
  var _isExpanded = true;

  @override
  Widget build(final BuildContext context) {
    final cursor = widget.data.cursor;

    return _isExpanded
        ? _GetStarted(
            themeType: widget.themeType,
            questionTotal: cursor.total,
            onPressed: () {
              setState(() => _isExpanded = false);
            },
          )
        : _Question(element: cursor.element, cursor: cursor);
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
            style: DsfrTextStyle.bodyLg(color: DsfrColors.grey50),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

class _GetStarted extends StatelessWidget {
  const _GetStarted({required this.themeType, required this.questionTotal, required this.onPressed});

  final ThemeType themeType;
  final int questionTotal;
  final VoidCallback onPressed;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(color: FnvColors.carteFond, boxShadow: FnvShadows.card),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: DsfrSpacings.s3v,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: DsfrSpacings.s3w, top: DsfrSpacings.s3w, right: DsfrSpacings.s3w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(Localisation.questionPour(questionTotal), style: const DsfrTextStyle.headline3(color: DsfrColors.grey50)),
              const SizedBox(height: DsfrSpacings.s1v),
              const FnvMarkdown(data: Localisation.mieuxComprendreVosHabitudes),
              const SizedBox(height: DsfrSpacings.s2w),
              AnimationShake(
                child: DsfrRawButton(
                  variant: DsfrButtonVariant.primary,
                  size: DsfrComponentSize.lg,
                  onPressed: onPressed,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
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
        _IllustrationsWidget(themeType: themeType),
      ],
    ),
  );
}

class _IllustrationsWidget extends StatelessWidget {
  const _IllustrationsWidget({required this.themeType});

  final ThemeType themeType;

  @override
  Widget build(final BuildContext context) {
    final assetName = switch (themeType) {
      ThemeType.alimentation => AssetImages.thematiquesQuestionsMeNourrirIllustrations,
      ThemeType.transport => AssetImages.thematiquesQuestionsMeDeplacerIllustrations,
      ThemeType.logement => AssetImages.thematiquesQuestionsMeLogerIllustrations,
      ThemeType.consommation => AssetImages.thematiquesQuestionsMesAchatsIllustrations,
      ThemeType.decouverte => throw UnimplementedError(),
    };

    return Align(alignment: Alignment.bottomLeft, child: FnvImage.asset(assetName));
  }
}

class _Question extends StatelessWidget {
  const _Question({required this.element, required this.cursor});

  final CurrentQuestion element;
  final Cursor<CurrentQuestion> cursor;

  @override
  Widget build(final BuildContext context) => ColoredBox(
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(DsfrSpacings.s2w),
      child: Column(
        spacing: DsfrSpacings.s4w,
        children: [
          FnvStepper(currentStep: cursor.index, stepsCount: cursor.total, stepTitle: element.question.label),
          QuestionsManagerQuestionView(key: ValueKey(element), cursor: cursor, withoutTitle: true),
        ],
      ),
    ),
  );
}
