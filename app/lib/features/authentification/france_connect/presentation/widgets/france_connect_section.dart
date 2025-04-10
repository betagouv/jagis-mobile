import 'package:app/core/infrastructure/url_launcher.dart';
import 'package:app/features/authentification/core/infrastructure/authentification_repository.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class FranceConnectSection extends StatelessWidget {
  const FranceConnectSection({super.key});

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(Localisation.franceConnectTitle, style: DsfrTextStyle.headline2(color: DsfrColors.grey50)),
      const SizedBox(height: DsfrSpacings.s1w),
      const Text(Localisation.franceConnectDescription, style: DsfrTextStyle.bodyLg(color: DsfrColors.grey50)),
      const SizedBox(height: DsfrSpacings.s3w),
      DsfrFranceConnectButton.franceConnect(
        onTapButton: () => context.read<AuthentificationRepository>().franceConnectStep1(),
        onTapLink: () async {
          await FnvUrlLauncher.launch(Localisation.franceConnectEnSavoirPlusUrl);
        },
        buttonPrefixLabel: 'S’identifier avec',
        linkLabel: 'Qu’est-ce que France Connect ?',
      ),
    ],
  );
}
