import 'package:equatable/equatable.dart';

final class ServiceItem extends Equatable {
  const ServiceItem({
    required this.idService,
    required this.titre,
    required this.sousTitre,
    required this.externalUrl,
  });

  final String idService;
  final String titre;
  final String sousTitre;
  final String externalUrl;

  bool get isFruitsLegumesService => idService == 'fruits_legumes';

  @override
  List<Object?> get props => [idService, titre, sousTitre, externalUrl];
}
