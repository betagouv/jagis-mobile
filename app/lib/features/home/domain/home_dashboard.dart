import 'package:equatable/equatable.dart';

class HomeDashboard extends Equatable {
  const HomeDashboard({
    required this.communeName,
    required this.nbActionsDoneNational,
    required this.nbActionsDoneUser,
    required this.environmentalImpactPercentageCompletion,
    required this.nbAids,
    required this.nbRecipies,
  });

  final String communeName;
  final int nbActionsDoneNational;
  final int nbActionsDoneUser;
  final int environmentalImpactPercentageCompletion;
  final int nbAids;
  final int nbRecipies;

  @override
  List<Object?> get props => [
    communeName,
    nbActionsDoneNational,
    nbActionsDoneUser,
    environmentalImpactPercentageCompletion,
    nbAids,
    nbRecipies,
  ];
}
