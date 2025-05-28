import 'package:app/core/infrastructure/url_launcher.dart';
import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/fnv_map.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/features/services/core/infrastructure/service_repository.dart';
import 'package:app/features/services/lvao/presentation/lvao_detail/bloc/lvao_detail_bloc.dart';
import 'package:app/features/services/lvao/presentation/lvao_detail/bloc/lvao_detail_event.dart';
import 'package:app/features/services/lvao/presentation/lvao_detail/bloc/lvao_detail_state.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LvaoDetailPage extends StatelessWidget {
  const LvaoDetailPage({super.key, required this.id});

  static const name = 'longue-vie-aux-objets-detail';
  static const path = ':id';

  final String id;

  static GoRoute get route => GoRoute(
    path: path,
    name: name,
    builder: (final context, final state) => LvaoDetailPage(id: state.pathParameters['id']!),
  );

  @override
  Widget build(final BuildContext context) => FnvScaffold(
    appBar: FnvAppBar(),
    body: BlocProvider(
      create: (final context) => LvaoDetailBloc(ServiceRepository(context.read()))..add(LvaoDetailLoadRequested(id)),
      child: const _Body(),
    ),
  );
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(final BuildContext context) => BlocBuilder<LvaoDetailBloc, LvaoDetailState>(
    builder: (final context, final state) => switch (state) {
      LvaoDetailInitial() || LvaoDetailLoadInProgress() => const Center(child: CircularProgressIndicator()),
      LvaoDetailLoadFailure() => const Center(child: Text('Une erreur est survenue')),
      LvaoDetailLoadSuccess() => _Success(success: state),
    },
  );
}

class _Success extends StatelessWidget {
  const _Success({required this.success});

  final LvaoDetailLoadSuccess success;

  @override
  Widget build(final BuildContext context) {
    final detail = success.detail;

    return ListView(
      padding: const EdgeInsets.all(DsfrSpacings.s2w),
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: DsfrTag.sm(
            label: TextSpan(text: Localisation.distance(detail.distanceInMeters)),
            backgroundColor: const Color(0xffEAEAEA),
            foregroundColor: const Color(0xff3F3F3F),
            textStyle: const DsfrTextStyle.bodyXsMedium(),
          ),
        ),
        Text(detail.name, style: const DsfrTextStyle.headline2()),
        const SizedBox(height: DsfrSpacings.s2w),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.5,
          child: FnvMap(latitude: detail.latitude, longitude: detail.longitude),
        ),
        const SizedBox(height: DsfrSpacings.s3w),
        const Text(Localisation.details, style: DsfrTextStyle.headline4()),
        const SizedBox(height: DsfrSpacings.s2w),
        _DetailInfo(icon: DsfrIcons.mapMapPin2Line, text: detail.address),
        const SizedBox(height: DsfrSpacings.s3w),
        Align(
          alignment: Alignment.centerLeft,
          child: FittedBox(
            child: DsfrButton(
              label: Localisation.proposerUneModification,
              icon: DsfrIcons.systemExternalLinkLine,
              iconLocation: DsfrButtonIconLocation.right,
              variant: DsfrButtonVariant.secondary,
              size: DsfrComponentSize.lg,
              onPressed: () async {
                await FnvUrlLauncher.launch('https://tally.so/r/3xMqd9?Nom=${detail.name}&Adresse=${detail.address}');
              },
            ),
          ),
        ),
        if (detail.sources.isNotEmpty) ...[
          const SizedBox(height: DsfrSpacings.s3w),
          const DsfrDivider(),
          const SizedBox(height: DsfrSpacings.s3w),
          const Text(Localisation.sources, style: DsfrTextStyle.bodyXsBold()),
          ...detail.sources.map((final e) => Text('· $e', style: const DsfrTextStyle.bodyXs())),
        ],
        const SafeArea(child: SizedBox(height: DsfrSpacings.s2w)),
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
      Expanded(child: Text(text, style: const DsfrTextStyle.bodyMd())),
    ],
  );
}
