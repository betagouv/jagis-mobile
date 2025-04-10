import 'package:app/core/presentation/widgets/composants/alert.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/authentification/saisie_code/presentation/bloc/saisie_code_bloc.dart';
import 'package:app/features/authentification/saisie_code/presentation/bloc/saisie_code_event.dart';
import 'package:app/features/authentification/saisie_code/presentation/widgets/saisie_code_input.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';

class SaisieCodePage extends StatelessWidget {
  const SaisieCodePage({super.key, required this.email, required this.code});

  static const name = 'validation-lien-magique';
  static const path = '/authentification/$name';

  final String email;
  final String? code;

  static GoRoute get route => GoRoute(
    path: path,
    name: name,
    builder: (final context, final state) {
      final queryParameters = state.uri.queryParameters;
      final email = queryParameters['email']!;
      final code = queryParameters['code'];

      return SaisieCodePage(email: email, code: code);
    },
    redirect: (final context, final state) {
      final queryParameters = state.uri.queryParameters;

      return queryParameters['email'] == null ? '/' : null;
    },
  );

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (final context) =>
        SaisieCodeBloc(authentificationRepository: context.read(), email: email)..add(SaisieCodeCodeSaisie(code)),
    child: FnvScaffold(
      appBar: AppBar(
        backgroundColor: FnvColors.background,
        iconTheme: const IconThemeData(color: DsfrColors.blueFranceSun113),
      ),
      body: ListView(
        padding: const EdgeInsets.all(paddingVerticalPage),
        children: [
          const Text(Localisation.entrezLeCodeRecuParMail, style: DsfrTextStyle.headline2(color: DsfrColors.grey50)),
          const SizedBox(height: DsfrSpacings.s1w),
          Text(Localisation.entrezLeCodeRecuParMailDetails(email), style: const DsfrTextStyle.bodyLg(color: DsfrColors.grey50)),
          const SizedBox(height: DsfrSpacings.s3w),
          SaisieCodeInput(initialValue: code ?? ''),
          const _MessageErreur(),
        ],
      ),
    ),
  );
}

class _MessageErreur extends StatelessWidget {
  const _MessageErreur();

  @override
  Widget build(final BuildContext context) => context
      .select<SaisieCodeBloc, Option<String>>((final bloc) => bloc.state.erreur)
      .fold(
        () => const SizedBox.shrink(),
        (final t) => Column(
          children: [
            const SizedBox(height: DsfrSpacings.s3w),
            FnvAlert.error(label: t),
          ],
        ),
      );
}
