import 'package:equatable/equatable.dart';

class Informations extends Equatable {
  const Informations({
    required this.email,
    required this.pseudonym,
    required this.isUserFranceConnect,
    required this.prenom,
    required this.nom,
    required this.anneeDeNaissance,
    required this.moisDeNaissance,
    required this.jourDeNaissance,
    required this.codePostal,
    required this.codeInsee,
    required this.nombreDePartsFiscales,
    required this.revenuFiscal,
  });

  final String email;
  final String? pseudonym;
  final bool isUserFranceConnect;
  final String? prenom;
  final String? nom;
  final int? anneeDeNaissance;
  final int? moisDeNaissance;
  final int? jourDeNaissance;
  final String? codePostal;
  final String? codeInsee;
  final double nombreDePartsFiscales;
  final int? revenuFiscal;

  @override
  List<Object?> get props => [
    email,
    pseudonym,
    isUserFranceConnect,
    prenom,
    nom,
    anneeDeNaissance,
    codePostal,
    codeInsee,
    nombreDePartsFiscales,
    revenuFiscal,
    moisDeNaissance,
    jourDeNaissance,
  ];
}
