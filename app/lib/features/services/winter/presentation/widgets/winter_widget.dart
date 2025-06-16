import 'package:app/core/address/address.dart';
import 'package:app/core/presentation/widgets/composants/address/address_search_with_save_widget.dart';
import 'package:app/core/presentation/widgets/composants/modal.dart';
import 'package:app/features/services/winter/infrastructure/winter_repository.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_bloc.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_event.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_state.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app_ds/app_ds.dart';
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
      WinterInitial() => const _Start(),
      WinterLoading() => const FnvLoader(),
      WinterForm() => const _Form(),
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
              builder: (final context) => const Text('Connexion établie'),
              name: 'connection-established-modal',
            );
          case WinterConnectionStatus.failed:
            await FnvModal.showFullModal<void>(
              context: context,
              builder: (final context) => const Text('La connexion a échoué'),
              name: 'connection-failed-modal',
            );
        }
      }
    },
  );
}

class _Start extends StatelessWidget {
  const _Start();

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(Localisation.winterTitre, style: DsfrTextStyle.headline4(color: DsfrColorDecisions.textTitleGrey(context))),
      const SizedBox(height: DsfrSpacings.s1w),
      Text(Localisation.winterDescription, style: DsfrTextStyle.bodyMd(color: DsfrColorDecisions.textLabelGrey(context))),
      const SizedBox(height: DsfrSpacings.s2w),
      DsfrButton(
        label: Localisation.commencer,
        variant: DsfrButtonVariant.primary,
        size: DsfrComponentSize.lg,
        onPressed: () {
          context.read<WinterBloc>().add(const WinterStarted());
        },
      ),
    ],
  );
}

class _Form extends StatelessWidget {
  const _Form();

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    spacing: DsfrSpacings.s3w,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: DsfrSpacings.s2w,
        children: [
          Text(
            Localisation.localiserMonCompteur,
            style: DsfrTextStyle.headline4(color: DsfrColorDecisions.textTitleGrey(context)),
          ),
          ColoredBox(
            color: const Color(0xFFF7F7FC),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FnvRadiosGroup(
                values: const {true: 'Avec mon adresse postale', false: 'Avec mon numéro de PRM'},
                initialValue: true,
                onChanged: (final value) {},
                direction: Direction.vertical,
                size: DsfrComponentSize.md,
                isRich: false,
              ),
            ),
          ),
        ],
      ),
      Column(
        spacing: DsfrSpacings.s2w,
        children: [
          _AddressInput(
            label: Localisation.monAdresse,
            onSelected: (final option) => context.read<WinterBloc>().add(WinterAddressChanged(option.label)),
          ),
          DsfrInput(
            label: Localisation.nomDeFamille,
            onChanged: (final value) => context.read<WinterBloc>().add(WinterLastNameChanged(value)),
          ),
        ],
      ),
      DsfrCheckbox(
        label: Localisation.winterJeDeclare,
        size: DsfrComponentSize.sm,
        value: context.select<WinterBloc, bool>((final bloc) {
          final current = bloc.state;
          if (current is! WinterForm) {
            return false;
          }

          return current.isDeclarationChecked;
        }),
        onChanged: (final value) => context.read<WinterBloc>().add(WinterDeclarationChanged(value)),
      ),
      DsfrButton(
        label: Localisation.valider,
        variant: DsfrButtonVariant.primary,
        size: DsfrComponentSize.lg,
        onPressed:
            context.select<WinterBloc, bool>((final bloc) {
              final current = bloc.state;
              if (current is! WinterForm) {
                return false;
              }

              return current.isFormValid;
            })
            ? () => context.read<WinterBloc>().add(const WinterSubmit())
            : null,
      ),
    ],
  );
}

class _AddressInput extends StatelessWidget {
  const _AddressInput({required this.label, required this.onSelected});

  final String label;
  final AutocompleteOnSelected<Address> onSelected;

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: DsfrSpacings.s1w,
    children: [
      Text(label, style: DsfrTextStyle.bodyMd(color: DsfrColorDecisions.textLabelGrey(context))),
      AddressSearchWithSaveWidget(onSelected: onSelected),
    ],
  );
}
