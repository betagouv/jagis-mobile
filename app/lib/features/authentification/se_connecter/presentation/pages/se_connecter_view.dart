import 'package:app/core/infrastructure/markdown.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/authentification/check_inbox/check_inbox_page.dart';
import 'package:app/features/authentification/creer_compte/presentation/pages/creer_compte_page.dart';
import 'package:app/features/authentification/france_connect/presentation/widgets/france_connect_section.dart';
import 'package:app/features/authentification/se_connecter/presentation/bloc/se_connecter_bloc.dart';
import 'package:app/features/authentification/se_connecter/presentation/bloc/se_connecter_event.dart';
import 'package:app/features/authentification/se_connecter/presentation/bloc/se_connecter_state.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';

class SeConnecterView extends StatelessWidget {
  const SeConnecterView({super.key});

  @override
  Widget build(final BuildContext context) => BlocListener<SeConnecterBloc, SeConnecterState>(
    listener: (final context, final state) async {
      await GoRouter.of(context).pushNamed(CheckInboxPage.name, pathParameters: {'email': state.email});
    },
    listenWhen: (final previous, final current) => previous.isConnected != current.isConnected && current.isConnected,
    child: Scaffold(
      appBar: AppBar(iconTheme: const IconThemeData(color: DsfrColors.blueFranceSun113)),
      body: ListView(
        padding: const EdgeInsets.all(paddingVerticalPage),
        children: [
          const FnvMarkdown(
            data: Localisation.pageConnexionTitre,
            p: DsfrTextStyle.headline2(color: DsfrColors.grey50),
          ),
          const SizedBox(height: DsfrSpacings.s3w),
          const FranceConnectSection(),
          const SizedBox(height: DsfrSpacings.s3w),
          const Text(Localisation.avecMonAdresseEmail, style: DsfrTextStyle.headline3(color: DsfrColors.grey50)),
          const SizedBox(height: DsfrSpacings.s2w),
          DsfrInput(
            label: Localisation.adresseEmail,
            hintText: Localisation.adresseEmailHint,
            onChanged: (final value) => context.read<SeConnecterBloc>().add(SeConnecterAdresseMailAChange(value)),
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.email],
          ),
          const _MessageErreur(),
          const SizedBox(height: DsfrSpacings.s3w),
          BlocSelector<SeConnecterBloc, SeConnecterState, bool>(
            selector: (final state) => state.isValid,
            builder: (final context, final state) => DsfrButton(
              label: Localisation.meConnecter,
              variant: DsfrButtonVariant.primary,
              size: DsfrComponentSize.lg,
              onPressed: state ? () => context.read<SeConnecterBloc>().add(const SeConnecterConnexionDemandee()) : null,
            ),
          ),
          const SizedBox(height: DsfrSpacings.s3w),
          const DsfrDivider(color: Color(0xFFE8E9F2)),
          const SizedBox(height: DsfrSpacings.s4w),
          DsfrButton(
            label: Localisation.creerUnCompte,
            variant: DsfrButtonVariant.secondary,
            size: DsfrComponentSize.lg,
            onPressed: () async {
              await GoRouter.of(context).pushReplacementNamed(CreerComptePage.name);
            },
          ),
          const SafeArea(child: SizedBox.shrink()),
        ],
      ),
    ),
  );
}

class _MessageErreur extends StatelessWidget {
  const _MessageErreur();

  @override
  Widget build(final BuildContext context) => context
      .select<SeConnecterBloc, Option<String>>((final bloc) => bloc.state.errorMessage)
      .fold(
        () => const SizedBox.shrink(),
        (final t) => Column(
          children: [
            const SizedBox(height: DsfrSpacings.s2w),
            FnvAlert.error(label: t),
          ],
        ),
      );
}
