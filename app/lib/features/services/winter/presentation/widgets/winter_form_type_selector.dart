import 'package:app/features/services/winter/domain/winter_registration.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_bloc.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_event.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_state.dart';
import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class WinterFormTypeSelector extends StatelessWidget {
  const WinterFormTypeSelector({super.key});

  @override
  Widget build(final BuildContext context) => ColoredBox(
    color: const Color(0xFFF7F7FC),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: FnvRadiosGroup(
        values: const {RegistrationType.address: 'Avec mon adresse postale', RegistrationType.prm: 'Avec mon numéro de PRM'},
        initialValue: context.select<WinterBloc, RegistrationType>((final bloc) {
          final current = bloc.state;
          if (current is! WinterForm) {
            return RegistrationType.address;
          }

          return current.formType;
        }),
        onChanged: (final value) {
          if (value != null) {
            context.read<WinterBloc>().add(WinterFormTypeChanged(value));
          }
        },
        direction: Direction.vertical,
        size: DsfrComponentSize.md,
        isRich: false,
      ),
    ),
  );
}
