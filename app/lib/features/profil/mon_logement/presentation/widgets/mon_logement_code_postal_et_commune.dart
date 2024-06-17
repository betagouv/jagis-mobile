import 'package:app/features/profil/mon_logement/presentation/blocs/mon_logement_bloc.dart';
import 'package:app/features/profil/mon_logement/presentation/blocs/mon_logement_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MonLogementCodePostalEtCommune extends StatefulWidget {
  const MonLogementCodePostalEtCommune({super.key});

  @override
  State<MonLogementCodePostalEtCommune> createState() =>
      _MonLogementCodePostalEtCommuneState();
}

class _MonLogementCodePostalEtCommuneState
    extends State<MonLogementCodePostalEtCommune> {
  late final _textEditingController = TextEditingController();

  void _handleCommune(final BuildContext context, final String? value) {
    if (value == null) {
      return;
    }
    context.read<MonLogementBloc>().add(MonLogementCommuneChange(value));
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final codePostal = context
        .select<MonLogementBloc, String>((final bloc) => bloc.state.codePostal);
    final communes = context.select<MonLogementBloc, List<String>>(
      (final bloc) => bloc.state.communes,
    );
    final commune = context
        .select<MonLogementBloc, String>((final bloc) => bloc.state.commune);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.textScalerOf(context).scale(97),
          child: DsfrInput(
            label: Localisation.codePostal,
            onChanged: (final value) => context
                .read<MonLogementBloc>()
                .add(MonLogementCodePostalChange(value)),
            initialValue: codePostal,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(5),
            ],
          ),
        ),
        const SizedBox(width: DsfrSpacings.s2w),
        Expanded(
          child: DsfrSelect<String>(
            label: Localisation.commune,
            dropdownMenuEntries: communes
                .map((final e) => DropdownMenuEntry(value: e, label: e))
                .toList(),
            onSelected: (final value) => _handleCommune(context, value),
            controller: _textEditingController,
            initialSelection: commune,
          ),
        ),
      ],
    );
  }
}
