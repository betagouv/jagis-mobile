import 'package:app/features/profil/informations/presentation/bloc/mes_informations_bloc.dart';
import 'package:app/features/profil/informations/presentation/bloc/mes_informations_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MesInformationsPseudonyme extends StatelessWidget {
  const MesInformationsPseudonyme({super.key});

  @override
  Widget build(final context) {
    final pseudnoym = context.select<MesInformationsBloc, String?>((final bloc) => bloc.state.pseudnoym);

    return DsfrInput(
      label: Localisation.pseudonyme,
      hintText: Localisation.obligatoire,
      initialValue: pseudnoym,
      onChanged: (final value) => context.read<MesInformationsBloc>().add(MesInformationsPseudonymChange(value)),
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.next,
    );
  }
}
