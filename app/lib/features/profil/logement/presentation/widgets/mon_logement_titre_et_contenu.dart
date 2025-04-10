import 'package:app/features/profil/profil/presentation/widgets/profil_titre_partie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class MonLogementTitreEtContenu extends StatelessWidget {
  const MonLogementTitreEtContenu({super.key, required this.titre, required this.contenu});

  final String titre;
  final Widget contenu;

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: DsfrSpacings.s2w,
    children: [
      ProfilTitrePartie(titre: titre),
      contenu,
    ],
  );
}
