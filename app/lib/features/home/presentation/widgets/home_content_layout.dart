import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/aids/core/presentation/widgets/aids_section.dart';
import 'package:app/features/environmental_performance/home/presentation/widgets/environmental_performance_section.dart';
import 'package:app/features/home/home_dashboard/widget/home_dashboard.dart';
import 'package:app/features/home/presentation/pages/home_page.dart';
import 'package:app/features/survey/survey_section.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeContentLayout extends StatelessWidget {
  const HomeContentLayout({super.key});

  @override
  Widget build(final context) {
    const spacing = SizedBox(height: DsfrSpacings.s4w);

    return RefreshIndicator(
      onRefresh: () async {
        if (GoRouter.of(context).canPop()) {
          GoRouter.of(context).pop();
        }
        await GoRouter.of(context).pushNamed(HomePage.name);
      },
      child: ListView(
        padding: EdgeInsets.zero,
        children: const [
          HomeDashboard(),
          // ThemeHubSection(),
          spacing,
          Padding(padding: EdgeInsets.symmetric(horizontal: paddingVerticalPage), child: EnvironmentalPerformanceSection()),
          spacing,
          Padding(padding: EdgeInsets.symmetric(horizontal: paddingVerticalPage), child: AidsSection()),
          spacing,
          SurveySection(),
        ],
      ),
    );
  }
}
