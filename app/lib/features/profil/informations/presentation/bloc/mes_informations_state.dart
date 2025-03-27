import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

enum MesInformationsStatut { initial, chargement, succes }

@immutable
final class MesInformationsState extends Equatable {
  const MesInformationsState({
    required this.isUserFranceConnect,
    required this.email,
    required this.pseudonym,
    required this.prenom,
    required this.nom,
    required this.birthdate,
    required this.nombreDePartsFiscales,
    required this.revenuFiscal,
    required this.statut,
  });

  const MesInformationsState.empty()
    : this(
        isUserFranceConnect: false,
        email: '',
        pseudonym: '',
        prenom: '',
        nom: '',
        birthdate: null,
        nombreDePartsFiscales: 0,
        revenuFiscal: null,
        statut: MesInformationsStatut.initial,
      );

  final bool isUserFranceConnect;
  final String email;
  final String? pseudonym;
  final String? prenom;
  final String? nom;
  final DateTime? birthdate;
  final double nombreDePartsFiscales;
  final int? revenuFiscal;
  final MesInformationsStatut statut;

  MesInformationsState copyWith({
    final String? email,
    final String? pseudonym,
    final bool? isUserFranceConnect,
    final String? prenom,
    final String? nom,
    final DateTime? birthdate,
    final double? nombreDePartsFiscales,
    final int? revenuFiscal,
    final MesInformationsStatut? statut,
  }) => MesInformationsState(
    isUserFranceConnect: isUserFranceConnect ?? this.isUserFranceConnect,
    email: email ?? this.email,
    pseudonym: pseudonym ?? this.pseudonym,
    prenom: prenom ?? this.prenom,
    nom: nom ?? this.nom,
    birthdate: birthdate ?? this.birthdate,
    nombreDePartsFiscales: nombreDePartsFiscales ?? this.nombreDePartsFiscales,
    revenuFiscal: revenuFiscal ?? this.revenuFiscal,
    statut: statut ?? this.statut,
  );

  @override
  List<Object?> get props => [
    isUserFranceConnect,
    email,
    pseudonym,
    prenom,
    nom,
    birthdate,
    nombreDePartsFiscales,
    revenuFiscal,
    statut,
  ];
}
