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
        selectedSize: blocState.currentCar.size.value.smaller,
        hasChargingStation: true,
      ),
      CarSimulatorGetCarOptionsSuccess() => _CarSimulatorResultView(
        currentCar: blocState.currentCar,
        selectedSize: blocState.selectedSize,
        hasChargingStation: blocState.hasChargingStation,
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
    required this.hasChargingStation,
    this.bestCostOption,
    this.bestEmissionsOption,
  });

  final CarInfos currentCar;
  final CarSize selectedSize;
  final bool hasChargingStation;
  final CarSimulatorOption? bestCostOption;
  final CarSimulatorOption? bestEmissionsOption;

  @override
  Widget build(final BuildContext context) =>
  // NOTE(erolley): ListView doesn't work here
  Padding(
    padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w, vertical: DsfrSpacings.s4w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: DsfrSpacings.s4w,
      children: [
        _BestCarOptionView(
          currentCar: currentCar,
          selectedSize: selectedSize,
          hasChargingStation: hasChargingStation,
          bestCostOption: bestCostOption,
          bestEmissionsOption: bestEmissionsOption,
        ),
        _CurrentCarResultView(currentCar),
      ],
    ),
  );
}

class _BestCarOptionView extends StatelessWidget {
  const _BestCarOptionView({
    required this.currentCar,
    required this.selectedSize,
    required this.hasChargingStation,
    required this.bestCostOption,
    required this.bestEmissionsOption,
  });

  final CarInfos currentCar;
  final CarSize selectedSize;
  final bool hasChargingStation;
  final CarSimulatorOption? bestCostOption;
  final CarSimulatorOption? bestEmissionsOption;

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
      DsfrCheckbox.md(
        label: Localisation.rechargeElectriqueQuestion,
        value: hasChargingStation,
        onChanged: (final value) => context.read<CarSimulatorBloc>().add(CarSimulatorToggleChargingStation(value)),
      ),
      if (bestEmissionsOption == null || bestCostOption == null)
        const Center(child: CircularProgressIndicator())
      else
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          clipBehavior: Clip.none,
          child: IntrinsicHeight(
            child: Row(
              spacing: DsfrSpacings.s2w,
              children: [
                _CarSimulatorOptionView(option: bestCostOption!, currentCar: currentCar, kind: CarSimulatorOptionKind.bestCost),
                _CarSimulatorOptionView(
                  option: bestEmissionsOption!,
                  currentCar: currentCar,
                  kind: CarSimulatorOptionKind.bestEmission,
                ),
              ],
            ),
          ),
        ),
    ],
  );
}

class _CarSimulatorOptionView extends StatelessWidget {
  const _CarSimulatorOptionView({required this.currentCar, required this.option, required this.kind});

  final CarInfos currentCar;
  final CarSimulatorOption option;
  final CarSimulatorOptionKind kind;

  @override
  Widget build(final BuildContext context) {
    final currentCarIsBest =
        kind == CarSimulatorOptionKind.bestCost ? currentCar.cost <= option.cost : currentCar.emissions <= option.emissions;

    return FnvCard(
      child: Padding(
        padding: const EdgeInsets.all(DsfrSpacings.s2w),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 250),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: DsfrSpacings.s2w,
            children: [
              getCarSimulatorKindTag(),
              if (currentCarIsBest)
                Text(switch (kind) {
                  CarSimulatorOptionKind.bestCost => Localisation.vousAvezDejaLOptionLaPlusEconomique,
                  CarSimulatorOptionKind.bestEmission => Localisation.vousAvezDejaLOptionLaPlusEcologique,
                }, style: const DsfrTextStyle.headline5())
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: DsfrSpacings.s2w,
                  children: [
                    Text(option.title, style: const DsfrTextStyle.headline4()),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(Localisation.coutAnnuel, style: DsfrTextStyle.bodyMd()),
                        Row(
                          spacing: DsfrSpacings.s1w,
                          children: [
                            _NumberWithUnit(num: option.cost, unit: Localisation.euroSymbol),
                            _DiffInTag(from: currentCar.cost, to: option.cost, unit: Localisation.euroSymbol),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(Localisation.emissionsAnnuelles, style: DsfrTextStyle.bodyMd()),
                        Row(
                          spacing: DsfrSpacings.s1w,
                          children: [
                            _NumberWithUnit(num: option.emissions, unit: Localisation.kgCO2e),
                            _DiffInTag(from: currentCar.emissions, to: option.emissions, unit: '%'),
                          ],
                        ),
                        const SizedBox(height: DsfrSpacings.s2w),
                        _ContextInfosView(carInfos: option),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  DsfrTag getCarSimulatorKindTag() => switch (kind) {
    CarSimulatorOptionKind.bestCost => DsfrTag.md(
      icon: DsfrIcons.financeMoneyEuroCircleFill,
      label: const TextSpan(text: Localisation.laPlusEconomique),
      backgroundColor: Colors.amber[100]!,
      foregroundColor: Colors.amber[700]!,
    ),
    CarSimulatorOptionKind.bestEmission => DsfrTag.md(
      icon: DsfrIcons.othersLeafFill,
      label: const TextSpan(text: Localisation.laPlusEcologique),
      backgroundColor: Colors.green[100]!,
      foregroundColor: Colors.green[700]!,
    ),
  };
}

class _DiffInTag extends StatelessWidget {
  const _DiffInTag({required this.from, required this.to, required this.unit});

  final double from;
  final double to;
  final String unit;

  @override
  Widget build(final BuildContext context) {
    final diff = unit == '%' ? (to - from) / from * 100 : to - from;
    final color = diff > 0 ? Colors.red : Colors.lightGreen;
    final sign = diff > 0 ? '+' : '-';

    return diff == 0
        ? const SizedBox()
        : DsfrTag.md(
          label: TextSpan(
            text: sign + FnvNumberFormat.formatNumberAfterRounding(diff.abs()),
            children: [TextSpan(text: ' $unit')],
            style: DsfrTextStyle.bodyMdBold(color: color[800]!),
          ),
          backgroundColor: color[50]!,
          foregroundColor: color[800]!,
        );
  }
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
              _ContextInfosView(carInfos: currentCar),
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
  const _ContextInfosView({required this.carInfos});

  final CarInfos carInfos;

  @override
  Widget build(final BuildContext context) => Container(
    decoration: const ShapeDecoration(shape: Border(top: BorderSide(color: DsfrColors.blueFrance950))),
    width: 250,
    padding: const EdgeInsets.only(top: DsfrSpacings.s2w),
    child: Wrap(
      spacing: DsfrSpacings.s1w,
      runSpacing: DsfrSpacings.s1w,
      children: [
        _ContextInfo(label: carInfos.size.label),
        _ContextInfo(label: carInfos.motorisation.label),
        if (carInfos.fuel == null) const SizedBox() else _ContextInfo(label: carInfos.fuel!.label),
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
