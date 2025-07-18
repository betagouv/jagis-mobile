import 'package:app/core/presentation/widgets/composants/address/user_address_repository.dart';
import 'package:app/core/presentation/widgets/composants/modal.dart';
import 'package:app/features/action/domain/action.dart';
import 'package:app/features/action/presentation/bloc/action_bloc.dart';
import 'package:app/features/action/presentation/bloc/action_event.dart';
import 'package:app/features/actions/domain/action_type.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_bloc.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_event.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_state.dart';
import 'package:app/features/services/winter/presentation/widgets/winter_connection_established_modal.dart';
import 'package:app/features/services/winter/presentation/widgets/winter_connection_failed_modal.dart';
import 'package:app/features/services/winter/presentation/widgets/winter_consumption_part.dart';
import 'package:app/features/services/winter/presentation/widgets/winter_form_widget.dart';
import 'package:app/features/services/winter/presentation/widgets/winter_questions_part.dart';
import 'package:app/features/services/winter/presentation/widgets/winter_start_widget.dart';
import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class WinterWidget extends StatelessWidget {
  const WinterWidget({super.key, required this.sequenceId, required this.isDone});

  final String sequenceId;
  final bool isDone;

  @override
  Widget build(final BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
    child: BlocProvider(
      create: (final context) =>
          WinterBloc(context.read(), UserAddressRepository(context.read()))..add(WinterActionIsDone(isDone)),
      child: _View(sequenceId: sequenceId, isDone: isDone),
    ),
  );
}

class _View extends StatelessWidget {
  const _View({required this.sequenceId, required this.isDone});

  final String sequenceId;
  final bool isDone;

  Future<void> _handleStateChange(final BuildContext context, final WinterState state) async {
    if (state is WinterMyConsumption && !isDone) {
      context.read<ActionBloc>().add(ActionMarkAsDone(id: ActionSimulatorId.winter.apiString, type: ActionType.simulator));

      return;
    }

    if (state is! WinterForm) {
      return;
    }

    switch (state.connectionStatus) {
      case WinterConnectionStatus.unknown:
        break;
      case WinterConnectionStatus.established:
        await _handleConnectionEstablished(context);
      case WinterConnectionStatus.failed:
        await _handleConnectionFailed(context);
    }
  }

  Future<void> _handleConnectionEstablished(final BuildContext context) async {
    final isContinued = await FnvModal.showFullModal<bool>(
      context: context,
      builder: (final context) => const WinterConnectionEstablishedModal(),
      name: 'connection-established-modal',
    );

    if (!context.mounted) {
      return;
    }

    if (isContinued == null) {
      context.read<WinterBloc>().add(const WinterConnectionStatusReset());
    } else {
      context.read<WinterBloc>().add(WinterStartQuestions(sequenceId));
    }
  }

  Future<void> _handleConnectionFailed(final BuildContext context) async {
    await FnvModal.showFullModal<void>(
      context: context,
      builder: (final context) => const WinterConnectionFailedModal(),
      name: 'connection-failed-modal',
    );

    if (!context.mounted) {
      return;
    }

    context.read<WinterBloc>().add(const WinterConnectionStatusReset());
  }

  @override
  Widget build(final BuildContext context) => BlocConsumer<WinterBloc, WinterState>(
    builder: (final context, final state) => switch (state) {
      WinterLoading() => const FnvLoader(),
      WinterInitial() => const WinterStartWidget(),
      WinterForm() => WinterFormWidget(current: state),
      WinterQuestionsState() => WinterQuestionsPart(sequenceId: sequenceId),
      WinterMyConsumption() => WinterConsumptionPart(myConsumption: state),
    },
    listener: _handleStateChange,
  );
}
