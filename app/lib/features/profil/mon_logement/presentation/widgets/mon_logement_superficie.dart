import 'package:app/features/profil/mon_logement/presentation/blocs/mon_logement_bloc.dart';
import 'package:app/features/profil/mon_logement/presentation/blocs/mon_logement_event.dart';
import 'package:app/features/profil/mon_logement/presentation/blocs/mon_logement_state.dart';
import 'package:app/features/profil/mon_logement/presentation/widgets/mon_logement_titre_et_contenu.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MonLogementSuperficie extends StatelessWidget {
  const MonLogementSuperficie({super.key});

  @override
  Widget build(final BuildContext context) {
    final superficie = context.select<MonLogementBloc, Superficie?>(
      (final bloc) => bloc.state.superficie,
    );

    return MonLogementTitreEtContenu(
      titre: Localisation.quelleEstLaSuperficie,
      contenu: DsfrRadioButtonSetHeadless(
        values: const {
          Superficie.s35: Localisation.moinsDe35m2,
          Superficie.s70: Localisation.entre35et70m2,
          Superficie.s100: Localisation.entre70et100m2,
          Superficie.s150: Localisation.entre100et150m2,
          Superficie.s150EtPlus: Localisation.plusDe150m2,
        },
        onCallback: (final value) => context
            .read<MonLogementBloc>()
            .add(MonLogementSuperficieChange(value)),
        initialValue: superficie,
      ),
    );
  }
}
