import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/aids/core/presentation/widgets/aids_section.dart';
import 'package:app/features/environmental_performance/home/presentation/widgets/environmental_performance_section.dart';
import 'package:app/features/home/presentation/widgets/home_disclaimer.dart';
import 'package:app/features/survey/survey_section.dart';
import 'package:app/features/theme_hub/presentation/widgets/theme_hub_section.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class HomeContentLayout extends StatelessWidget {
  const HomeContentLayout({super.key});

  @override
  Widget build(final context) {
    const spacing = SizedBox(height: DsfrSpacings.s4w);

    return ListView(
      padding: EdgeInsets.zero,
      children: const [
        HomeDisclaimer(),
        ThemeHubSection(),
        spacing,
        Padding(padding: EdgeInsets.symmetric(horizontal: paddingVerticalPage), child: EnvironmentalPerformanceSection()),
        spacing,
        Padding(padding: EdgeInsets.symmetric(horizontal: paddingVerticalPage), child: AidsSection()),
        spacing,
        SurveySection(),
      ],
    );
  }
}
