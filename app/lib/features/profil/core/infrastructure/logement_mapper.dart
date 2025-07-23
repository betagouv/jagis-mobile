import 'package:app/core/address/address.dart';
import 'package:app/features/profil/home/domain/area.dart';
import 'package:app/features/profil/home/domain/energy_performance.dart';
import 'package:app/features/profil/home/domain/home.dart';
import 'package:app/features/profil/home/domain/type_de_logement.dart';

abstract final class LogementMapper {
  const LogementMapper._();

  static Map<String, dynamic> mapLogementToJson(final Home logement) => {
    'latitude': logement.address.latitude,
    'longitude': logement.address.longitude,
    'numero_rue': logement.address.houseNumber,
    'rue': logement.address.street,
    'code_postal': logement.address.postCode,
    'code_commune': logement.address.cityCode,
    'dpe': _mapDpeToJson(logement.energyPerformance),
    'nombre_adultes': logement.numberOfAdults,
    'nombre_enfants': logement.numberOfChildren,
    'plus_de_15_ans': logement.over15Years,
    'proprietaire': logement.isOwner,
    'superficie': _mapSuperficieToJson(logement.area),
    'type': _mapTypeDeLogementToJson(logement.housingType),
  }..removeWhere((final key, final value) => value == null);

  static Home mapLogementFromJson(final Map<String, dynamic> json) => Home(
    address: Address.fromJson(json),
    numberOfAdults: (json['nombre_adultes'] as num?)?.toInt(),
    numberOfChildren: (json['nombre_enfants'] as num?)?.toInt(),
    housingType: _mapTypeDeLogementFromJson(json['type'] as String?),
    isOwner: json['proprietaire'] as bool?,
    area: _mapSuperficieFromJson(json['superficie'] as String?),
    over15Years: json['plus_de_15_ans'] as bool?,
    energyPerformance: _mapDpeFromJson(json['dpe'] as String?),
    isPrmPresent: json['est_prm_present'] as bool,
    isPrmObsolete: json['est_prm_obsolete'] as bool,
    isAddressComplete: json['est_adresse_complete'] as bool,
  );

  static String? _mapDpeToJson(final EnergyPerformance? dpe) => switch (dpe) {
    EnergyPerformance.a => 'A',
    EnergyPerformance.b => 'B',
    EnergyPerformance.c => 'C',
    EnergyPerformance.d => 'D',
    EnergyPerformance.e => 'E',
    EnergyPerformance.f => 'F',
    EnergyPerformance.g => 'G',
    EnergyPerformance.jeNeSaisPas => 'ne_sais_pas',
    null => null,
  };

  static EnergyPerformance? _mapDpeFromJson(final String? dpe) => switch (dpe) {
    'A' => EnergyPerformance.a,
    'B' => EnergyPerformance.b,
    'C' => EnergyPerformance.c,
    'D' => EnergyPerformance.d,
    'E' => EnergyPerformance.e,
    'F' => EnergyPerformance.f,
    'G' => EnergyPerformance.g,
    'ne_sais_pas' => EnergyPerformance.jeNeSaisPas,
    _ => null,
  };

  static String? _mapSuperficieToJson(final Area? superficie) => switch (superficie) {
    Area.s35 => 'superficie_35',
    Area.s70 => 'superficie_70',
    Area.s100 => 'superficie_100',
    Area.s150 => 'superficie_150',
    Area.s150EtPlus => 'superficie_150_et_plus',
    null => null,
  };

  static Area? _mapSuperficieFromJson(final String? superficie) => switch (superficie) {
    'superficie_35' => Area.s35,
    'superficie_70' => Area.s70,
    'superficie_100' => Area.s100,
    'superficie_150' => Area.s150,
    'superficie_150_et_plus' => Area.s150EtPlus,
    _ => null,
  };

  static String? _mapTypeDeLogementToJson(final TypeDeLogement? typeDeLogement) => switch (typeDeLogement) {
    TypeDeLogement.appartement => 'appartement',
    TypeDeLogement.maison => 'maison',
    null => null,
  };

  static TypeDeLogement? _mapTypeDeLogementFromJson(final String? type) => switch (type) {
    'appartement' => TypeDeLogement.appartement,
    'maison' => TypeDeLogement.maison,
    _ => null,
  };
}
