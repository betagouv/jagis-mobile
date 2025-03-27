import 'package:app/features/profil/informations/presentation/bloc/mes_informations_bloc.dart';
import 'package:app/features/profil/informations/presentation/bloc/mes_informations_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:clock/clock.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

final _dateFormat = DateFormat('dd/MM/yyyy', 'fr_FR');

class MesInformationsBirthdate extends StatelessWidget {
  const MesInformationsBirthdate({super.key});

  @override
  Widget build(final context) {
    final birthdate = context.select<MesInformationsBloc, DateTime?>((final bloc) => bloc.state.birthdate);
    final controller = TextEditingController(text: birthdate == null ? '' : _dateFormat.format(birthdate));
    final canBeUpdated = context.select<MesInformationsBloc, bool>((final bloc) => bloc.state.isUserFranceConnect);

    return GestureDetector(
      onTap:
          canBeUpdated
              ? () async {
                final now = context.read<Clock>().now();
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: birthdate ?? DateTime(now.year - 18),
                  firstDate: DateTime(now.year - 123),
                  lastDate: now,
                );

                if (context.mounted && selectedDate != null) {
                  controller.text = _dateFormat.format(selectedDate);
                  context.read<MesInformationsBloc>().add(MesInformationsBirthdateChanged(selectedDate));
                }
              }
              : null,
      child: AbsorbPointer(child: DsfrInput(label: Localisation.dateDeNaissance, controller: controller, enabled: canBeUpdated)),
    );
  }
}
