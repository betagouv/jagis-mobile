import 'package:app/core/infrastructure/url_launcher.dart';
import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/fnv_map.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/features/services/core/infrastructure/service_repository.dart';
import 'package:app/features/services/pdcn/presentation/pdcn_detail/bloc/pdcn_detail_bloc.dart';
import 'package:app/features/services/pdcn/presentation/pdcn_detail/bloc/pdcn_detail_event.dart';
import 'package:app/features/services/pdcn/presentation/pdcn_detail/bloc/pdcn_detail_state.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:go_router/go_router.dart';

class PdcnDetailPage extends StatelessWidget {
  const PdcnDetailPage({super.key, required this.id});

  static const name = 'pres-de-chez-nous-detail';
  static const path = ':id';

  final String id;

  static GoRoute get route => GoRoute(
    path: path,
    name: name,
    builder: (final context, final state) => PdcnDetailPage(id: state.pathParameters['id']!),
  );

  @override
  Widget build(final BuildContext context) => FnvScaffold(
    appBar: FnvAppBar(),
    body: BlocProvider(
      create: (final context) => PdcnDetailBloc(ServiceRepository(context.read()))..add(PdcnDetailLoadRequested(id)),
      child: const _Body(),
    ),
  );
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(final BuildContext context) => BlocBuilder<PdcnDetailBloc, PdcnDetailState>(
    builder: (final context, final state) => switch (state) {
      PdcnDetailInitial() || PdcnDetailLoadInProgress() => const Center(child: CircularProgressIndicator()),
      PdcnDetailLoadFailure() => const Center(child: Text('Une erreur est survenue')),
      PdcnDetailLoadSuccess() => _Success(success: state),
    },
  );
}

class _Success extends StatelessWidget {
  const _Success({required this.success});

  final PdcnDetailLoadSuccess success;

  @override
  Widget build(final BuildContext context) {
    final detail = success.detail;

    return ListView(
      padding: const EdgeInsets.all(DsfrSpacings.s2w),
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: DsfrTag(
            label: Localisation.distance(detail.distanceInMeters),
            size: DsfrComponentSize.md,
            backgroundColor: const Color(0xffEAEAEA),
            textColor: const Color(0xff3F3F3F),
          ),
        ),
        Text(detail.title, style: const DsfrTextStyle.headline2(color: DsfrColors.grey50)),
        if (detail.description != null) Text(detail.description!, style: const DsfrTextStyle.bodyMd(color: DsfrColors.grey50)),
        const SizedBox(height: DsfrSpacings.s2w),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.5,
          child: FnvMap(latitude: detail.latitude, longitude: detail.longitude),
        ),
        const SizedBox(height: DsfrSpacings.s3w),
        const Text(Localisation.details, style: DsfrTextStyle.headline4(color: DsfrColors.grey50)),
        const SizedBox(height: DsfrSpacings.s2w),
        ...[
          if (detail.openingHours != null) _DetailInfo(icon: DsfrIcons.systemTimeLine, text: detail.openingHours!),
          _DetailInfo(icon: DsfrIcons.mapMapPin2Line, text: detail.address),
          if (detail.phone != null) _DetailInfo(icon: DsfrIcons.devicePhoneLine, text: detail.phone!),
        ].separator(const SizedBox(height: DsfrSpacings.s1w)),
        if (detail.website != null) ...[
          const SizedBox(height: DsfrSpacings.s2w),
          DsfrLink(
            label: Localisation.enSavoirPlus,
            iconPosition: DsfrLinkIconPosition.end,
            icon: DsfrIcons.systemExternalLinkLine,
            onTap: () async {
              await FnvUrlLauncher.launch(detail.website!);
            },
          ),
        ],
        const SafeArea(child: SizedBox.shrink()),
      ],
    );
  }
}

class _DetailInfo extends StatelessWidget {
  const _DetailInfo({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(final BuildContext context) => Row(
    spacing: DsfrSpacings.s1w,
    children: [
      Icon(icon, color: DsfrColors.blueFranceSun113),
      Expanded(
        child: Text(text, style: const DsfrTextStyle.bodyMd(color: DsfrColors.grey50)),
      ),
    ],
  );
}
