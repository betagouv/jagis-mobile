import 'package:app/features/profil/informations/presentation/bloc/mes_informations_bloc.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class MesInformationsEmail extends StatelessWidget {
  const MesInformationsEmail({super.key});

  @override
  Widget build(final BuildContext context) {
    final email = context.select<MesInformationsBloc, String>((final bloc) => bloc.state.email);

    return Text.rich(
      TextSpan(
        style: const DsfrTextStyle.bodyMd(color: DsfrColors.grey50),
        children: <TextSpan>[
          const TextSpan(text: Localisation.mesInformationsAdresseEmail),
          TextSpan(
            text: email,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
