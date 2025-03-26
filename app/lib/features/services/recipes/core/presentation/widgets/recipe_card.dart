import 'package:app/core/helpers/size.dart';
import 'package:app/core/presentation/widgets/composants/card.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/features/services/recipes/core/presentation/widgets/estimaded_timed_info.dart';
import 'package:app/features/services/recipes/core/presentation/widgets/recipe_difficulty.dart';
import 'package:app/features/services/recipes/item/presentation/pages/recipe_page.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({
    super.key,
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.difficulty,
    required this.preparationTime,
  });

  final String id;
  final String imageUrl;
  final String title;
  final String difficulty;
  final int preparationTime;

  @override
  Widget build(final context) => FnvCard(
    onTap: () async => context.pushNamed(RecipePage.name, pathParameters: {'id': id}),
    child: SizedBox(
      width: screenWidth(context, percentage: 0.65),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 150,
            child: DecoratedBox(
              decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(DsfrSpacings.s1w))),
              child: FnvImage.network(imageUrl, fit: BoxFit.fitWidth),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(DsfrSpacings.s2w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const DsfrTextStyle.bodyLgBold(), maxLines: 3),
                const SizedBox(height: DsfrSpacings.s1w),
                Row(
                  spacing: DsfrSpacings.s1w,
                  children: [
                    Flexible(child: RecipeDifficulty(value: difficulty)),
                    EstimadedTimedInfo(text: '$preparationTime min'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
