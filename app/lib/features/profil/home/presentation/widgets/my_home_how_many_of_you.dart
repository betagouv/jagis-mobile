import 'package:app/features/profil/home/presentation/widgets/my_home_number_of_adults.dart';
import 'package:app/features/profil/home/presentation/widgets/my_home_number_of_children.dart';
import 'package:app/features/profil/profil/presentation/widgets/profil_titre_partie.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class MyHomeHowManyOfYou extends StatelessWidget {
  const MyHomeHowManyOfYou({super.key, required this.nombreAdultes, required this.nombreEnfants});

  final int? nombreAdultes;
  final int? nombreEnfants;

  @override
  Widget build(final BuildContext context) => Column(
    children: [
      const ProfilTitrePartie(titre: Localisation.combienEtesVousDansVotreLogement),
      const SizedBox(height: DsfrSpacings.s2w),
      MyHomeNumberOfAdults(numberOfAdults: nombreAdultes),
      MyHomeNumberOfChildren(numberOfChildren: nombreEnfants),
    ],
  );
}
