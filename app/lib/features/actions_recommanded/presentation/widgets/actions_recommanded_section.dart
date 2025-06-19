import 'package:app/core/assets/images.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/features/actions_recommanded/presentation/widgets/actions_horizontal_list.dart';
import 'package:app/features/actions_recommanded/presentation/widgets/actions_recommanded_questions.dart';
import 'package:app/features/theme/core/domain/theme_info.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:app/features/theme/presentation/bloc/theme_event.dart';
import 'package:app/features/theme/presentation/helpers/tab_bar_router.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class ActionsRecommandedSection extends StatelessWidget {
  const ActionsRecommandedSection({super.key, required this.theme});

  final ThemeInfo theme;

  @override
  Widget build(final BuildContext context) => switch (theme) {
    ThemeInfo(:final sequenceId) when theme.isQuestionsNeeded => ActionsRecommandedQuestions(sequenceId: sequenceId),
    ThemeInfo(:final actionsRecommanded) when theme.hasRecommandedActions => ActionsHorizontalList(actions: actionsRecommanded),
    ThemeInfo(:final themeType) when theme.hasNoRecommandedActions => _ActionsEmpty(themeType: themeType),
    ThemeInfo _ => const SizedBox.shrink(),
  };
}

class _ActionsEmpty extends StatelessWidget {
  const _ActionsEmpty({required this.themeType});

  final ThemeType themeType;

  @override
  Widget build(final BuildContext context) => Column(
    children: [
      const FnvImage.asset(AssetImages.actionsRecommandedEmpty, height: 148),
      const SizedBox(height: DsfrSpacings.s2w),
      const Text(
        Localisation.mesActionsRecommandeesEpuiseeTitre,
        style: DsfrTextStyle.headline4(color: DsfrColors.grey50),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: DsfrSpacings.s1v),
      const Text(
        Localisation.mesActionsRecommandeesEpuiseeDescription,
        style: DsfrTextStyle.bodyMd(color: DsfrColors.grey50),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: DsfrSpacings.s3w),
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: DsfrSpacings.s2w,
        children: [
          _ExploreAnotherTheme(themeType: themeType),
          DsfrButton(
            label: Localisation.refaire,
            icon: DsfrIcons.systemRefreshLine,
            variant: DsfrButtonVariant.secondary,
            size: DsfrComponentSize.lg,
            onPressed: () => context.read<ThemeBloc>().add(const ThemeResetRequested()),
          ),
        ],
      ),
    ],
  );
}

class _ExploreAnotherTheme extends StatelessWidget {
  const _ExploreAnotherTheme({required this.themeType});

  final ThemeType themeType;

  @override
  Widget build(final BuildContext context) {
    final themeExplored = switch (themeType) {
      ThemeType.alimentation => ThemeType.transport,
      ThemeType.transport => ThemeType.logement,
      ThemeType.logement => ThemeType.consommation,
      ThemeType.consommation || ThemeType.decouverte => ThemeType.alimentation,
    };

    return DsfrButton(
      label: 'Explorer “${themeExplored.displayNameWithoutEmoji}”',
      variant: DsfrButtonVariant.primary,
      size: DsfrComponentSize.lg,
      onPressed: () {
        navigateToTheme(context, themeExplored);
      },
    );
  }
}
