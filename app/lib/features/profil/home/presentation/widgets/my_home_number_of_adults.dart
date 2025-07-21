import 'package:app/core/helpers/text_scaler.dart';
import 'package:app/features/profil/home/presentation/bloc/my_home_bloc.dart';
import 'package:app/features/profil/home/presentation/bloc/my_home_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class MyHomeNumberOfAdults extends StatelessWidget {
  const MyHomeNumberOfAdults({super.key, required this.numberOfAdults});

  final int? numberOfAdults;

  @override
  Widget build(final BuildContext context) {
    const adultes = Localisation.adultes;

    return Row(
      children: [
        SizedBox(
          width: adjustTextSize(context, 97),
          child: DsfrInputHeadless(
            key: const ValueKey(adultes),
            initialValue: numberOfAdults?.toString(),
            onChanged: (final value) {
              final newValue = int.tryParse(value);
              if (newValue == null) {
                return;
              }
              context.read<MyHomeBloc>().add(MyHomeDataUpdated(numberOfAdults: newValue));
            },
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
        ),
        const SizedBox(width: DsfrSpacings.s1v),
        const Expanded(
          child: Text(adultes, style: DsfrTextStyle.bodySm(color: DsfrColors.grey50)),
        ),
      ],
    );
  }
}
