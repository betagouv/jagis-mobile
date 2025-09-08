import 'package:app/features/profil/profil/presentation/widgets/profil_titre_partie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class MyHomeTitleAndContent extends StatelessWidget {
  const MyHomeTitleAndContent({super.key, required this.title, required this.content});

  final String title;
  final Widget content;

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: DsfrSpacings.s2w,
    children: [
      ProfilTitrePartie(titre: title),
      content,
    ],
  );
}
