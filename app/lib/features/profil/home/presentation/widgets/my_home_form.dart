import 'package:app/features/profil/home/presentation/bloc/my_home_state.dart';
import 'package:app/features/profil/home/presentation/widgets/my_home_address.dart';
import 'package:app/features/profil/home/presentation/widgets/my_home_area.dart';
import 'package:app/features/profil/home/presentation/widgets/my_home_energy_performance.dart';
import 'package:app/features/profil/home/presentation/widgets/my_home_how_many_of_you.dart';
import 'package:app/features/profil/home/presentation/widgets/my_home_is_owner.dart';
import 'package:app/features/profil/home/presentation/widgets/my_home_main_residence.dart';
import 'package:app/features/profil/home/presentation/widgets/my_home_over_15_years.dart';
import 'package:app/features/profil/profil/presentation/widgets/fnv_title.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class MyHomeForm extends StatelessWidget {
  const MyHomeForm({super.key, required this.success});

  final MyHomeLoadSuccess success;

  @override
  Widget build(final BuildContext context) => SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(DsfrSpacings.s2w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: DsfrSpacings.s3w,
        children: [
          const FnvTitle(title: Localisation.monLogement),
          MyHomeAddress(address: success.logement.address, municipalities: success.municipalities),
          MyHomeHowManyOfYou(nombreAdultes: success.logement.numberOfAdults, nombreEnfants: success.logement.numberOfChildren),
          MyHomeMainResidence(typeDeLogement: success.logement.housingType),
          MyHomeIsOwner(estProprietaire: success.logement.isOwner),
          MyHomeArea(superficie: success.logement.area),
          MyHomeOver15Years(plusDe15Ans: success.logement.over15Years),
          MyHomeEnergyPerformance(dpe: success.logement.energyPerformance),
        ],
      ),
    ),
  );
}
