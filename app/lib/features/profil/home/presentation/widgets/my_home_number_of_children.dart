import 'package:app/core/helpers/text_scaler.dart';
import 'package:app/features/profil/home/presentation/bloc/my_home_bloc.dart';
import 'package:app/features/profil/home/presentation/bloc/my_home_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class MyHomeNumberOfChildren extends StatelessWidget {
  const MyHomeNumberOfChildren({super.key, required this.numberOfChildren});

  final int? numberOfChildren;

  @override
  Widget build(final BuildContext context) {
    const enfants = Localisation.enfants;

    return Row(
      spacing: DsfrSpacings.s1v,
      children: [
        SizedBox(
          width: adjustTextSize(context, 97),
          child: DsfrInputHeadless(
            key: const ValueKey(enfants),
            initialValue: numberOfChildren?.toString(),
            onChanged: (final value) {
              final newValue = int.tryParse(value);
              if (newValue == null) {
                return;
              }
              context.read<MyHomeBloc>().add(MyHomeDataUpdated(numberOfChildren: newValue));
            },
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
        ),
        const Expanded(
          child: Text(enfants, style: DsfrTextStyle.bodySm(color: DsfrColors.grey50)),
        ),
      ],
    );
  }
}
