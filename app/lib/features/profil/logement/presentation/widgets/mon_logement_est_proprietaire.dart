import 'package:app/core/presentation/widgets/composants/radios/radio_button_group.dart';
import 'package:app/features/profil/logement/presentation/bloc/mon_logement_bloc.dart';
import 'package:app/features/profil/logement/presentation/bloc/mon_logement_event.dart';
import 'package:app/features/profil/logement/presentation/widgets/mon_logement_titre_et_contenu.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class MonLogementEstProprietaire extends StatelessWidget {
  const MonLogementEstProprietaire({super.key});

  @override
  Widget build(final BuildContext context) {
    final estProprietaire = context.select<MonLogementBloc, bool?>((final bloc) => bloc.state.estProprietaire);

    return MonLogementTitreEtContenu(
      titre: Localisation.vousEtesProprietaireDeVotreLogement,
      contenu: FnvRadioButtonGroup(
        values: const {true: Localisation.oui, false: Localisation.non},
        initialValue: estProprietaire,
        onChanged: (final value) => context.read<MonLogementBloc>().add(MonLogementEstProprietaireChange(value)),
        direction: Direction.horizontal,
        size: DsfrComponentSize.md,
      ),
    );
  }
}
