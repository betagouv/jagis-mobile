import 'package:app/core/helpers/size.dart';
import 'package:app/core/presentation/widgets/composants/card.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/features/services/recipes/core/presentation/widgets/estimaded_timed_info.dart';
import 'package:app/features/services/recipes/core/presentation/widgets/recipe_difficulty.dart';
import 'package:app/features/services/recipes/item/presentation/pages/recipe_page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
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
  Widget build(final BuildContext context) => FnvCard(
    onTap: () async {
      await GoRouter.of(context).pushNamed(RecipePage.name, pathParameters: {'id': id});
    },
    child: SizedBox(
      width: screenWidth(context, percentage: 0.65),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 150, child: FnvImage.network(imageUrl, fit: BoxFit.fitWidth)),
          Padding(
            padding: const EdgeInsets.all(DsfrSpacings.s2w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: DsfrSpacings.s1w,
              children: [
                Text(title, style: const DsfrTextStyle.bodyLgBold(color: DsfrColors.grey50), maxLines: 3),
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
