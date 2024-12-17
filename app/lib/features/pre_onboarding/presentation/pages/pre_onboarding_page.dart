import 'package:app/core/assets/images.dart';
import 'package:app/core/assets/svgs.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/features/authentification/creer_compte/presentation/pages/creer_compte_page.dart';
import 'package:app/features/authentification/se_connecter/presentation/pages/se_connecter_page.dart';
import 'package:app/features/version/presentation/widgets/version_label.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class PreOnboardingPage extends StatelessWidget {
  const PreOnboardingPage({super.key});

  static const name = 'pre-onboarding';
  static const path = name;

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) => const PreOnboardingPage(),
      );

  @override
  Widget build(final context) => FnvScaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: DsfrSpacings.s15w),
                    const Text(
                      Localisation.preOnboardingTitre,
                      style: DsfrTextStyle.displayXs(),
                      textScaler: TextScaler.noScaling,
                    ),
                    const SizedBox(height: DsfrSpacings.s3w),
                    Row(
                      children: [
                        SvgPicture.asset(
                          AssetsSvgs.republiqueFrancaise,
                          height: 69,
                          semanticsLabel:
                              AssetsSvgs.republiqueFrancaiseSemantic,
                        ),
                        const SizedBox(width: DsfrSpacings.s3w),
                        Image.asset(
                          AssetsImages.franceNationVerte,
                          semanticLabel: AssetsImages.franceNationVerteSemantic,
                          height: 46,
                        ),
                        const SizedBox(width: DsfrSpacings.s3w),
                        SvgPicture.asset(
                          AssetsSvgs.ademe,
                          height: 55,
                          semanticsLabel: AssetsSvgs.ademeSemantic,
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DsfrButton(
                      label: Localisation.jeCreeMonCompte,
                      variant: DsfrButtonVariant.primary,
                      size: DsfrButtonSize.lg,
                      onPressed: () async =>
                          GoRouter.of(context).pushNamed(CreerComptePage.name),
                    ),
                    const SizedBox(height: DsfrSpacings.s2w),
                    Center(
                      child: DsfrLink.md(
                        label: Localisation.jaiDejaUnCompte,
                        onTap: () async => GoRouter.of(context)
                            .pushNamed(SeConnecterPage.name),
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
