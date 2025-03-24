// ignore_for_file: avoid-long-functions

import 'package:app/core/infrastructure/timed_delay.dart';
import 'package:app/features/aids/list/presentation/pages/aids_page.dart';
import 'package:app/features/services/recipes/list/presentation/pages/recipes_page.dart';
import 'package:app/features/services/seasonal_fruits_and_vegetables/presentation/pages/seasonal_fruits_and_vegetables_page.dart';
import 'package:app/features/simulateur_velo/presentation/pages/aide_simulateur_velo_page.dart';
import 'package:app/features/theme/core/domain/theme_info.dart';
import 'package:app/features/theme/core/domain/theme_summary.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/features/theme/core/infrastructure/theme_repository.dart';
import 'package:app/features/theme/presentation/bloc/theme_event.dart';
import 'package:app/features/theme/presentation/bloc/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({required final ThemeRepository themeRepository, required final TimedDelay timedDelay})
    : _themeRepository = themeRepository,
      _timedDelay = timedDelay,
      super(const ThemeInitial()) {
    on<ThemeFetchRequested>(_onFetch);
    on<ThemeRefreshRequested>(_onRefresh);
    on<ThemeResetRequested>(_onReset);
    on<ThemeReplaceActionRequested>(_onReplaceAction);
  }

  final ThemeRepository _themeRepository;
  final TimedDelay _timedDelay;

  Future<void> _onFetch(final ThemeFetchRequested event, final Emitter<ThemeState> emit) async {
    emit(const ThemeLoadInProgress());
    final themeType = event.themeType;
    final themeDataResult = await _themeRepository.fetchTheme(themeType: themeType);
    final servicesResult = await _themeRepository.getServices(themeType);
    themeDataResult.fold(
      (final l) => emit(ThemeLoadFailure(errorMessage: l.toString())),
      (final theme) => servicesResult.fold(
        (final l) => emit(ThemeLoadFailure(errorMessage: l.toString())),
        (final services) => emit(
          ThemeLoadSuccess(
            theme: theme,
            summary: ThemeSummary(commune: theme.communeName, links: _buildThemeLinks(theme)),
            services: services,
          ),
        ),
      ),
    );
  }

  Future<void> _onRefresh(final ThemeRefreshRequested event, final Emitter<ThemeState> emit) async {
    final blocState = state;
    if (blocState is ThemeLoadSuccess) {
      final themeType = blocState.theme.themeType;
      await _themeRepository.confirmCustomization(themeType: themeType);
      final themeDataResult = await _themeRepository.fetchTheme(themeType: themeType);

      await _timedDelay.simulateDelay();

      themeDataResult.fold(
        (final l) => emit(ThemeLoadFailure(errorMessage: l.toString())),
        (final theme) => emit(blocState.copyWith(theme: theme)),
      );
    }
  }

  Future<void> _onReset(final ThemeResetRequested event, final Emitter<ThemeState> emit) async {
    final blocState = state;
    if (blocState is ThemeLoadSuccess) {
      final themeType = blocState.theme.themeType;
      await _themeRepository.resetCustomization(themeType: themeType);
      final themeDataResult = await _themeRepository.fetchTheme(themeType: themeType);
      themeDataResult.fold(
        (final l) => emit(ThemeLoadFailure(errorMessage: l.toString())),
        (final theme) => emit(
          blocState.copyWith(theme: theme, summary: ThemeSummary(commune: theme.communeName, links: _buildThemeLinks(theme))),
        ),
      );
    }
  }

  Future<void> _onReplaceAction(final ThemeReplaceActionRequested event, final Emitter<ThemeState> emit) async {
    final blocState = state;
    if (blocState is ThemeLoadSuccess) {
      final themeType = blocState.theme.themeType;
      await _themeRepository.replaceAction(themeType: themeType, actionSummary: event.action);
      final themeDataResult = await _themeRepository.fetchTheme(themeType: themeType);
      themeDataResult.fold(
        (final l) => emit(ThemeLoadFailure(errorMessage: l.toString())),
        (final theme) => emit(
          blocState.copyWith(theme: theme, summary: ThemeSummary(commune: theme.communeName, links: _buildThemeLinks(theme))),
        ),
      );
    }
  }

  List<ThemeSummaryLink> _buildThemeLinks(final ThemeInfo theme) {
    List<ThemeSummaryLink> getThemeSpecificLinks(final ThemeInfo theme) {
      switch (theme.themeType) {
        case ThemeType.alimentation:
          return [
            if (theme.recipeCount != null)
              ThemeSummaryInternalLink(
                label: '**${theme.recipeCount}** recettes délicieuses, saines et de saison',
                route: RecipesPage.name,
              ),
            const ThemeSummaryInternalLink(
              label: '**1** calendrier de fruits et légumes de saison',
              route: SeasonalFruitsAndVegetablesPage.name,
            ),
            ThemeSummaryExternalLink(
              label: 'Des adresses pour manger local',
              url: 'https://presdecheznous.fr/map#/carte/${theme.communeName}',
            ),
          ];
        case ThemeType.logement:
          return [
            const ThemeSummaryExternalLink(
              label: '**1** simulateur Mes aides Rénovation',
              url: 'https://mesaidesreno.beta.gouv.fr/',
            ),
          ];
        case ThemeType.transport:
          return [
            const ThemeSummaryExternalLink(
              label: '**1** simulateur Dois-je changer de voiture ?',
              url: 'https://jechangemavoiture.gouv.fr/jcmv/',
            ),
            const ThemeSummaryInternalLink(label: '**1** simulateur aides vélo', route: AideSimulateurVeloPage.name),
          ];
        case ThemeType.consommation:
          return [
            const ThemeSummaryExternalLink(
              label: 'Des adresses de réparateur près de chez vous',
              url: 'https://longuevieauxobjets.ademe.fr/lacarte/',
            ),
          ];
        case ThemeType.decouverte:
          throw UnimplementedError();
      }
    }

    List<ThemeSummaryLink> getAidLinks(final int aidCount) =>
        aidCount > 0 ? [ThemeSummaryInternalLink(label: '**$aidCount** aides sur votre territoire', route: AidsPage.name)] : [];

    return [...getThemeSpecificLinks(theme), ...getAidLinks(theme.aidCount)];
  }
}
