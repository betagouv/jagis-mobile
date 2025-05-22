import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class ProfilTitrePartie extends StatelessWidget {
  const ProfilTitrePartie({super.key, required this.titre});

  final String titre;

  @override
  Widget build(final BuildContext context) => Text(titre, style: const DsfrTextStyle.headline4(color: DsfrColors.grey50));
}
