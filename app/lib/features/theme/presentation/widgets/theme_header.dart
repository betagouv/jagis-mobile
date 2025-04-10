import 'package:app/core/assets/images.dart';
import 'package:app/core/infrastructure/svg.dart';
import 'package:app/features/profil/logement/presentation/pages/mon_logement_page.dart';
import 'package:app/features/theme/core/domain/theme_summary.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/features/theme/presentation/widgets/theme_service_info.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:go_router/go_router.dart';

class ThemeHeader extends StatelessWidget {
  const ThemeHeader({super.key, required this.themeType, required this.themeSummary});

  final ThemeType themeType;
  final ThemeSummary themeSummary;

  @override
  Widget build(final BuildContext context) => ColoredBox(
    color: const Color(0xFFF9F6F2),
    child: Stack(
      fit: StackFit.passthrough,
      clipBehavior: Clip.none,
      children: [
        switch (themeType) {
          ThemeType.alimentation => const _BackgroundImage(assetName: AssetImages.alimentation),
          ThemeType.transport => const _BackgroundImage(assetName: AssetImages.transport),
          ThemeType.logement => const _BackgroundImage(assetName: AssetImages.logement),
          ThemeType.consommation => const _BackgroundImage(assetName: AssetImages.consommation),
          ThemeType.decouverte => const SizedBox.shrink(),
        },
        Padding(
          padding: const EdgeInsets.only(
            left: DsfrSpacings.s2w,
            top: DsfrSpacings.s4w,
            right: DsfrSpacings.s2w,
            bottom: DsfrSpacings.s5w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: DsfrSpacings.s3w,
            children: [
              Wrap(
                spacing: DsfrSpacings.s1w,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(themeType.displayNameWithoutEmoji, style: const DsfrTextStyle.headline1(color: DsfrColors.grey50)),
                  DsfrTag(
                    label: Localisation.a(themeSummary.commune),
                    size: DsfrComponentSize.md,
                    backgroundColor: DsfrColors.blueFrance925,
                    textColor: DsfrColors.blueFranceSun113,
                    icon: DsfrIcons.mapMapPin2Fill,
                    onTap: () async {
                      await GoRouter.of(context).pushNamed(MonLogementPage.name);
                    },
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: DsfrSpacings.s3v,
                children: themeSummary.links.map((final e) => ThemeServiceInfo(link: e)).toList(),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _BackgroundImage extends StatelessWidget {
  const _BackgroundImage({required this.assetName});

  final String assetName;

  @override
  Widget build(final BuildContext context) => Positioned(left: 100, top: 0, bottom: 0, child: FnvSvg.asset(assetName));
}
