import 'package:app/features/utilisateur/presentation/bloc/user_bloc.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class HomeAppBarTitle extends StatelessWidget {
  const HomeAppBarTitle({super.key});

  @override
  Widget build(final BuildContext context) {
    final value = context.select<UserBloc, String?>((final bloc) => bloc.state.user?.pseudonym);

    const font = DsfrTextStyle.bodyMd(color: DsfrColors.grey50);
    if (value == null || value.isEmpty) {
      return Text(Localisation.bonjour, style: font.copyWith(fontWeight: FontWeight.bold));
    }

    return Text.rich(
      TextSpan(
        text: Localisation.bonjour,
        children: [TextSpan(text: Localisation.pseudonymExclamation(value), style: font)],
      ),
      style: font.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
