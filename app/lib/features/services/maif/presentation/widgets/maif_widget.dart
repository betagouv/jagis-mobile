import 'package:app/features/action/domain/action.dart';
import 'package:app/features/action/presentation/bloc/action_bloc.dart';
import 'package:app/features/action/presentation/bloc/action_event.dart';
import 'package:app/features/services/maif/domain/fetch_risk_info_for_address.dart';
import 'package:app/features/services/maif/presentation/bloc/maif_bloc.dart';
import 'package:app/features/services/maif/presentation/bloc/maif_event.dart';
import 'package:app/features/services/maif/presentation/bloc/maif_state.dart';
import 'package:app/features/services/maif/presentation/widgets/maif_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class MaifWidget extends StatelessWidget {
  const MaifWidget({super.key, required this.action});

  final ActionSimulator action;

  @override
  Widget build(final BuildContext context) => BlocProvider(
    create: (final context) =>
        MaifBloc(context.read(), context.read(), FetchRiskInfoForAddress(context.read()))..add(const MaifLoadRequested()),
    child: _View(action),
  );
}

class _View extends StatelessWidget {
  const _View(this.action);

  final ActionSimulator action;

  @override
  Widget build(final BuildContext context) => BlocConsumer<MaifBloc, MaifState>(
    builder: (final context, final state) => switch (state) {
      MaifInitial() => const SizedBox.shrink(),
      MaifLoadInProgress() => const Center(child: CircularProgressIndicator()),
      MaifLoadSuccess() => MaifSuccess(data: state),
      MaifLoadFailure() => const Center(
        child: Text('Une erreur est survenue lors du chargement des données.', style: TextStyle(color: DsfrColors.error425)),
      ),
    },
    listener: (final context, final state) {
      if (state is MaifLoadSuccess && !action.isDone && state.userAddress.isFull) {
        context.read<ActionBloc>().add(ActionMarkAsDone(id: action.id, type: action.type));
      }
    },
  );
}
