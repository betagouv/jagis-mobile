import 'package:app/core/helpers/size.dart';
import 'package:app/features/home/home_dashboard/widget/home_dashboard.dart';
import 'package:app/features/home/presentation/pages/home_page.dart';
import 'package:app/features/survey/survey_section.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/features/theme_hub/presentation/helpers/tab_bar_router.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeContentLayout extends StatelessWidget {
  const HomeContentLayout({super.key});

  @override
  Widget build(final context) {
    const spacing = SizedBox(height: DsfrSpacings.s4w);
    const spacingSmall = SizedBox(height: DsfrSpacings.s2w);

    return RefreshIndicator(
      onRefresh: () async {
        if (GoRouter.of(context).canPop()) {
          GoRouter.of(context).pop();
        }
        await GoRouter.of(context).pushNamed(HomePage.name);
      },
      child: DecoratedBox(
        decoration: const BoxDecoration(color: Colors.white),
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            HomeDashboard(),
            // ThemeHubSection(),
            spacingSmall,
            _WhichDomainButtonsSection(),
            spacing,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text('Quoi de neuf ?', style: DsfrTextStyle.headline2())],
              ),
            ),
            spacing,
            SurveySection(),
          ],
        ),
      ),
    );
  }
}

class _WhichDomainButtonsSection extends StatelessWidget {
  const _WhichDomainButtonsSection();

  @override
  Widget build(final BuildContext context) => Column(
    spacing: DsfrSpacings.s2w,
    children: [
      SizedBox(
        width: screenWidth(context, percentage: 0.7),
        child: const Wrap(
          children: [
            Text('Dans quel domaine souhaitez-vous agir ?', style: DsfrTextStyle.body2XlMedium(), textAlign: TextAlign.center),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
        child: GridView(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: DsfrSpacings.s1w,
            mainAxisSpacing: DsfrSpacings.s1w,
            childAspectRatio: 3,
          ),
          physics: const NeverScrollableScrollPhysics(),
          children:
              [ThemeType.alimentation, ThemeType.logement, ThemeType.transport, ThemeType.consommation]
                  .map(
                    (final theme) => DsfrButton(
                      label: theme.displayName,
                      variant: DsfrButtonVariant.primary,
                      size: DsfrButtonSize.md,
                      onPressed: () => navigateToTheme(context, theme),
                    ),
                  )
                  .toList(),
        ),
      ),
    ],
  );
}
