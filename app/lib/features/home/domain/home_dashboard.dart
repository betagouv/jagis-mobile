import 'package:equatable/equatable.dart';

class HomeDashboard extends Equatable {
  HomeDashboard.fromJson(final Map<String, dynamic> json)
    : ecologicalFootprint = EcologicalFootprint(
        progressValue: json['pourcentage_bilan_done'] as int,
        carbonDioxideEquivalent: json['bilan_carbone_total_kg'] as double?,
      ),
      nbAids = json['nombre_aides'] as int,
      nbRecipes = json['nombre_recettes'] as int,
      nbActionsDoneNational = json['total_national_actions_faites'] as int;

  final EcologicalFootprint ecologicalFootprint;
  final int nbAids;
  final int nbRecipes;
  final int nbActionsDoneNational;

  @override
  List<Object?> get props => [nbActionsDoneNational, ecologicalFootprint, nbAids, nbRecipes];
}

class EcologicalFootprint extends Equatable {
  const EcologicalFootprint({required this.progressValue, required this.carbonDioxideEquivalent});

  final int progressValue;
  final double? carbonDioxideEquivalent;

  bool get isDone => progressValue == 100;

  @override
  List<Object?> get props => [progressValue, carbonDioxideEquivalent];
}
