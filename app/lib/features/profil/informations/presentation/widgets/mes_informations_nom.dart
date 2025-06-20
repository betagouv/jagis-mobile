import 'package:app/features/profil/informations/presentation/bloc/mes_informations_bloc.dart';
import 'package:app/features/profil/informations/presentation/bloc/mes_informations_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class MesInformationsNom extends StatelessWidget {
  const MesInformationsNom({super.key});

  @override
  Widget build(final BuildContext context) {
    final nom = context.select<MesInformationsBloc, String?>((final bloc) => bloc.state.nom);
    final isNotUserFranceConnect = context.select<MesInformationsBloc, bool>((final bloc) => bloc.state.isNotUserFranceConnect);

    return DsfrInput(
      label: Localisation.nom,
      hintText: Localisation.facultatif,
      initialValue: nom,
      onChanged: (final value) => context.read<MesInformationsBloc>().add(MesInformationsNomChange(value)),
      enabled: isNotUserFranceConnect,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.familyName],
    );
  }
}
