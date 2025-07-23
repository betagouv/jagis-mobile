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
import 'package:app/l10n/l10n.dart';
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
      create: (final context) => WinterBloc(context.read(), context.read(), context.read())..add(WinterActionIsDone(isDone)),
      child: _View(sequenceId: sequenceId, isDone: isDone),
    ),
  );
}

class _View extends StatefulWidget {
  const _View({required this.sequenceId, required this.isDone});

  final String sequenceId;
  final bool isDone;

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
  DialogRoute<void>? _loadingRoute;

  Future<void> _handleLoading(final BuildContext context) async {
    _loadingRoute = FnvModal.getModal(
      context,
      builder: (final context) => const Padding(
        padding: EdgeInsets.symmetric(vertical: DsfrSpacings.s9w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: DsfrSpacings.s1w,
          children: [
            FnvLoader(),
            Text(
              Localisation.localisationDeVotreCompteur,
              style: DsfrTextStyle.bodyLg(color: DsfrColors.grey50),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      isDismissible: false,
    );
    await FnvModal.push(context, dialogRoute: _loadingRoute);
  }

  Future<void> _handleConnectionEstablished(final BuildContext context) async {
    _closeLoadingModal(context);
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
      context.read<WinterBloc>().add(WinterStartQuestions(widget.sequenceId));
    }
  }

  Future<void> _handleConnectionFailed(final BuildContext context) async {
    _closeLoadingModal(context);
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

  void _closeLoadingModal(final BuildContext context) => FnvModal.pop(context, dialogRoute: _loadingRoute);

  @override
  Widget build(final BuildContext context) => BlocConsumer<WinterBloc, WinterState>(
    builder: (final context, final state) => switch (state) {
      WinterLoading() => const FnvLoader(),
      WinterInitial() => const WinterStartWidget(),
      WinterForm() => WinterFormWidget(current: state),
      WinterQuestionsState() => WinterQuestionsPart(sequenceId: widget.sequenceId),
      WinterMyConsumption() => WinterConsumptionPart(myConsumption: state),
    },
    listener: (final context, final state) async {
      if (state is WinterMyConsumption && !widget.isDone) {
        context.read<ActionBloc>().add(
          ActionMarkAsDone(id: ActionSimulatorId.wattWatchers.apiString, type: ActionType.simulator),
        );

        return;
      }

      if (state is! WinterForm) {
        return;
      }

      switch (state.connectionStatus) {
        case WinterConnectionStatus.unknown:
          break;
        case WinterConnectionStatus.loading:
          await _handleLoading(context);
        case WinterConnectionStatus.established:
          await _handleConnectionEstablished(context);
        case WinterConnectionStatus.failed:
          await _handleConnectionFailed(context);
      }
    },
  );
}
