import 'package:app/core/infrastructure/markdown.dart';
import 'package:app/features/services/recipes/action/presentation/bloc/action_recipes_bloc.dart';
import 'package:app/features/services/recipes/action/presentation/bloc/action_recipes_event.dart';
import 'package:app/features/services/recipes/action/presentation/bloc/action_recipes_state.dart';
import 'package:app/features/services/recipes/core/presentation/widgets/recipe_card.dart';
import 'package:app/features/services/recipes/list/presentation/pages/recipes_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RecipeHorizontalList extends StatelessWidget {
  const RecipeHorizontalList({super.key, required this.category});

  final String category;

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (final context) => ActionRecipesBloc(repository: context.read())..add(ActionRecipesLoadRequested(category)),
    child: const _Part(),
  );
}

class _Part extends StatelessWidget {
  const _Part();

  @override
  Widget build(final BuildContext context) => BlocBuilder<ActionRecipesBloc, ActionRecipesState>(
    builder: (final context, final state) => switch (state) {
      ActionRecipesInitial() || ActionRecipesLoadInProgress() || ActionRecipesLoadFailure() => const SizedBox.shrink(),
      ActionRecipesLoadSuccess() => _Success(state: state),
    },
  );
}

class _Success extends StatelessWidget {
  const _Success({required this.state});

  final ActionRecipesLoadSuccess state;

  @override
  Widget build(final BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: DsfrSpacings.s2w,
      children: [
        const FnvMarkdown(data: Localisation.besoinDInspiration, p: DsfrTextStyle(fontSize: 22)),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: IntrinsicHeight(
            child: Row(
              spacing: DsfrSpacings.s2w,
              children: state.recipes
                  .map(
                    (final e) => RecipeCard(
                      id: e.id,
                      imageUrl: e.imageUrl,
                      title: e.title,
                      difficulty: e.difficulty,
                      preparationTime: e.preparationTime,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),

        DsfrLink.md(
          label: Localisation.voirToutesLesRecettes,
          // TODO(erolley): add category (vegetarian, etc...) to the route
          onTap: () async {
            await GoRouter.of(context).pushNamed(RecipesPage.name);
          },
        ),
      ],
    ),
  );
}
