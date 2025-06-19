import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:equatable/equatable.dart';

class HomeDashboard extends Equatable {
  HomeDashboard.fromJson(final Map<String, dynamic> json)
    : ecologicalFootprint = EcologicalFootprint(
        progressValue: json['pourcentage_bilan_done'] as int,
        carbonDioxideEquivalent: (json['bilan_carbone_total_kg'] as num?)?.toDouble(),
      ),
      themes = Themes(
        list: [
          ThemeEvolution(themeType: ThemeType.alimentation, percentage: json['pourcentage_alimentation_reco_done'] as int),
          ThemeEvolution(themeType: ThemeType.transport, percentage: json['pourcentage_transport_reco_done'] as int),
          ThemeEvolution(themeType: ThemeType.logement, percentage: json['pourcentage_logement_reco_done'] as int),
          ThemeEvolution(themeType: ThemeType.consommation, percentage: json['pourcentage_consommation_reco_done'] as int),
        ],
        percentage: json['pourcentage_global_reco_done'] as int,
      ),
      nbAids = json['nombre_aides'] as int,
      nbRecipes = json['nombre_recettes'] as int,
      nbActionsDoneNational = json['total_national_actions_faites'] as int;

  final EcologicalFootprint ecologicalFootprint;
  final Themes themes;
  final int nbAids;
  final int nbRecipes;
  final int nbActionsDoneNational;

  @override
  List<Object?> get props => [nbActionsDoneNational, ecologicalFootprint, nbAids, nbRecipes, themes];
}

class EcologicalFootprint extends Equatable {
  const EcologicalFootprint({required this.progressValue, required this.carbonDioxideEquivalent});

  final int progressValue;
  final double? carbonDioxideEquivalent;

  bool get isDone => progressValue == 100;

  @override
  List<Object?> get props => [progressValue, carbonDioxideEquivalent];
}

class Themes extends Equatable {
  const Themes({required this.list, required this.percentage});

  final List<ThemeEvolution> list;
  final int percentage;
  bool get areNotDone => percentage != 100;

  @override
  List<Object?> get props => [list, percentage];
}

class ThemeEvolution extends Equatable {
  const ThemeEvolution({required this.themeType, required final int percentage}) : isDone = percentage == 100;

  final ThemeType themeType;
  final bool isDone;

  @override
  List<Object?> get props => [themeType, isDone];
}
