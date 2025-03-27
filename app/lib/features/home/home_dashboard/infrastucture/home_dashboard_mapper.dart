import 'package:app/features/home/home_dashboard/domain/home_dashboard.dart';

class HomeDashboardMapper {
  const HomeDashboardMapper._();

  static HomeDashboard fromJson(final Map<String, dynamic> json) => HomeDashboard(
    cityName: json['nom_commune'] as String,
    nbActionsDoneNational: json['total_national_actions_faites'] as int,
    nbActionsDoneUser: json['total_utilisateur_actions_faites'] as int,
    environmentalImpactPercentageCompletion: json['pourcentage_bilan_done'] as int,
  );
}
