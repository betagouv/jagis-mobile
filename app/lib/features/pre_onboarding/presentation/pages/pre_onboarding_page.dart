import 'package:app/core/assets/images.dart';
import 'package:app/core/infrastructure/svg.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/features/authentification/creer_compte/presentation/pages/creer_compte_page.dart';
import 'package:app/features/authentification/se_connecter/presentation/pages/se_connecter_page.dart';
import 'package:app/features/version/presentation/widgets/version_label.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:go_router/go_router.dart';

class PreOnboardingPage extends StatelessWidget {
  const PreOnboardingPage({super.key});

  static const name = 'pre-onboarding';
  static const path = name;

  static GoRoute get route => GoRoute(path: path, name: name, builder: (final context, final state) => const PreOnboardingPage());

  @override
  Widget build(final BuildContext context) => FnvScaffold(
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Column(
              children: [
                const SizedBox(height: DsfrSpacings.s9w),
                const Text(
                  Localisation.preOnboardingTitre,
                  style: DsfrTextStyle.displayXs(color: DsfrColors.grey50),
                  textScaler: TextScaler.noScaling,
                ),
                const SizedBox(height: DsfrSpacings.s3w),
                Row(
                  children: [
                    FnvSvg.asset(
                      AssetImages.republiqueFrancaise,
                      height: 69,
                      semanticsLabel: AssetImages.republiqueFrancaiseSemantic,
                    ),
                    Image.asset(AssetImages.franceNationVerte, semanticLabel: AssetImages.franceNationVerteSemantic, height: 46),
                    FnvSvg.asset(AssetImages.ademe, height: 55, semanticsLabel: AssetImages.ademeSemantic),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DsfrButton(
                  label: Localisation.jeCreeMonCompte,
                  variant: DsfrButtonVariant.primary,
                  size: DsfrComponentSize.lg,
                  onPressed: () async {
                    await GoRouter.of(context).pushNamed(CreerComptePage.name);
                  },
                ),
                const SizedBox(height: DsfrSpacings.s2w),
                Center(
                  child: DsfrLink(
                    label: Localisation.jaiDejaUnCompte,
                    onTap: () async {
                      await GoRouter.of(context).pushNamed(SeConnecterPage.name);
                    },
                  ),
                ),
                const SizedBox(height: DsfrSpacings.s3w),
                const Center(child: VersionLabel()),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
