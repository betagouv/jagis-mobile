// ignore_for_file: avoid-long-functions

import 'package:app/features/aids/list/presentation/pages/aids_page.dart';
import 'package:app/features/services/recipes/list/presentation/pages/recipes_page.dart';
import 'package:app/features/services/seasonal_fruits_and_vegetables/presentation/pages/seasonal_fruits_and_vegetables_page.dart';
import 'package:app/features/simulateur_velo/presentation/pages/aide_simulateur_velo_page.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:equatable/equatable.dart';

final class ThemeSummary extends Equatable {
  const ThemeSummary({required this.commune, required this.links});

  final String commune;
  final List<ThemeSummaryLink> links;

  @override
  List<Object> get props => [commune, links];

  static List<ThemeSummaryLink> buildThemeLinksFor({
    required final ThemeType themeType,
    required final String commune,
    required final int aidCount,
    required final int? recipeCount,
  }) {
    List<ThemeSummaryLink> getThemeSpecificLinks() => switch (themeType) {
      ThemeType.alimentation => [
        if (recipeCount != null)
          ThemeSummaryInternalLink(
            label: '🥘 **$recipeCount** recettes délicieuses, saines et de saison',
            route: RecipesPage.name,
          ),
        const ThemeSummaryInternalLink(
          label: '🍓 **1** calendrier de fruits et légumes de saison',
          route: SeasonalFruitsAndVegetablesPage.name,
        ),
        ThemeSummaryExternalLink(
          label: '🛒 Des adresses pour manger local',
          url: 'https://presdecheznous.fr/map#/carte/$commune',
        ),
      ],
      ThemeType.logement => [
        const ThemeSummaryExternalLink(label: '🧱 **1** simulateur Mes aides Réno', url: 'https://mesaidesreno.beta.gouv.fr/'),
      ],
      ThemeType.transport => [
        const ThemeSummaryExternalLink(
          label: '🚙 **1** simulateur Dois-je changer de voiture ?',
          url: 'https://jechangemavoiture.gouv.fr/jcmv/',
        ),
        const ThemeSummaryInternalLink(label: '🚲 **1** simulateur aides vélo', route: AideSimulateurVeloPage.name),
      ],
      ThemeType.consommation => [
        const ThemeSummaryExternalLink(
          label: '🔧 Des adresses de réparateur près de chez vous',
          url: 'https://longuevieauxobjets.ademe.fr/lacarte/',
        ),
      ],
      ThemeType.decouverte => [],
    };

    List<ThemeSummaryLink> getAidLinks() =>
        aidCount > 0
            ? [ThemeSummaryInternalLink(label: '💶 **$aidCount** aides sur votre territoire', route: AidsPage.name)]
            : [];

    return [...getThemeSpecificLinks(), ...getAidLinks()];
  }
}

sealed class ThemeSummaryLink extends Equatable {
  const ThemeSummaryLink({required this.label});

  final String label;

  @override
  List<Object> get props => [label];
}

final class ThemeSummaryInternalLink extends ThemeSummaryLink {
  const ThemeSummaryInternalLink({required super.label, required this.route});

  final String route;

  @override
  List<Object> get props => [...super.props, route];
}

final class ThemeSummaryExternalLink extends ThemeSummaryLink {
  const ThemeSummaryExternalLink({required super.label, required this.url});

  final String url;

  @override
  List<Object> get props => [...super.props, url];
}
