import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/bottom_bar.dart';
import 'package:app/core/presentation/widgets/composants/failure_widget.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/features/profil/home/presentation/bloc/my_home_bloc.dart';
import 'package:app/features/profil/home/presentation/bloc/my_home_event.dart';
import 'package:app/features/profil/home/presentation/bloc/my_home_state.dart';
import 'package:app/features/profil/home/presentation/widgets/my_home_form.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:go_router/go_router.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  static const name = 'logement';
  static const path = name;

  static GoRoute get route => GoRoute(path: path, name: name, builder: (final context, final state) => const MyHomePage());

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (final context) => MyHomeBloc(context.read(), context.read())..add(const MyHomeLoadRequested()),
    child: const _View(),
  );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final BuildContext context) => BlocBuilder<MyHomeBloc, MyHomeState>(
    builder: (final context, final state) => switch (state) {
      MyHomeLoadInProgress() => FnvScaffold(
        appBar: FnvAppBar(),
        body: const Center(child: CircularProgressIndicator()),
      ),
      MyHomeLoadSuccess() => FnvScaffold(
        appBar: FnvAppBar(),
        body: MyHomeForm(success: state),
        bottomNavigationBar: FnvBottomBar(
          child: DsfrButton(
            label: Localisation.mettreAJourMesInformations,
            variant: DsfrButtonVariant.primary,
            size: DsfrComponentSize.lg,
            onPressed: () {
              context.read<MyHomeBloc>().add(const MyHomeUpdateRequested());
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(const SnackBar(content: Text(Localisation.miseAJourEffectuee)));
              GoRouter.of(context).pop();
            },
          ),
        ),
      ),
      MyHomeLoadFailure() => FnvScaffold(
        appBar: FnvAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(DsfrSpacings.s2w),
          child: FnvFailureWidget(onPressed: () => context.read<MyHomeBloc>().add(const MyHomeLoadRequested())),
        ),
      ),
    },
  );
}
