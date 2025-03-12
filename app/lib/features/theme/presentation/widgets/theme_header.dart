import 'package:app/core/assets/images.dart';
import 'package:app/core/infrastructure/svg.dart';
import 'package:app/features/theme/core/domain/theme_summary.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/features/theme/presentation/widgets/theme_service_info.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

class ThemeHeader extends StatelessWidget {
  const ThemeHeader({super.key, required this.themeType, required this.themeSummary});

  final ThemeType themeType;
  final ThemeSummary themeSummary;

  @override
  Widget build(final context) => ColoredBox(
    color: const Color(0xFFF9F6F2),
    child: Stack(
      fit: StackFit.passthrough,
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: 0,
          right: -100,
          bottom: 0,
          child: FnvSvg.asset(switch (themeType) {
            ThemeType.alimentation => AssetImages.alimentation,
            ThemeType.transport => AssetImages.transport,
            ThemeType.logement => AssetImages.logement,
            ThemeType.consommation => AssetImages.consommation,
            ThemeType.decouverte => throw UnimplementedError(),
          }),
        ),
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
              Row(
                mainAxisSize: MainAxisSize.min,
                spacing: DsfrSpacings.s1w,
                children: [
                  Flexible(child: Text(themeType.displayNameWithoutEmoji, style: const DsfrTextStyle.headline1())),
                  DsfrTag.md(
                    label: TextSpan(text: Localisation.a(themeSummary.commune)),
                    backgroundColor: DsfrColors.blueFrance925,
                    foregroundColor: DsfrColors.blueFranceSun113,
                    icon: DsfrIcons.mapMapPin2Fill,
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
