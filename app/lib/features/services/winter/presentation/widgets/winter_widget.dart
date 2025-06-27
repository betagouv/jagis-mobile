import 'package:app/core/presentation/widgets/composants/modal.dart';
import 'package:app/features/services/winter/domain/winter_registration.dart';
import 'package:app/features/services/winter/infrastructure/winter_repository.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_bloc.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_event.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_state.dart';
import 'package:app/features/services/winter/presentation/widgets/winter_connection_established_modal.dart';
import 'package:app/features/services/winter/presentation/widgets/winter_connection_failed_modal.dart';
import 'package:app/features/services/winter/presentation/widgets/winter_form_widget.dart';
import 'package:app/features/services/winter/presentation/widgets/winter_start_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class WinterWidget extends StatelessWidget {
  const WinterWidget({super.key});

  @override
  Widget build(final BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
    child: BlocProvider(create: (final context) => WinterBloc(WinterRepository(context.read())), child: const _View()),
  );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final BuildContext context) => BlocConsumer<WinterBloc, WinterState>(
    builder: (final context, final state) => switch (state) {
      WinterInitial() => const WinterStartWidget(),
      WinterForm() => const WinterFormWidget(),
    },
    listener: (final context, final state) async {
      if (state is WinterForm) {
        final connectionStatus = state.connectionStatus;
        switch (connectionStatus) {
          case WinterConnectionStatus.unknown:
            break;
          case WinterConnectionStatus.established:
            await FnvModal.showFullModal<void>(
              context: context,
              builder: (final context) => const WinterConnectionEstablishedModal(),
              name: 'connection-established-modal',
            );
            if (context.mounted) {
              context.read<WinterBloc>().add(const WinterConnectionStatusReset());
            }
          case WinterConnectionStatus.failed:
            final modalResult = await FnvModal.showFullModal<bool>(
              context: context,
              builder: (final context) => const WinterConnectionFailedModal(),
              name: 'connection-failed-modal',
            );
            if (context.mounted && modalResult != null) {
              context.read<WinterBloc>().add(const WinterConnectionStatusReset());
              if (modalResult) {
                context.read<WinterBloc>().add(const WinterFormTypeChanged(RegistrationType.prm));
              }
            }
        }
      }
    },
  );
}
