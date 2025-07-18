import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/bottom_bar.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/features/profil/logement/presentation/bloc/mon_logement_bloc.dart';
import 'package:app/features/profil/logement/presentation/bloc/mon_logement_event.dart';
import 'package:app/features/profil/logement/presentation/bloc/mon_logement_state.dart';
import 'package:app/features/profil/logement/presentation/widgets/mon_logement_form.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:go_router/go_router.dart';

class MonLogementPage extends StatelessWidget {
  const MonLogementPage({super.key});

  static const name = 'mon-logement';
  static const path = name;

  static GoRoute get route => GoRoute(path: path, name: name, builder: (final context, final state) => const MonLogementPage());

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (final context) =>
        MonLogementBloc(profilRepository: context.read(), communesRepository: context.read())
          ..add(const MonLogementRecuperationDemandee()),
    child: const _MonLogementView(),
  );
}

class _MonLogementView extends StatelessWidget {
  const _MonLogementView();

  @override
  Widget build(final BuildContext context) => FnvScaffold(
    appBar: FnvAppBar(),
    body: BlocBuilder<MonLogementBloc, MonLogementState>(
      builder: (final context, final state) {
        switch (state.statut) {
          case MonLogementStatut.initial:
          case MonLogementStatut.chargement:
            return const Center(child: CircularProgressIndicator());
          case MonLogementStatut.succes:
            return const MonLogementForm();
        }
      },
    ),
    bottomNavigationBar: FnvBottomBar(
      child: DsfrButton(
        label: Localisation.mettreAJourMesInformations,
        variant: DsfrButtonVariant.primary,
        size: DsfrComponentSize.lg,
        onPressed: () {
          context.read<MonLogementBloc>().add(const MonLogementMiseAJourDemandee());
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(content: Text(Localisation.miseAJourEffectuee)));
          GoRouter.of(context).pop();
        },
      ),
    ),
  );
}
