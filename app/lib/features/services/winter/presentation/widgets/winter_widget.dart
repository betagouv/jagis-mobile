import 'package:app/core/presentation/widgets/composants/modal.dart';
import 'package:app/features/services/winter/domain/winter_registration.dart';
import 'package:app/features/services/winter/infrastructure/winter_repository.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_bloc.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_event.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_state.dart';
import 'package:app/features/services/winter/presentation/widgets/winter_connection_established_modal.dart';
import 'package:app/features/services/winter/presentation/widgets/winter_connection_failed_modal.dart';
import 'package:app/features/services/winter/presentation/widgets/winter_consumption_part.dart';
import 'package:app/features/services/winter/presentation/widgets/winter_form_widget.dart';
import 'package:app/features/services/winter/presentation/widgets/winter_questions_part.dart';
import 'package:app/features/services/winter/presentation/widgets/winter_start_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class WinterWidget extends StatelessWidget {
  const WinterWidget({super.key, required this.sequenceId});

  final String sequenceId;

  @override
  Widget build(final BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
    child: BlocProvider(
      create: (final context) => WinterBloc(WinterRepository(context.read())),
      child: _View(sequenceId: sequenceId),
    ),
  );
}

class _View extends StatelessWidget {
  const _View({required this.sequenceId});

  final String sequenceId;

  Future<void> _handleStateChange(final BuildContext context, final WinterState state) async {
    if (state is! WinterForm) {
      return;
    }

    switch (state.connectionStatus) {
      case WinterConnectionStatus.unknown:
        break;
      case WinterConnectionStatus.established:
        await _handleConnectionEstablished(context, state);
      case WinterConnectionStatus.failed:
        await _handleConnectionFailed(context);
    }
  }

  Future<void> _handleConnectionEstablished(final BuildContext context, final WinterForm state) async {
    final isContinued = await FnvModal.showFullModal<bool>(
      context: context,
      builder: (final context) =>
          WinterConnectionEstablishedModal(lastName: state.lastName, city: state.address.city, prm: state.prmNumber),
      name: 'connection-established-modal',
    );

    if (!context.mounted || isContinued == null) {
      return;
    }

    if (isContinued) {
      context.read<WinterBloc>().add(WinterStartQuestions(sequenceId));
    } else {
      context.read<WinterBloc>().add(const WinterConnectionStatusReset());
    }
  }

  Future<void> _handleConnectionFailed(final BuildContext context) async {
    final isSwitchedToPrm = await FnvModal.showFullModal<bool>(
      context: context,
      builder: (final context) => const WinterConnectionFailedModal(),
      name: 'connection-failed-modal',
    );

    if (!context.mounted || isSwitchedToPrm == null) {
      return;
    }

    final bloc = context.read<WinterBloc>()..add(const WinterConnectionStatusReset());
    if (isSwitchedToPrm) {
      bloc.add(const WinterFormTypeChanged(RegistrationType.prm));
    }
  }

  @override
  Widget build(final BuildContext context) => BlocConsumer<WinterBloc, WinterState>(
    builder: (final context, final state) => switch (state) {
      WinterInitial() => const WinterStartWidget(),
      WinterForm() => const WinterFormWidget(),
      WinterQuestionsState() => WinterQuestionsPart(sequenceId: sequenceId),
      WinterMyConsumption() => WinterConsumptionPart(myConsumption: state),
    },
    listener: _handleStateChange,
  );
}
