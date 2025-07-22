import 'package:app/core/assets/images.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/features/actions_recommanded/presentation/widgets/actions_recommanded_section.dart';
import 'package:app/features/profil/home/presentation/pages/my_home_page.dart';
import 'package:app/features/theme/core/domain/theme_info.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:go_router/go_router.dart';

class ThemeHeader extends StatelessWidget {
  const ThemeHeader({super.key, required this.themeInfo});

  final ThemeInfo themeInfo;

  @override
  Widget build(final BuildContext context) => ColoredBox(
    color: const Color(0xFFF3EDE5),
    child: Stack(
      fit: StackFit.passthrough,
      clipBehavior: Clip.none,
      children: [
        _BackgroundImage(themeType: themeInfo.themeType),
        Padding(
          padding: const EdgeInsets.only(
            left: DsfrSpacings.s2w,
            top: DsfrSpacings.s4w,
            right: DsfrSpacings.s2w,
            bottom: DsfrSpacings.s5w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: DsfrSpacings.s4w,
            children: [
              Wrap(
                spacing: DsfrSpacings.s1w,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    themeInfo.themeType.displayNameWithoutEmoji,
                    style: const DsfrTextStyle.headline1(color: DsfrColors.grey50),
                  ),
                  DsfrTag(
                    label: Localisation.a(themeInfo.communeName),
                    size: DsfrComponentSize.md,
                    backgroundColor: DsfrColors.blueFrance925,
                    textColor: DsfrColors.blueFranceSun113,
                    icon: DsfrIcons.mapMapPin2Fill,
                    onTap: () async {
                      await GoRouter.of(context).pushNamed(MyHomePage.name);
                    },
                  ),
                ],
              ),
              ActionsRecommandedSection(theme: themeInfo),
            ],
          ),
        ),
      ],
    ),
  );
}

class _BackgroundImage extends StatelessWidget {
  const _BackgroundImage({required this.themeType});

  final ThemeType themeType;

  @override
  Widget build(final BuildContext context) {
    final assetName = switch (themeType) {
      ThemeType.alimentation => AssetImages.alimentation,
      ThemeType.transport => AssetImages.transport,
      ThemeType.logement => AssetImages.logement,
      ThemeType.consommation => AssetImages.consommation,
      ThemeType.decouverte => throw UnimplementedError(),
    };

    return Align(alignment: Alignment.topRight, child: FnvImage.asset(assetName));
  }
}
