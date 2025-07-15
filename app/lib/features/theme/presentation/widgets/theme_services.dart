import 'package:app/core/assets/images.dart';
import 'package:app/core/presentation/widgets/composants/card.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/features/action/domain/action.dart';
import 'package:app/features/action/presentation/pages/action_page.dart';
import 'package:app/features/actions/domain/action_type.dart';
import 'package:app/features/services/lvao/presentation/lvao_list/pages/lvao_list_page.dart';
import 'package:app/features/services/pdcn/presentation/pdcn_list/pages/pdcn_list_page.dart';
import 'package:app/features/services/recipes/list/presentation/pages/recipes_page.dart';
import 'package:app/features/services/seasonal_fruits_and_vegetables/presentation/pages/seasonal_fruits_and_vegetables_page.dart';
import 'package:app/features/simulateur_velo/presentation/pages/aide_simulateur_velo_page.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:app/l10n/l10n.dart';
import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:go_router/go_router.dart';

class ThemeServices extends StatelessWidget {
  const ThemeServices({super.key, required this.themeType});

  final ThemeType themeType;

  @override
  Widget build(final BuildContext context) => Align(
    alignment: Alignment.centerLeft,
    child: switch (themeType) {
      ThemeType.alimentation => const _AlimentationServices(),
      ThemeType.transport => const _TransportServices(),
      ThemeType.logement => const _LogementServices(),
      ThemeType.consommation => const _ConsommationServices(),
      ThemeType.decouverte => const SizedBox.shrink(),
    },
  );
}

class _AlimentationServices extends StatelessWidget {
  const _AlimentationServices();

  @override
  Widget build(final BuildContext context) {
    final now = context.read<Clock>().now();

    return _GridView(
      children: [
        _Service(
          title: Localisation.lesRecettes(now),
          image: AssetImages.recettesServiceIllustration,
          onTap: () async {
            await GoRouter.of(context).pushNamed(RecipesPage.name);
          },
        ),
        _Service(
          title: Localisation.lesCommercesLocaux,
          image: AssetImages.commercesServiceIllustration,
          onTap: () async {
            await GoRouter.of(context).pushNamed(PdcnListPage.name);
          },
        ),
        _Service(
          title: Localisation.lesFruitsEtLegumes(now),
          image: AssetImages.calendrierServiceIllustration,
          onTap: () async {
            await GoRouter.of(context).pushNamed(SeasonalFruitsAndVegetablesPage.name);
          },
        ),
      ],
    );
  }
}

class _TransportServices extends StatelessWidget {
  const _TransportServices();

  @override
  Widget build(final BuildContext context) => _GridView(
    children: [
      _Service(
        title: Localisation.estimerMesAidesVelo,
        image: AssetImages.veloServiceIllustration,
        onTap: () async {
          await GoRouter.of(context).pushNamed(AideSimulateurVeloPage.name);
        },
      ),
      _Service(
        title: Localisation.doisJeChangerDeVoiture,
        image: AssetImages.voitureServiceIllustration,
        onTap: () async {
          await GoRouter.of(context).pushNamed(
            ActionPage.name,
            pathParameters: ActionPage.pathParameters(type: ActionType.simulator, id: ActionSimulatorId.carSimulator.apiString),
          );
        },
      ),
    ],
  );
}

class _LogementServices extends StatelessWidget {
  const _LogementServices();

  @override
  Widget build(final BuildContext context) => _GridView(
    children: [
      _Service(
        title: Localisation.lesRisquesNaturelesAMonAdresse,
        image: AssetImages.maifServiceIllustration,
        onTap: () async {
          await GoRouter.of(context).pushNamed(
            ActionPage.name,
            pathParameters: ActionPage.pathParameters(type: ActionType.simulator, id: ActionSimulatorId.maif.apiString),
          );
        },
      ),
      _Service(
        title: Localisation.aidesALaRenovation,
        image: AssetImages.mesAidesRenoServiceIllustration,
        onTap: () async {
          await GoRouter.of(context).pushNamed(
            ActionPage.name,
            pathParameters: ActionPage.pathParameters(type: ActionType.simulator, id: ActionSimulatorId.mesAidesReno.apiString),
          );
        },
      ),
    ],
  );
}

class _ConsommationServices extends StatelessWidget {
  const _ConsommationServices();

  @override
  Widget build(final BuildContext context) => _GridView(
    children: [
      _Service(
        title: Localisation.queFaireDeMesObjets,
        subTitle: Localisation.queFaireDeMesObjetsDetail,
        image: AssetImages.lvaoServiceIllustration,
        onTap: () async {
          await GoRouter.of(context).pushNamed(LvaoListPage.name);
        },
      ),
    ],
  );
}

class _GridView extends StatelessWidget {
  const _GridView({required this.children});

  final List<Widget> children;

  @override
  Widget build(final BuildContext context) {
    final rowCount = (children.length / 2).ceil();

    return Column(
      spacing: DsfrSpacings.s2w,
      children: List.generate(rowCount, (final rowIndex) {
        final startIndex = rowIndex * 2;
        final endIndex = (startIndex + 2).clamp(0, children.length);
        final rowChildren = children.sublist(startIndex, endIndex);

        return IntrinsicHeight(
          child: Row(
            spacing: DsfrSpacings.s2w,
            children: [
              for (var i = 0; i < rowChildren.length; i += 1) Expanded(child: rowChildren[i]),
              if (rowChildren.length == 1) const Expanded(child: SizedBox()),
            ],
          ),
        );
      }),
    );
  }
}

class _Service extends StatelessWidget {
  const _Service({required this.title, this.subTitle, required this.image, required this.onTap});

  final String title;
  final String? subTitle;
  final String image;
  final GestureTapCallback onTap;

  @override
  Widget build(final BuildContext context) => FnvCard(
    onTap: onTap,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: DsfrSpacings.s1v,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: DsfrSpacings.s3v, top: DsfrSpacings.s2w, right: DsfrSpacings.s3v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: DsfrSpacings.s1v,
            children: [
              Text(title, style: DsfrTextStyle.bodyLgBold(color: DsfrColorDecisions.textTitleGrey(context))),
              if (subTitle != null)
                Text(subTitle!, style: DsfrTextStyle.bodyXs(color: DsfrColorDecisions.textTitleGrey(context))),
            ],
          ),
        ),
        const Spacer(),
        Align(alignment: Alignment.bottomRight, child: FnvImage.asset(image)),
      ],
    ),
  );
}
