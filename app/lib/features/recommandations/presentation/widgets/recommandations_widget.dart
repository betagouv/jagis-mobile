import 'package:app/features/library/presentation/pages/library_page.dart';
import 'package:app/features/recommandations/domain/recommendation.dart';
import 'package:app/features/recommandations/presentation/widgets/recommendation_widget.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:go_router/go_router.dart';

// TODO(lsaudon): Faire un bloc pour les recommandations
class RecommendationsWidget extends StatelessWidget {
  const RecommendationsWidget({super.key, required this.title, required this.recommendations, this.onPop});

  final Widget title;
  final List<Recommendation> recommendations;
  final VoidCallback? onPop;

  @override
  Widget build(final BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: DsfrSpacings.s2w,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(child: title),
            DsfrLink(
              label: Localisation.voirTout,
              onTap: () async {
                await GoRouter.of(context).pushNamed(LibraryPage.name);
              },
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: IntrinsicHeight(
            child: Row(
              spacing: DsfrSpacings.s2w,
              children: recommendations
                  .map((final e) => RecommendationWidget(id: e.id, imageUrl: e.imageUrl, titre: e.titre, onPop: onPop))
                  .toList(),
            ),
          ),
        ),
      ],
    ),
  );
}
