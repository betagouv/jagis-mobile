import 'package:equatable/equatable.dart';

class HomeDashboard extends Equatable {
  const HomeDashboard({
    required this.cityName,
    required this.nbActionsDoneNational,
    required this.nbActionsDoneUser,
    required this.environmentalImpactPercentageCompletion,
  });

  final String cityName;
  final int nbActionsDoneNational;
  final int nbActionsDoneUser;
  final int environmentalImpactPercentageCompletion;

  @override
  List<Object?> get props => [cityName, nbActionsDoneNational, nbActionsDoneUser, environmentalImpactPercentageCompletion];
}
