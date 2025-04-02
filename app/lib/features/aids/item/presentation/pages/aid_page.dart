import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/bottom_bar.dart';
import 'package:app/core/presentation/widgets/composants/failure_widget.dart';
import 'package:app/core/presentation/widgets/composants/html_widget.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/aids/core/domain/aid.dart';
import 'package:app/features/aids/core/presentation/widgets/partner_widget.dart';
import 'package:app/features/aids/core/presentation/widgets/simulator_tag.dart';
import 'package:app/features/aids/item/presentation/bloc/aid_bloc.dart';
import 'package:app/features/aids/item/presentation/bloc/aid_event.dart';
import 'package:app/features/aids/item/presentation/bloc/aid_state.dart';
import 'package:app/features/simulateur_velo/presentation/pages/aide_simulateur_velo_page.dart';
import 'package:app/features/theme/presentation/widgets/theme_type_tag.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AidPage extends StatelessWidget {
  const AidPage({super.key, required this.id});

  static const name = 'aide';
  static const path = 'aide/:titre/:id';

  static Map<String, String> pathParameters({required final String title, required final String id}) => {
    'titre': title,
    'id': id,
  };

  final String id;

  static GoRoute get route =>
      GoRoute(path: path, name: name, builder: (final context, final state) => AidPage(id: state.pathParameters['id']!));

  @override
  Widget build(final context) => BlocProvider(
    create: (final context) => AidBloc(repository: context.read())..add(AidSelectedById(id)),
    child: const _View(),
  );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final context) => FnvScaffold(
    appBar: FnvAppBar(),
    body: switch (context.watch<AidBloc>().state) {
      AidStateLoading() => const Center(child: CircularProgressIndicator()),
      AidStateSuccess(:final aid) => _AidPageContent(aid),
      AidStateErrorLoading() => const Center(
        child: Padding(padding: EdgeInsets.all(DsfrSpacings.s4w), child: FnvFailureWidget()),
      ),
    },
    bottomNavigationBar: switch (context.watch<AidBloc>().state) {
      AidStateSuccess(:final aid) =>
        aid.hasSimulator
            ? FnvBottomBar(
              child: DsfrButton(
                label: Localisation.accederAuSimulateur,
                variant: DsfrButtonVariant.primary,
                size: DsfrButtonSize.lg,
                onPressed: () async {
                  if (aid.hasBikeSimulator) {
                    await GoRouter.of(context).pushNamed(AideSimulateurVeloPage.name);
                  }
                },
              ),
            )
            : null,
      _ => null,
    },
  );
}

class _AidPageContent extends StatelessWidget {
  const _AidPageContent(this.aid);

  final Aid aid;

  @override
  Widget build(final context) => ListView(
    padding: const EdgeInsets.all(paddingVerticalPage),
    children: [
      Align(alignment: Alignment.centerLeft, child: ThemeTypeTag(themeType: aid.themeType)),
      const SizedBox(height: DsfrSpacings.s2w),
      Text(aid.title, style: const DsfrTextStyle.headline2()),
      if (aid.hasSimulator || aid.maxAmount != null) ...[
        const SizedBox(height: DsfrSpacings.s1w),
        Wrap(
          spacing: DsfrSpacings.s1w,
          children: [
            if (aid.maxAmount != null)
              DsfrTag.sm(
                label: TextSpan(text: Localisation.jusqua + Localisation.euro(aid.maxAmount!)),
                backgroundColor: DsfrColors.purpleGlycine925Hover,
                foregroundColor: const Color(0xFF432636),
              ),
            if (aid.hasSimulator) const SimulatorTag(),
          ],
        ),
      ],
      if (aid.partner != null) ...[
        const SizedBox(height: DsfrSpacings.s3w),
        DecoratedBox(
          decoration: const BoxDecoration(
            color: Color(0xffeef2ff),
            border: Border.fromBorderSide(BorderSide(color: Color(0xffb1b1ff))),
          ),
          child: PartnerWidget(partner: aid.partner!),
        ),
      ],
      const SizedBox(height: DsfrSpacings.s4w),
      FnvHtmlWidget(aid.content),
      const SizedBox(height: DsfrSpacings.s6w),
    ],
  );
}
