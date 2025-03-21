import 'package:app/features/environmental_performance/action/presentation/bloc/action_performance_finished_bloc.dart';
import 'package:app/features/environmental_performance/action/presentation/bloc/action_performance_finished_event.dart';
import 'package:app/features/environmental_performance/action/presentation/bloc/action_performance_finished_state.dart';
import 'package:app/features/environmental_performance/core/presentation/widgets/performance_detail_body.dart';
import 'package:app/features/questions_manager/bloc/questions_manager_bloc.dart';
import 'package:app/features/questions_manager/bloc/questions_manager_event.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ActionPerformanceFinished extends StatelessWidget {
  const ActionPerformanceFinished({super.key, required this.themeType});

  final ThemeType themeType;

  @override
  Widget build(final context) => BlocProvider(
    create:
        (final context) => ActionPerformanceFinishedBloc(context.read())..add(ActionPerformanceFinishedLoadRequested(themeType)),
    child: const _View(),
  );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final context) => BlocBuilder<ActionPerformanceFinishedBloc, ActionPerformanceFinishedState>(
    builder:
        (final context, final state) => switch (state) {
          ActionPerformanceFinishedInitial() => const SizedBox.shrink(),
          ActionPerformanceFinishedLoadInProgress() => const Center(child: CircularProgressIndicator()),
          ActionPerformanceFinishedLoadFailure() => const Center(child: Text('Erreur de chargement')),
          ActionPerformanceFinishedLoadSuccess() => _Success(data: state),
        },
  );
}

class _Success extends StatelessWidget {
  const _Success({required this.data});

  final ActionPerformanceFinishedLoadSuccess data;

  @override
  Widget build(final BuildContext context) {
    final performanceResult = data.data;
    final label = performanceResult.label.toLowerCase();
    final footprintInKgOfCO2ePerYear = performanceResult.footprintInKgOfCO2ePerYear;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(Localisation.actionPerformanceTermineTitle(label), style: const DsfrTextStyle.headline2()),
        const SizedBox(height: DsfrSpacings.s1w),
        Text.rich(
          TextSpan(
            style: const DsfrTextStyle.bodyLg(),
            children: [
              const TextSpan(text: Localisation.actionPerformanceTerminePart1),
              TextSpan(
                text: Localisation.actionPerformanceTerminePart2(footprintInKgOfCO2ePerYear.tonnesRepresentation),
                style: const DsfrTextStyle.bodyLgBold(),
              ),
              TextSpan(text: Localisation.actionPerformanceTerminePart3(label)),
            ],
          ),
        ),
        const SizedBox(height: DsfrSpacings.s3w),
        ...performanceResult.subItems
            .map(
              (final f) => PerformanceDetailBody(
                emoji: f.emoji,
                label: f.label,
                value: f.footprintInKgOfCO2ePerYear.kilogramsRepresentation,
                progress:
                    (f.footprintInKgOfCO2ePerYear.percentageOfMaxFootprint) /
                    (footprintInKgOfCO2ePerYear.percentageOfMaxFootprint),
              ),
            )
            .separator(const SizedBox(height: DsfrSpacings.s2w)),
        const SizedBox(height: DsfrSpacings.s3w),
        DsfrButton(
          label: Localisation.retournerEnArriere,
          variant: DsfrButtonVariant.primary,
          size: DsfrButtonSize.lg,
          onPressed: () => GoRouter.of(context).pop(),
        ),
        DsfrButton(
          label: Localisation.recommencerLeBilan,
          variant: DsfrButtonVariant.secondary,
          size: DsfrButtonSize.lg,
          onPressed: () => context.read<QuestionsManagerBloc>().add(const QuestionsManagerFirstQuestionRequested()),
        ),
      ],
    );
  }
}
