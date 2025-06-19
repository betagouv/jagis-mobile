import 'package:app/core/infrastructure/markdown.dart';
import 'package:app/features/library/presentation/pages/library_page.dart';
import 'package:app/features/recommandations/domain/recommendation.dart';
import 'package:app/features/recommandations/presentation/widgets/recommendation_widget.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:go_router/go_router.dart';

class ActionArticles extends StatelessWidget {
  const ActionArticles({super.key, required this.articles});

  final List<Recommendation> articles;

  @override
  Widget build(final BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: DsfrSpacings.s2w,
      children: [
        Row(
          children: [
            const Expanded(
              child: FnvMarkdown(
                data: Localisation.pourAllerPlusLoin,
                p: DsfrTextStyle(fontSize: 24),
                overflow: TextOverflow.ellipsis,
              ),
            ),
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
          padding: EdgeInsets.zero,
          clipBehavior: Clip.none,
          child: IntrinsicHeight(
            child: Row(
              spacing: DsfrSpacings.s2w,
              children: articles.map((final e) => RecommendationWidget(id: e.id, imageUrl: e.imageUrl, titre: e.titre)).toList(),
            ),
          ),
        ),
      ],
    ),
  );
}
