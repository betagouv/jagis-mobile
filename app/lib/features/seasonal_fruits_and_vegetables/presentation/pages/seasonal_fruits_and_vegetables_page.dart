import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/features/seasonal_fruits_and_vegetables/presentation/bloc/seasonal_fruits_and_vegetables_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SeasonalFruitsAndVegetablesPage extends StatelessWidget {
  const SeasonalFruitsAndVegetablesPage({super.key});

  static const name = 'fruits-et-legumes';
  static const path = name;

  static GoRoute get route => GoRoute(
        path: path,
        name: name,
        builder: (final context, final state) =>
            const SeasonalFruitsAndVegetablesPage(),
      );

  @override
  Widget build(final BuildContext context) => FnvScaffold(
        appBar: FnvAppBar(),
        body: BlocProvider(
          create: (final context) => SeasonalFruitsAndVegetablesBloc(
            repository: context.read(),
          )..add(const SeasonalFruitsAndVegetablesFetch()),
          child: const _Body(),
        ),
      );
}

final class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(final BuildContext context) {
    final result = context.watch<SeasonalFruitsAndVegetablesBloc>().state;

    return switch (result) {
      SeasonalFruitsAndVegetablesLoadInProgress() =>
        const Text('Récolte des fruits et légumes...'),
      SeasonalFruitsAndVegetablesLoadSuccess() =>
        Text('Les fruits et légumes pour le mois de ${result.months}'),
      SeasonalFruitsAndVegetablesLoadFailure() => Text(
          'Erreur lors du chargement des fruits et légumes: ${result.error}',
        ),
      SeasonalFruitsAndVegetablesInitial() => const SizedBox.shrink(),
    };
  }
}
