// ignore_for_file: avoid-long-functions

import 'package:app/features/action/domain/action.dart';
import 'package:app/features/action/presentation/pages/action_page.dart';
import 'package:app/features/actions/domain/action_type.dart';
import 'package:app/features/aids/list/presentation/pages/aids_page.dart';
import 'package:app/features/services/lvao/presentation/lvao_list/pages/lvao_list_page.dart';
import 'package:app/features/services/pdcn/presentation/pdcn_list/pages/pdcn_list_page.dart';
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
    required final int aidCount,
    required final int? recipeCount,
  }) {
    List<ThemeSummaryLink> getThemeSpecificLinks() => switch (themeType) {
      ThemeType.alimentation => [
        if (recipeCount != null)
          ThemeSummaryInternalLink(
            label: '🥘 **$recipeCount** recettes délicieuses, saines et de saison',
            route: RecipesPage.name,
          ),
        const ThemeSummaryInternalLink(
          label: '🍓 **1** calendrier de fruits et légumes de saison',
          route: SeasonalFruitsAndVegetablesPage.name,
        ),
        const ThemeSummaryInternalLink(label: '🛒 Des adresses pour manger local', route: PdcnListPage.name),
      ],
      ThemeType.logement => [
        const ThemeSummaryExternalLink(label: '🧱 **1** simulateur *Mes aides Réno*', url: 'https://mesaidesreno.beta.gouv.fr/'),
      ],
      ThemeType.transport => [
        ThemeSummaryInternalLink(
          label: '🚙 **1** simulateur *Dois-je changer de voiture ?*',
          route: ActionPage.name,
          pathParams: ActionPage.pathParameters(type: ActionType.simulator, id: ActionSimulatorId.carSimulator.apiString),
        ),
        const ThemeSummaryInternalLink(label: '🚲 **1** simulateur *Mes aides vélo*', route: AideSimulateurVeloPage.name),
      ],
      ThemeType.consommation => [
        const ThemeSummaryInternalLink(label: '🔧 Des adresses de réparateur près de chez vous', route: LvaoListPage.name),
      ],
      ThemeType.decouverte => [],
    };

    List<ThemeSummaryLink> getAidLinks() => aidCount > 0
        ? [ThemeSummaryInternalLink(label: '💶 **$aidCount** aides sur votre territoire', route: AidsPage.name)]
        : [];

    return [...getThemeSpecificLinks(), ...getAidLinks()];
  }
}

sealed class ThemeSummaryLink extends Equatable {
  const ThemeSummaryLink({required this.label});

  final String label;

  @override
  List<Object?> get props => [label];
}

final class ThemeSummaryInternalLink extends ThemeSummaryLink {
  const ThemeSummaryInternalLink({required super.label, required this.route, this.pathParams});

  final String route;
  final Map<String, String>? pathParams;

  @override
  List<Object?> get props => [...super.props, route, pathParams];
}

final class ThemeSummaryExternalLink extends ThemeSummaryLink {
  const ThemeSummaryExternalLink({required super.label, required this.url});

  final String url;

  @override
  List<Object?> get props => [...super.props, url];
}
