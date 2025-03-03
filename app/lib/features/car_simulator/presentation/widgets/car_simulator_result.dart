import 'package:app/core/helpers/number_format.dart';
import 'package:app/core/presentation/widgets/composants/card.dart';
import 'package:app/core/presentation/widgets/composants/dropdown_button.dart';
import 'package:app/features/car_simulator/domain/car_simulator.dart';
import 'package:app/features/car_simulator/infrastructure/car_simulator_repository.dart';
import 'package:app/features/car_simulator/presentation/bloc/car_simulator_bloc.dart';
import 'package:app/features/car_simulator/presentation/bloc/car_simulator_event.dart';
import 'package:app/features/car_simulator/presentation/bloc/car_simulator_state.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarSimulatorResult extends StatelessWidget {
  const CarSimulatorResult({super.key});

  @override
  Widget build(final context) => BlocProvider(
    create:
        (final context) =>
            CarSimulatorBloc(repository: context.read<CarSimulatorRepository>())..add(const CarSimulatorGetCurrentCarResult()),
    child: const _View(),
  );
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final BuildContext context) {
    final blocState = context.watch<CarSimulatorBloc>().state;

    return switch (blocState) {
      CarSimulatorLoading() => const Center(child: CircularProgressIndicator()),
      CarSimulatorGetCurrentCarSuccess() => _CarSimulatorResultView(
        currentCar: blocState.currentCar,
        selectedSize: blocState.currentCar.size.value,
      ),
      CarSimulatorGetCarOptionsSuccess() => _CarSimulatorResultView(
        currentCar: blocState.currentCar,
        selectedSize: blocState.selectedSize,
        bestCostOption: blocState.bestCostOption,
        bestEmissionsOption: blocState.bestEmissionOption,
      ),
      CarSimulatorLoadFailure(:final errorMessage) => Center(child: Text(errorMessage)),
    };
  }
}

class _CarSimulatorResultView extends StatelessWidget {
  const _CarSimulatorResultView({
    required this.currentCar,
    required this.selectedSize,
    this.bestCostOption,
    this.bestEmissionsOption,
  });

  final CarInfos currentCar;
  final CarSize selectedSize;
  final BestCostCarSimulatorOption? bestCostOption;
  final BestEmissionCarSimulatorOption? bestEmissionsOption;

  @override
  Widget build(final BuildContext context) {
    // NOTE(erolley): ListView doesn't work here
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w, vertical: DsfrSpacings.s4w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: DsfrSpacings.s4w,
        children: [
          _BestCarOptionView(
            selectedSize: selectedSize,
            bestCostOption: bestCostOption,
            bestEmissionsOption: bestEmissionsOption,
          ),
          _CurrentCarResultView(currentCar),
        ],
      ),
    );
  }
}

class _BestCarOptionView extends StatelessWidget {
  const _BestCarOptionView({required this.selectedSize, required this.bestCostOption, required this.bestEmissionsOption});

  final CarSize selectedSize;
  final BestCostCarSimulatorOption? bestCostOption;
  final BestEmissionCarSimulatorOption? bestEmissionsOption;

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: DsfrSpacings.s2w,
    children: [
      Text.rich(
        TextSpan(
          children: [
            const TextSpan(text: Localisation.lesMeilleuresAlternativesPourLeGabarit, style: DsfrTextStyle.headline2()),
            WidgetSpan(
              alignment: PlaceholderAlignment.baseline,
              baseline: TextBaseline.alphabetic,
              child: FnvDropdown<CarSize>(
                items: const {
                  CarSize.small: 'citadine',
                  CarSize.medium: 'monospace',
                  CarSize.sedan: 'berline',
                  CarSize.suv: 'SUV',
                  CarSize.utilityVehicle: 'VUL',
                },
                value: selectedSize,
                onChanged: (final value) => context.read<CarSimulatorBloc>().add(CarSimulatorNewSelectedCarSize(value)),
              ),
            ),
          ],
        ),
      ),
      if (bestCostOption == null)
        const Center(child: CircularProgressIndicator())
      else
        Text(bestCostOption!.diffWithCurrentCar.toString()),

      if (bestEmissionsOption == null)
        const Center(child: CircularProgressIndicator())
      else
        Text(bestEmissionsOption!.percentDiffWithCurrentCar.toString()),
    ],
  );
}

class _CurrentCarResultView extends StatelessWidget {
  const _CurrentCarResultView(this.currentCar);

  final CarInfos currentCar;

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: DsfrSpacings.s2w,
    children: [
      const Text(Localisation.votreVehiculeActuel, style: DsfrTextStyle.headline2()),
      FnvCard(
        child: Padding(
          padding: const EdgeInsets.all(DsfrSpacings.s2w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(Localisation.coutAnnuel, style: DsfrTextStyle.bodyMd()),
              _NumberWithUnit(num: currentCar.cost, unit: Localisation.euroSymbol),
              const SizedBox(height: DsfrSpacings.s2w),
              const Text(Localisation.emissionsAnnuelles, style: DsfrTextStyle.bodyMd()),
              _NumberWithUnit(num: currentCar.emissions, unit: Localisation.kgCO2e),
              const SizedBox(height: DsfrSpacings.s2w),
              _ContextInfosView(currentCar: currentCar),
            ],
          ),
        ),
      ),
    ],
  );
}

class _NumberWithUnit extends StatelessWidget {
  const _NumberWithUnit({required this.num, required this.unit});

  final double num;
  final String unit;

  @override
  Widget build(final BuildContext context) => Text.rich(
    TextSpan(
      text: FnvNumberFormat.formatNumber(num),
      style: const DsfrTextStyle.body2XlBold(),
      children: [const TextSpan(text: ' '), TextSpan(text: unit, style: const DsfrTextStyle.bodyLg())],
    ),
  );
}

class _ContextInfosView extends StatelessWidget {
  const _ContextInfosView({required this.currentCar});

  final CarInfos currentCar;

  @override
  Widget build(final BuildContext context) => Container(
    width: double.infinity,
    decoration: const ShapeDecoration(shape: Border(top: BorderSide(color: DsfrColors.blueFrance950))),
    padding: const EdgeInsets.only(top: DsfrSpacings.s2w),
    child: Row(
      spacing: DsfrSpacings.s1w,
      children: [
        _ContextInfo(label: currentCar.size.label),
        _ContextInfo(label: currentCar.motorisation.label),
        if (currentCar.fuel == null) const SizedBox() else _ContextInfo(label: currentCar.fuel!.label),
      ],
    ),
  );
}

class _ContextInfo extends StatelessWidget {
  const _ContextInfo({required this.label});

  final String label;

  @override
  Widget build(final BuildContext context) => DsfrTag.md(
    label: TextSpan(text: label),
    backgroundColor: DsfrColors.blueFrance950,
    foregroundColor: DsfrColors.blueFranceSun113,
  );
}
