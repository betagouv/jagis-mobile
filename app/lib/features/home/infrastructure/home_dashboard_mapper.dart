import 'package:app/features/home/domain/home_dashboard.dart';

abstract final class HomeDashboardMapper {
  const HomeDashboardMapper._();

  static HomeDashboard fromJson(final Map<String, dynamic> json) => HomeDashboard(
    communeName: json['nom_commune'] as String,
    nbActionsDoneNational: json['total_national_actions_faites'] as int,
    nbActionsDoneUser: json['total_utilisateur_actions_faites'] as int,
    environmentalImpactPercentageCompletion: json['pourcentage_bilan_done'] as int,
    environmentalKgCO2e: json['bilan_carbone_total_kg'] as double?,
    nbAids: json['nombre_aides'] as int,
    nbRecipies: json['nombre_recettes'] as int,
  );
}
