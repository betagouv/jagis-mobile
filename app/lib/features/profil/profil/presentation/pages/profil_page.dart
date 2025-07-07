import 'package:app/core/infrastructure/url_launcher.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/know_your_customer/list/presentation/pages/know_your_customers_page.dart';
import 'package:app/features/menu/presentation/pages/root_page.dart';
import 'package:app/features/options_avancees/presentation/pages/options_avancees_page.dart';
import 'package:app/features/profil/informations/presentation/pages/mes_informations_page.dart';
import 'package:app/features/profil/logement/presentation/pages/mon_logement_page.dart';
import 'package:app/features/profil/profil/presentation/widgets/fnv_title.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  static const name = 'profil';
  static const path = name;

  static GoRoute get route => GoRoute(path: path, name: name, builder: (final context, final state) => const ProfilPage());

  @override
  Widget build(final BuildContext context) => RootPage(
    body: ListView(
      padding: const EdgeInsets.all(paddingVerticalPage),
      children: [
        const FnvTitle(title: Localisation.monProfil),
        const SizedBox(height: DsfrSpacings.s3w),
        DecoratedBox(
          decoration: const BoxDecoration(color: FnvColors.carteFond, boxShadow: FnvShadows.card),
          child: Column(
            children: [
              _MenuElement(
                icon: DsfrIcons.userAccountCircleLine,
                label: Localisation.mesInformations,
                onTap: () async {
                  await GoRouter.of(context).pushNamed(MesInformationsPage.name);
                },
              ),
              const DsfrDivider(),
              _MenuElement(
                icon: DsfrIcons.buildingsHome4Line,
                label: Localisation.monLogement,
                onTap: () async {
                  await GoRouter.of(context).pushNamed(MonLogementPage.name);
                },
              ),
              const DsfrDivider(),
              _MenuElement(
                icon: DsfrIcons.userUserSettingLine,
                label: Localisation.mieuxVousConnaitre,
                onTap: () async {
                  await GoRouter.of(context).pushNamed(KnowYourCustomersPage.name);
                },
              ),
              const DsfrDivider(),
              _MenuElement(
                icon: DsfrIcons.documentArticleLine,
                label: Localisation.politiqueDeConfidentialite,
                onTap: () async {
                  await FnvUrlLauncher.launch(Localisation.politiqueDeConfidentialiteSite, mode: LaunchMode.inAppWebView);
                },
                iconRight: DsfrIcons.systemExternalLinkLine,
              ),
              const DsfrDivider(),
              _MenuElement(
                icon: DsfrIcons.documentArticleLine,
                label: Localisation.lesCguMenu,
                onTap: () async {
                  await FnvUrlLauncher.launch(Localisation.lesCguSite, mode: LaunchMode.inAppWebView);
                },
                iconRight: DsfrIcons.systemExternalLinkLine,
              ),
              const DsfrDivider(),
              _MenuElement(
                icon: DsfrIcons.documentArticleLine,
                label: Localisation.mentionsLegales,
                onTap: () async {
                  await FnvUrlLauncher.launch(Localisation.mentionsLegalesSite, mode: LaunchMode.inAppWebView);
                },
                iconRight: DsfrIcons.systemExternalLinkLine,
              ),
              const DsfrDivider(),
              _MenuElement(
                icon: DsfrIcons.documentArticleLine,
                label: Localisation.declarationAccessibilite,
                onTap: () async {
                  await FnvUrlLauncher.launch(Localisation.declarationAccessibiliteSite, mode: LaunchMode.inAppWebView);
                },
                iconRight: DsfrIcons.systemExternalLinkLine,
              ),
              const DsfrDivider(),
              _MenuElement(
                icon: DsfrIcons.businessLineChartLine,
                label: Localisation.statistiques,
                onTap: () async {
                  await FnvUrlLauncher.launch(Localisation.statistiquesSite, mode: LaunchMode.inAppWebView);
                },
                iconRight: DsfrIcons.systemExternalLinkLine,
              ),
              const DsfrDivider(),
              _MenuElement(
                icon: DsfrIcons.systemSettings5Line,
                label: Localisation.optionsAvancees,
                onTap: () async {
                  await GoRouter.of(context).pushNamed(OptionsAvanceesPage.name);
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _MenuElement extends StatelessWidget {
  const _MenuElement({required this.icon, required this.label, this.onTap, this.iconRight = DsfrIcons.systemArrowRightSLine});

  final IconData icon;
  final String label;
  final GestureTapCallback? onTap;
  final IconData iconRight;

  @override
  Widget build(final BuildContext context) {
    const iconColor = DsfrColors.blueFranceSun113;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(DsfrSpacings.s2w),
        child: Row(
          spacing: DsfrSpacings.s1w,
          children: [
            Icon(icon, color: iconColor),
            Expanded(
              child: Text(label, style: const DsfrTextStyle.bodyMdMedium(color: DsfrColors.grey50)),
            ),
            Icon(iconRight, color: iconColor),
          ],
        ),
      ),
    );
  }
}
