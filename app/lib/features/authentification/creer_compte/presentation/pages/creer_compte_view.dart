import 'package:app/core/infrastructure/url_launcher.dart';
import 'package:app/core/presentation/widgets/composants/alert.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/authentification/check_inbox/check_inbox_page.dart';
import 'package:app/features/authentification/creer_compte/presentation/bloc/creer_compte_bloc.dart';
import 'package:app/features/authentification/creer_compte/presentation/bloc/creer_compte_event.dart';
import 'package:app/features/authentification/creer_compte/presentation/bloc/creer_compte_state.dart';
import 'package:app/features/authentification/france_connect/presentation/widgets/france_connect_section.dart';
import 'package:app/features/authentification/se_connecter/presentation/pages/se_connecter_page.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:go_router/go_router.dart';

class CreerCompteView extends StatelessWidget {
  const CreerCompteView({super.key});

  @override
  Widget build(final BuildContext context) => BlocListener<CreerCompteBloc, CreerCompteState>(
    listener: (final context, final state) async {
      await GoRouter.of(context).pushNamed(CheckInboxPage.name, pathParameters: {'email': state.email});
    },
    listenWhen:
        (final previous, final current) => previous.isAccountCreated != current.isAccountCreated && current.isAccountCreated,
    child: Scaffold(
      appBar: AppBar(iconTheme: const IconThemeData(color: DsfrColors.blueFranceSun113)),
      body: ListView(
        padding: const EdgeInsets.all(paddingVerticalPage),
        children: [
          const Text(Localisation.creerMonCompte, style: DsfrTextStyle.headline2()),
          const SizedBox(height: DsfrSpacings.s3w),
          const FranceConnectSection(),
          const SizedBox(height: DsfrSpacings.s1w),
          const _Cgu(),
          const SizedBox(height: DsfrSpacings.s3w),
          const Text(Localisation.avecMonAdresseEmail, style: DsfrTextStyle.headline3()),
          const SizedBox(height: DsfrSpacings.s2w),
          DsfrInput(
            label: Localisation.adresseEmail,
            hintText: Localisation.adresseEmailHint,
            onChanged: (final value) => context.read<CreerCompteBloc>().add(CreerCompteAdresseMailAChangee(value)),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autocorrect: false,
            autofillHints: const [AutofillHints.email],
          ),
          const _MessageErreur(),
          const SizedBox(height: DsfrSpacings.s3w),
          const _BoutonCreerCompte(),
          const SizedBox(height: DsfrSpacings.s3w),
          const DsfrDivider(color: Color(0xFFE8E9F2)),
          const SizedBox(height: DsfrSpacings.s4w),
          DsfrButton(
            label: Localisation.jaiDejaUnCompte,
            variant: DsfrButtonVariant.secondary,
            size: DsfrComponentSize.lg,
            onPressed: () async {
              await GoRouter.of(context).pushReplacementNamed(SeConnecterPage.name);
            },
          ),
          const SafeArea(child: SizedBox.shrink()),
        ],
      ),
    ),
  );
}

class _Cgu extends StatefulWidget {
  const _Cgu();

  @override
  State<_Cgu> createState() => _CguState();
}

class _CguState extends State<_Cgu> {
  final _tapGestureRecognizer = TapGestureRecognizer();

  @override
  void initState() {
    super.initState();
    _tapGestureRecognizer.onTap = () async {
      await FnvUrlLauncher.launch(Localisation.lesCguSite);
    };
  }

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Text.rich(
    TextSpan(
      text: Localisation.lesCguTitrePart1,
      style: const DsfrTextStyle.bodySm(),
      children: [
        TextSpan(
          recognizer: _tapGestureRecognizer,
          children: [
            TextSpan(
              text: Localisation.lesCguTitrePart2,
              style: const DsfrTextStyle.bodySm(
                color: DsfrColors.blueFranceSun113,
              ).copyWith(decoration: TextDecoration.underline, decorationColor: DsfrColors.blueFranceSun113),
            ),
            const WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Icon(DsfrIcons.systemExternalLinkFill, size: 16, color: DsfrColors.blueFranceSun113),
            ),
          ],
        ),
      ],
    ),
  );
}

class _MessageErreur extends StatelessWidget {
  const _MessageErreur();

  @override
  Widget build(final BuildContext context) => context
      .select<CreerCompteBloc, Option<String>>((final bloc) => bloc.state.errorMessage)
      .fold(
        () => const SizedBox.shrink(),
        (final t) => Column(children: [const SizedBox(height: DsfrSpacings.s2w), FnvAlert.error(label: t)]),
      );
}

class _BoutonCreerCompte extends StatelessWidget {
  const _BoutonCreerCompte();

  @override
  Widget build(final BuildContext context) {
    final isAccountValid = context.select<CreerCompteBloc, bool>((final bloc) => bloc.state.isAccountValid);

    return DsfrButton(
      label: Localisation.creerMonCompte,
      variant: DsfrButtonVariant.primary,
      size: DsfrComponentSize.lg,
      onPressed: isAccountValid ? () => context.read<CreerCompteBloc>().add(const CreerCompteCreationDemandee()) : null,
    );
  }
}
