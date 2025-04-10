import 'package:app/core/presentation/widgets/composants/input_calendar.dart';
import 'package:app/features/profil/informations/presentation/bloc/mes_informations_bloc.dart';
import 'package:app/features/profil/informations/presentation/bloc/mes_informations_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MesInformationsBirthdate extends StatelessWidget {
  const MesInformationsBirthdate({super.key});

  @override
  Widget build(final context) {
    final birthdate = context.select<MesInformationsBloc, DateTime?>((final bloc) => bloc.state.birthdate);
    final isNotUserFranceConnect = context.select<MesInformationsBloc, bool>((final bloc) => bloc.state.isNotUserFranceConnect);

    return FnvInputCalendar(
      hintText: Localisation.dateDeNaissanceDescription,
      label: Localisation.dateDeNaissance,
      initialValue: birthdate,
      onDateSelected: (final birthdate) {
        if (birthdate != null) {
          context.read<MesInformationsBloc>().add(MesInformationsBirthdateChanged(birthdate));
        }
      },
      enabled: isNotUserFranceConnect,
    );
  }
}
