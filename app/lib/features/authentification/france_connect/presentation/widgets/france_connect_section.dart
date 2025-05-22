import 'package:app/core/infrastructure/url_launcher.dart';
import 'package:app/features/authentification/core/infrastructure/authentification_repository.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class FranceConnectSection extends StatelessWidget {
  const FranceConnectSection({super.key});

  @override
  Widget build(final BuildContext context) => ColoredBox(
    color: const Color(0xFFF6F7FA),
    child: Padding(
      padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(Localisation.franceConnectTitle, style: DsfrTextStyle.headline3(color: DsfrColors.grey50)),
          const SizedBox(height: DsfrSpacings.s1v),
          const Text(Localisation.franceConnectDescription, style: DsfrTextStyle.bodySm(color: DsfrColors.grey75Hover)),
          const SizedBox(height: DsfrSpacings.s2w),
          DsfrFranceConnectButton.franceConnect(
            onTapButton: () => context.read<AuthentificationRepository>().franceConnectStep1(),
            onTapLink: () async {
              await FnvUrlLauncher.launch(Localisation.franceConnectEnSavoirPlusUrl);
            },
            buttonPrefixLabel: Localisation.franceConnectPrefix,
            linkLabel: Localisation.franceConnectEnSavoirPlus,
          ),
        ],
      ),
    ),
  );
}
