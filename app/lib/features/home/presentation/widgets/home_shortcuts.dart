import 'package:app/core/helpers/size.dart';
import 'package:app/features/theme/core/domain/theme_summary.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/features/theme/presentation/widgets/theme_service_info.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:fpdart/fpdart.dart';

class HomeShortcuts extends StatelessWidget {
  const HomeShortcuts({super.key, required this.nbAids, required this.nbRecipes});

  final int nbAids;
  final int nbRecipes;

  @override
  Widget build(final BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(color: Color(0xFFECEBE0)),
    child: Padding(
      padding: const EdgeInsets.only(
        left: DsfrSpacings.s2w,
        top: DsfrSpacings.s4w,
        right: DsfrSpacings.s2w,
        bottom: DsfrSpacings.s6w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: DsfrSpacings.s3w,
        children: [
          const Text(Localisation.raccourcis, style: DsfrTextStyle.headline3(color: DsfrColors.grey50)),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            child: IntrinsicHeight(
              child: Row(
                spacing: DsfrSpacings.s3v,
                children: ThemeType.values
                    .flatMap(
                      (final themeType) =>
                          ThemeSummary.buildThemeLinksFor(themeType: themeType, aidCount: nbAids, recipeCount: nbRecipes),
                    )
                    .toSet()
                    .map(
                      (final link) => SizedBox(
                        width: screenWidth(context, percentage: 0.8),
                        height: double.infinity,
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
