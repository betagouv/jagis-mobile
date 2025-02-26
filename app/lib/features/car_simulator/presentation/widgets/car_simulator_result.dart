import 'package:app/core/helpers/number_format.dart';
import 'package:app/core/presentation/widgets/composants/card.dart';
import 'package:app/core/presentation/widgets/composants/dropdown_button.dart';
import 'package:app/features/car_simulator/domain/car_simulator.dart';
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
  Widget build(final context) {
    final state = context.watch<CarSimulatorBloc>().state;

    // NOTE(erolley): do we need an FnvScaffold here?
    switch (state) {
      case CarSimulatorLoading():
        {
          context.read<CarSimulatorBloc>().add(const CarSimulatorGetCurrentCarResult());
          return const Center(child: CircularProgressIndicator());
        }
      case CarSimulatorGetCurrentCarSuccess():
        {
          context.read<CarSimulatorBloc>().add(CarSimulatorGetCarOptions(state.currentCar));
          return _CarSimulatorResultView(currentCar: state.currentCar);
        }
      case CarSimulatorGetCarOptionsSuccess():
        return _CarSimulatorResultView(currentCar: state.currentCar, carOptions: state.carOptions);
      case CarSimulatorLoadFailure(:final errorMessage):
        return Center(child: Text(errorMessage));
    }
  }
}

class _CarSimulatorResultView extends StatelessWidget {
  const _CarSimulatorResultView({required this.currentCar, this.carOptions});

  final CarInfos currentCar;
  final List<CarSimulatorOption>? carOptions;

  @override
  Widget build(final BuildContext context) {
    // NOTE(erolley): ListView doesn't work here
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w, vertical: DsfrSpacings.s4w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: DsfrSpacings.s4w,
        children: [_CurrentCarResultView(currentCar), _BestCarOptionView(carOptions)],
      ),
    );
  }
}

class _BestCarOptionView extends StatelessWidget {
  const _BestCarOptionView(this.options);

  final List<CarSimulatorOption>? options;

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
                value: CarSize.small,
                onChanged: (final value) => value,
                // TODO: implement
              ),
            ),
          ],
        ),
      ),
      if (options == null) const Center(child: CircularProgressIndicator()) else Text(options!.length.toString()),
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
  Widget build(final BuildContext context) => Row(
    spacing: DsfrSpacings.s1w,
    // NOTE(erolley): baseline crashes here
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Text(FnvNumberFormat.formatNumber(num), style: const DsfrTextStyle.body2XlBold()),
      Text(unit, style: const DsfrTextStyle.bodyLg()),
    ],
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
