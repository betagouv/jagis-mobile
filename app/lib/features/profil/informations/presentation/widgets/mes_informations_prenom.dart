import 'package:app/features/profil/informations/presentation/bloc/mes_informations_bloc.dart';
import 'package:app/features/profil/informations/presentation/bloc/mes_informations_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MesInformationsPrenom extends StatelessWidget {
  const MesInformationsPrenom({super.key});

  @override
  Widget build(final context) {
    final prenom = context.select<MesInformationsBloc, String?>((final bloc) => bloc.state.prenom);
    final canBeUpdated = context.select<MesInformationsBloc, bool>((final bloc) => bloc.state.isUserFranceConnect);

    return DsfrInput(
      label: Localisation.prenom,
      hintText: Localisation.facultatif,
      initialValue: prenom,
      onChanged: (final value) => context.read<MesInformationsBloc>().add(MesInformationsPrenomChange(value)),
      enabled: canBeUpdated,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.givenName],
    );
  }
}
