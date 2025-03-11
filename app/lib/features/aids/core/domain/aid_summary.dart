import 'package:app/features/articles/domain/partner.dart';
import 'package:equatable/equatable.dart';

class AidSummary extends Equatable {
  const AidSummary({
    required this.id,
    required this.title,
    required this.scale,
    required this.maxAmount,
    required this.isFree,
    required this.partner,
  });

  final String id;
  final String title;
  final GeographicalScale scale;
  final int maxAmount;
  final bool isFree;
  final Partner partner;

  @override
  List<Object?> get props => [id, title, scale, maxAmount, isFree, partner];
}

// NOTE(erolley): should we move this to a separate file?
enum GeographicalScale {
  country(label: 'National'),
  region(label: 'Région'),
  departement(label: 'Département'),
  metropole(label: 'Métropole'),
  agglomeration(label: 'Agglomération'),
  cc(label: 'Communauté de communes'),
  cu(label: 'Communauté urbaine'),
  ca(label: "Communauté d'agglomération"),
  city(label: 'Commune');

  const GeographicalScale({required this.label});

  final String label;
}
