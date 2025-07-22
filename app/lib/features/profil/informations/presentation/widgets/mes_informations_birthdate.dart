import 'package:app/features/profil/informations/presentation/bloc/mes_informations_bloc.dart';
import 'package:app/features/profil/informations/presentation/bloc/mes_informations_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app_ds/app_ds.dart';
import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MesInformationsBirthdate extends StatelessWidget {
  const MesInformationsBirthdate({super.key});

  @override
  Widget build(final BuildContext context) {
    final birthdate = context.select<MesInformationsBloc, DateTime?>((final bloc) => bloc.state.birthdate);
    final isNotUserFranceConnect = context.select<MesInformationsBloc, bool>((final bloc) => bloc.state.isNotUserFranceConnect);

    return FnvDateOnlyInput(
      label: Localisation.dateDeNaissance,
      hint: Localisation.dateDeNaissanceDescription,
      maxYear: context.read<Clock>().now().year,
      initialValue: birthdate,
      onChanged: (final dateTime) {
        context.read<MesInformationsBloc>().add(MesInformationsBirthdateChanged(dateTime));
      },
      enabled: isNotUserFranceConnect,
    );
  }
}
