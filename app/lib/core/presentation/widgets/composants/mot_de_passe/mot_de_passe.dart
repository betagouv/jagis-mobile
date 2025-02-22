import 'package:app/core/presentation/widgets/composants/mot_de_passe/cubit/mot_de_passe_cubit.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FnvMotDePasse extends StatelessWidget {
  const FnvMotDePasse({super.key, required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(final context) =>
      BlocProvider(create: (final context) => MotDePasseCubit(), child: _MotDePasse(onChanged: onChanged));
}

class _MotDePasse extends StatelessWidget {
  const _MotDePasse({required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(final context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      DsfrInput(
        label: Localisation.motDePasse,
        onChanged: (final value) {
          final cubit = context.read<MotDePasseCubit>()..changerMotDePasseAChange(value);
          if (cubit.state.estValide) {
            onChanged(value);
          }
        },
        isPasswordMode: true,
        keyboardType: TextInputType.visiblePassword,
        scrollPadding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom + 190),
        autofillHints: const [AutofillHints.password],
      ),
      const Text(Localisation.monMotDePasseDoitContenir, style: DsfrTextStyle.bodyXs(color: DsfrColors.grey425)),
      const _DouzeCarateresMinimum(),
      const _AuMoinsUnMajusculeEtUneMinuscule(),
      const _UnCaractereSpecialMinimum(),
      const _UnChiffreMinimum(),
    ],
  );
}

class _DouzeCarateresMinimum extends StatelessWidget {
  const _DouzeCarateresMinimum();

  @override
  Widget build(final context) => _DoitContenir(
    valid: context.select<MotDePasseCubit, bool>((final bloc) => bloc.state.douzeCaracteresMinimum),
    text: Localisation.motDePasse12CaractresMinimum,
  );
}

class _AuMoinsUnMajusculeEtUneMinuscule extends StatelessWidget {
  const _AuMoinsUnMajusculeEtUneMinuscule();

  @override
  Widget build(final context) => _DoitContenir(
    valid: context.select<MotDePasseCubit, bool>((final bloc) => bloc.state.auMoinsUneMajusculeEtUneMinuscule),
    text: Localisation.motDePasse1MajusculeEt1Minuscule,
  );
}

class _UnCaractereSpecialMinimum extends StatelessWidget {
  const _UnCaractereSpecialMinimum();

  @override
  Widget build(final context) => _DoitContenir(
    valid: context.select<MotDePasseCubit, bool>((final bloc) => bloc.state.unCaractereSpecialMinimum),
    text: Localisation.motDePasse1CaractreSpecialMinimum,
  );
}

class _UnChiffreMinimum extends StatelessWidget {
  const _UnChiffreMinimum();

  @override
  Widget build(final context) => _DoitContenir(
    valid: context.select<MotDePasseCubit, bool>((final bloc) => bloc.state.unChiffreMinimum),
    text: Localisation.motDePasse1ChiffreMinimum,
  );
}

class _DoitContenir extends StatelessWidget {
  const _DoitContenir({required this.valid, required this.text});

  final bool valid;
  final String text;

  @override
  Widget build(final context) => DsfrFormMessage(type: valid ? DsfrFormMessageType.valid : DsfrFormMessageType.info, text: text);
}
