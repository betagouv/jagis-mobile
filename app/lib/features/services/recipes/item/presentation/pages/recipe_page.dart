import 'package:app/core/helpers/number_format.dart';
import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/services/recipes/core/presentation/widgets/estimaded_timed_info.dart';
import 'package:app/features/services/recipes/core/presentation/widgets/recipe_difficulty.dart';
import 'package:app/features/services/recipes/item/presentation/bloc/recipe_bloc.dart';
import 'package:app/features/services/recipes/item/presentation/bloc/recipe_event.dart';
import 'package:app/features/services/recipes/item/presentation/bloc/recipe_state.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:go_router/go_router.dart';

class RecipePage extends StatelessWidget {
  const RecipePage({super.key, required this.id});

  static const name = 'recette';
  static const path = 'recettes/:id';

  static GoRoute get route => GoRoute(
    path: path,
    name: name,
    builder: (final context, final state) => RecipePage(id: state.pathParameters['id']!),
  );

  final String id;

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (final context) => RecipeBloc(repository: context.read())..add(RecipeLoadRequested(id: id)),
    child: FnvScaffold(appBar: FnvAppBar(), body: const _Body()),
  );
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(final BuildContext context) => BlocBuilder<RecipeBloc, RecipeState>(
    builder: (final context, final state) => switch (state) {
      RecipeInitial() || RecipeLoadInProgress() => const Center(child: CircularProgressIndicator()),
      RecipeLoadSuccess() => _Success(state),
      RecipeLoadFailure() => const Center(child: Text('Erreur lors du chargement de la recette')),
    },
  );
}

class _Success extends StatelessWidget {
  const _Success(this.state);

  final RecipeLoadSuccess state;

  /// Le backend, nous envoie des chaînes de caractères avec des caractères Unicode échappés uniquement sur les étapes
  String _decodeUnicodeEscapes(final String input) =>
      input.replaceAllMapped(RegExp(r'\\u([0-9a-fA-F]{4})'), (final m) => String.fromCharCode(int.parse(m.group(1)!, radix: 16)));

  @override
  Widget build(final BuildContext context) {
    final fontTitleColor = DsfrColorDecisions.textTitleGrey(context);
    final recipe = state.recipe;

    return ListView(
      children: [
        FnvImage.network(recipe.imageUrl, height: 94, fit: BoxFit.cover),
        Padding(
          padding: const EdgeInsets.all(paddingVerticalPage),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: RecipeDifficulty(value: recipe.difficulty),
              ),
              const SizedBox(height: DsfrSpacings.s1v),
              Text(recipe.title, style: DsfrTextStyle.headline2(color: fontTitleColor)),
              const SizedBox(height: DsfrSpacings.s1v),
              EstimadedTimedInfo(text: Localisation.tempsDePreparation(recipe.preparationTime)),
              const SizedBox(height: DsfrSpacings.s2w),
              Text(Localisation.ingredients, style: DsfrTextStyle.headline4(color: fontTitleColor)),
              const SizedBox(height: DsfrSpacings.s2w),
              ...recipe.ingredients
                  .map(
                    (final e) => Text(
                      [
                        FnvNumberFormat.formatNumber(e.quantity),
                        e.unit,
                        e.name,
                      ].where((final element) => element.isNotEmpty).join(' '),
                      style: const DsfrTextStyle.bodyMd(color: DsfrColors.grey50),
                    ),
                  )
                  .separator(const SizedBox(height: DsfrSpacings.s1w)),
              const SizedBox(height: DsfrSpacings.s2w),
              Text(Localisation.etapes, style: DsfrTextStyle.headline4(color: fontTitleColor)),
              const SizedBox(height: DsfrSpacings.s2w),
              ...recipe.steps
                  .map((final e) {
                    final fontColor = DsfrColorDecisions.textLabelGrey(context);

                    return Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '${e.order}. ',
                            style: DsfrTextStyle.bodyMdBold(color: fontColor),
                          ),
                          TextSpan(text: _decodeUnicodeEscapes(e.description)),
                        ],
                      ),
                      style: DsfrTextStyle.bodyMd(color: fontColor),
                    );
                  })
                  .separator(const SizedBox(height: DsfrSpacings.s1w)),
              const SizedBox(height: DsfrSpacings.s2w),
              Text(
                Localisation.santePubliqueFrance,
                style: DsfrTextStyle.bodyMd(color: DsfrColorDecisions.textLabelGrey(context)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
