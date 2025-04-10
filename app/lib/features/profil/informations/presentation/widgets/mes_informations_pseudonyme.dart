import 'package:app/features/profil/informations/presentation/bloc/mes_informations_bloc.dart';
import 'package:app/features/profil/informations/presentation/bloc/mes_informations_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class MesInformationsPseudonyme extends StatelessWidget {
  const MesInformationsPseudonyme({super.key});

  @override
  Widget build(final BuildContext context) {
    final pseudonym = context.select<MesInformationsBloc, String?>((final bloc) => bloc.state.pseudonym);

    return DsfrInput(
      label: Localisation.pseudonyme,
      hintText: Localisation.obligatoire,
      initialValue: pseudonym,
      onChanged: (final value) => context.read<MesInformationsBloc>().add(MesInformationsPseudonymChange(value)),
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.next,
      inputFormatters: [LengthLimitingTextInputFormatter(30)],
    );
  }
}
