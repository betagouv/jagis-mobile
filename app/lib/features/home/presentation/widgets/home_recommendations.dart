import 'package:app/features/bibliotheque/presentation/pages/bibliotheque_page.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:app/features/recommandations/presentation/widgets/recommendation_widget.dart';
import 'package:app/features/theme/presentation/widgets/theme_type_tag.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeRecommendations extends StatelessWidget {
  const HomeRecommendations(this.recommendations, {super.key});

  final List<Recommandation> recommendations;

  @override
  Widget build(final BuildContext context) => Padding(
    padding: const EdgeInsets.all(DsfrSpacings.s2w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: DsfrSpacings.s2w,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(Localisation.quoiDeNeuf, style: DsfrTextStyle.headline3()),
            DsfrLink.md(
              label: Localisation.toutVoir,
              onTap: () => GoRouter.of(context).pushReplacementNamed(BibliothequePage.name),
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: IntrinsicHeight(
            child: Row(
              spacing: DsfrSpacings.s2w,
              children:
                  recommendations
                      .map(
                        (final e) => RecommendationWidget(
                          id: e.id,
                          type: e.type,
                          points: '${e.points}',
                          imageUrl: e.imageUrl,
                          themeTag: ThemeTypeTag(themeType: e.thematique),
                          titre: e.titre,
                        ),
                      )
                      .toList(),
            ),
          ),
        ),
      ],
    ),
  );
}
