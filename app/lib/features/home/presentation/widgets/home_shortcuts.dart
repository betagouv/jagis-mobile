import 'package:app/core/helpers/size.dart';
import 'package:app/features/theme/core/domain/theme_summary.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/features/theme/presentation/widgets/theme_service_info.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

class HomeShortcuts extends StatelessWidget {
  const HomeShortcuts({super.key, required this.commune, required this.nbAids, required this.nbRecipies});

  final String commune;
  final int nbAids;
  final int nbRecipies;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(color: Color(0xFFECEBE0)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w, vertical: DsfrSpacings.s6w),
      child: Column(
        spacing: DsfrSpacings.s2w,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Raccourcis', style: DsfrTextStyle.headline3()),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            child: IntrinsicHeight(
              child: Row(
                spacing: DsfrSpacings.s2w,
                children:
                    ThemeType.values
                        .flatMap(
                          (final themeType) => ThemeSummary.buildThemeLinksFor(
                            commune: commune,
                            aidCount: nbAids,
                            recipeCount: nbRecipies,
                            themeType: themeType,
                          ),
                        )
                        .toSet()
                        .map(
                          (final link) => SizedBox(
                            height: double.infinity,
                            width: screenWidth(context, percentage: 0.65),
                            child: ThemeServiceInfo(link: link),
                          ),
                        )
                        .toList(),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
