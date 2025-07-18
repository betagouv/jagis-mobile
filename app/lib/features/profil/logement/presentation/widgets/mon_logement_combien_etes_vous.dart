import 'package:app/features/profil/logement/presentation/widgets/mon_logement_nombre_adultes.dart';
import 'package:app/features/profil/logement/presentation/widgets/mon_logement_nombre_enfants.dart';
import 'package:app/features/profil/profil/presentation/widgets/profil_titre_partie.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class MonLogementCombienEtesVous extends StatelessWidget {
  const MonLogementCombienEtesVous({super.key});

  @override
  Widget build(final BuildContext context) => const Column(
    children: [
      ProfilTitrePartie(titre: Localisation.combienEtesVousDansVotreLogement),
      SizedBox(height: DsfrSpacings.s2w),
      MonLogementNombreAdultes(),
      MonLogementNombreEnfants(),
    ],
  );
}
