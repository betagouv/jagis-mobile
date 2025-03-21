import 'package:app/core/presentation/widgets/fondamentaux/text_styles.dart';
import 'package:app/features/utilisateur/presentation/bloc/user_bloc.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeAppBarTitle extends StatelessWidget {
  const HomeAppBarTitle({super.key});

  @override
  Widget build(final context) {
    final prenom = context.select<UserBloc, String>((final bloc) => bloc.state.user.pseudonym);
    const font = FnvTextStyles.appBarTitleStyle;

    return Text.rich(
      TextSpan(text: Localisation.bonjour, children: [TextSpan(text: Localisation.pseudonymExclamation(prenom), style: font)]),
      style: font.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
