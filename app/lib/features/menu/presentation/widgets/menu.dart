import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/features/actions/presentation/pages/actions_page.dart';
import 'package:app/features/aids/list/presentation/pages/aids_page.dart';
import 'package:app/features/authentification/logout/presentation/widgets/logout_widget.dart';
import 'package:app/features/environmental_performance/summary/presentation/page/environmental_performance_summary_page.dart';
import 'package:app/features/home/presentation/pages/home_page.dart';
import 'package:app/features/library/presentation/pages/library_page.dart';
import 'package:app/features/profil/profil/presentation/pages/profil_page.dart';
import 'package:app/features/version/presentation/widgets/version_label.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:go_router/go_router.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(final BuildContext context) => Drawer(
    backgroundColor: Colors.white,
    shadowColor: DsfrColors.blueFranceSun113,
    surfaceTintColor: Colors.white,
    shape: const RoundedRectangleBorder(),
    child: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: DsfrSpacings.s3w,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: DsfrSpacings.s1w, right: DsfrSpacings.s3w),
            child: Row(
              spacing: DsfrSpacings.s1w,
              children: [
                IconButton(
                  iconSize: 24,
                  padding: const EdgeInsets.all(DsfrSpacings.s1w),
                  onPressed: () => GoRouter.of(context).pop(),
                  style: const ButtonStyle(shape: WidgetStatePropertyAll(RoundedRectangleBorder())),
                  icon: const Icon(
                    DsfrIcons.systemCloseLine,
                    color: DsfrColors.blueFranceSun113,
                    semanticLabel: Localisation.fermer,
                  ),
                ),
                const Expanded(
                  child: Text(Localisation.menu, style: DsfrTextStyle.bodyMdBold(color: DsfrColors.grey50)),
                ),
              ],
            ),
          ),
          const Expanded(child: SafeArea(top: false, child: _MenuItems())),
        ],
      ),
    ),
  );
}

class _MenuItems extends StatelessWidget {
  const _MenuItems();

  @override
  Widget build(final BuildContext context) {
    final groupValue = GoRouterState.of(context).name ?? HomePage.name;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...{
          HomePage.name: Localisation.home,
          AidsPage.name: Localisation.aides,
          ActionsPage.name: Localisation.actions,
          LibraryPage.name: Localisation.bibliotheque,
          EnvironmentalPerformanceSummaryPage.name: Localisation.empreinteEcologique,
        }.entries.map((final e) => _MenuItem(label: e.value, value: e.key, groupValue: groupValue)),
        const Spacer(),
        _MenuItem(label: Localisation.monProfil, value: ProfilPage.name, groupValue: groupValue),
        const LogoutWidget(),
        const SizedBox(height: DsfrSpacings.s2w),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
          child: VersionLabel(),
        ),
        const SizedBox(height: DsfrSpacings.s3w),
      ],
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({required this.label, required this.value, required this.groupValue});

  final String label;
  final String value;
  final String groupValue;

  @override
  Widget build(final BuildContext context) {
    final isCurrentPage = groupValue == value;

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 48),
      child: Material(
        color: FnvColors.transparent,
        child: InkWell(
          onTap: isCurrentPage
              ? null
              : () async {
                  await GoRouter.of(context).pushReplacementNamed(value);
                },
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              if (isCurrentPage)
                const DecoratedBox(
                  decoration: BoxDecoration(color: DsfrColors.blueFranceSun113),
                  child: SizedBox(width: 3, height: 24),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
                child: Text(
                  label,
                  style: isCurrentPage
                      ? const DsfrTextStyle.bodyLgBold(color: DsfrColors.blueFranceSun113)
                      : const DsfrTextStyle.bodyLg(color: DsfrColors.grey50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
