import 'package:app/core/helpers/number_format.dart';
import 'package:app/core/presentation/widgets/composants/dropdown_button.dart';
import 'package:app/core/presentation/widgets/composants/loader.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/shadows.dart';
import 'package:app/features/action/domain/action.dart';
import 'package:app/features/action/presentation/bloc/action_bloc.dart';
import 'package:app/features/action/presentation/bloc/action_event.dart';
import 'package:app/features/actions/domain/action_type.dart';
import 'package:app/features/car_simulator/domain/car_simulator.dart';
import 'package:app/features/car_simulator/presentation/car_simulator_result/bloc/car_simulator_result_bloc.dart';
import 'package:app/features/car_simulator/presentation/car_simulator_result/bloc/car_simulator_result_event.dart';
import 'package:app/features/car_simulator/presentation/car_simulator_result/bloc/car_simulator_result_state.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarSimulatorResult extends StatelessWidget {
  const CarSimulatorResult({super.key});

  @override
  Widget build(final BuildContext context) => const _View();
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(final BuildContext context) => BlocConsumer<CarSimulatorResultBloc, CarSimulatorResultState>(
    builder:
        (final context, final state) => switch (state) {
          CarSimulatorInit() => const Center(
            child: Padding(padding: EdgeInsets.symmetric(vertical: DsfrSpacings.s4w), child: FnvLoader()),
          ),
          CarSimulatorGetCurrentCarSuccess() => _CarSimulatorResultView(
            currentCar: state.currentCar,
            selectedSize: state.currentCar.size.value.smaller,
            hasChargingStation: true,
          ),
          CarSimulatorGetCarOptionsSuccess() => _CarSimulatorResultView(
            currentCar: state.currentCar,
            selectedSize: state.selectedSize,
            hasChargingStation: state.hasChargingStation,
            bestCostOption: state.bestCostOption,
            bestEmissionsOption: state.bestEmissionOption,
          ),
          CarSimulatorLoadFailure(:final errorMessage) => Center(child: Text(errorMessage)),
        },
    listener: (final context, final state) {
      if (state is CarSimulatorGetCurrentCarSuccess) {
        context.read<ActionBloc>().add(
          ActionMarkAsDone(id: ActionSimulatorId.carSimulator.apiString, type: ActionType.simulator),
        );
      }
    },
  );
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
  Widget build(final BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: DsfrSpacings.s2w),
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
      DsfrToggleSwitch(
        label: Localisation.rechargeElectriqueQuestion,
        value: hasChargingStation,
        onChanged: (final value) => context.read<CarSimulatorResultBloc>().add(CarSimulatorToggleChargingStation(value)),
      ),
      Text.rich(
        TextSpan(
          children: [
            const TextSpan(text: Localisation.lesMeilleuresAlternativesPourLeGabarit, style: DsfrTextStyle.headline2()),
            WidgetSpan(
              alignment: PlaceholderAlignment.baseline,
              baseline: TextBaseline.alphabetic,
              child: FnvDropdown<CarSize>(
                items: const {
                  CarSize.small: 'petite',
                  CarSize.medium: 'moyenne',
                  CarSize.sedan: 'berline',
                  CarSize.suv: 'SUV',
                  CarSize.utilityVehicle: 'VUL',
                },
                value: selectedSize,
                onChanged: (final value) => context.read<CarSimulatorResultBloc>().add(CarSimulatorNewSelectedCarSize(value)),
              ),
            ),
          ],
        ),
      ),
      if (bestEmissionsOption == null || bestCostOption == null)
        const Center(child: Padding(padding: EdgeInsets.symmetric(vertical: DsfrSpacings.s4w), child: FnvLoader()))
      else
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          clipBehavior: Clip.none,
          child: IntrinsicHeight(
            child: Row(
              spacing: DsfrSpacings.s2w,
              children: [
                _CarSimulatorOptionView(
                  currentCar: currentCar,
                  option: bestEmissionsOption!,
                  kind: CarSimulatorOptionKind.bestEmission,
                ),
                _CarSimulatorOptionView(currentCar: currentCar, option: bestCostOption!, kind: CarSimulatorOptionKind.bestCost),
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

    return DecoratedBox(
      decoration: const BoxDecoration(color: FnvColors.carteFond, boxShadow: cardShadow),
      child: Padding(
        padding: const EdgeInsets.all(DsfrSpacings.s2w),
        child: SizedBox(
          width: 270,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: DsfrSpacings.s2w,
            children: [
              _KindTagView(kind),
              if (currentCarIsBest)
                Text(switch (kind) {
                  CarSimulatorOptionKind.bestCost => Localisation.vousAvezDejaLOptionLaPlusEconomique,
                  CarSimulatorOptionKind.bestEmission => Localisation.vousAvezDejaLOptionLaPlusEcologique,
                }, style: const DsfrTextStyle.headline5())
              else ...[
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
            ],
          ),
        ),
      ),
    );
  }
}

class _KindTagView extends StatelessWidget {
  const _KindTagView(this.kind);

  final CarSimulatorOptionKind kind;

  @override
  Widget build(final BuildContext context) => switch (kind) {
    CarSimulatorOptionKind.bestCost => const DsfrTag.md(
      label: TextSpan(
        text: Localisation.laPlusEconomique,
        style: DsfrTextStyle.bodyMdMedium(color: DsfrColors.textActionHighYellowTournesol),
      ),
      backgroundColor: DsfrColors.backgroundContrastYellowTournesol,
      foregroundColor: DsfrColors.textActionHighYellowTournesol,
      icon: DsfrIcons.financeMoneyEuroCircleFill,
    ),
    CarSimulatorOptionKind.bestEmission => const DsfrTag.md(
      label: TextSpan(
        text: Localisation.laPlusEcologique,
        style: DsfrTextStyle.bodyMdMedium(color: DsfrColors.textActionHighGreenBourgeon),
      ),
      backgroundColor: DsfrColors.backgroundContrastGreenBourgeon,
      foregroundColor: DsfrColors.textActionHighGreenBourgeon,
      icon: DsfrIcons.othersLeafFill,
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
    final colors =
        diff > 0
            ? (fg: DsfrColors.textDefaultError, bg: DsfrColors.backgroundConstrastError)
            : (fg: DsfrColors.textDefaultSuccess, bg: DsfrColors.backgroundConstrastSuccess);
    final sign = diff > 0 ? '+' : '-';

    return diff == 0
        ? const SizedBox.shrink()
        : DsfrTag.md(
          label: TextSpan(
            text: sign + FnvNumberFormat.formatNumberAfterRounding(diff.abs()),
            style: DsfrTextStyle.bodyMdBold(color: colors.fg),
            children: [TextSpan(text: ' $unit')],
          ),
          backgroundColor: colors.bg,
          foregroundColor: colors.fg,
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
      DecoratedBox(
        decoration: const BoxDecoration(color: FnvColors.carteFond, boxShadow: cardShadow),
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
      text: FnvNumberFormat.formatNumberAfterRounding(num),
      style: const DsfrTextStyle.bodyXlBold(),
      children: [const TextSpan(text: ' '), TextSpan(text: unit, style: const DsfrTextStyle.bodyLg())],
    ),
  );
}

class _ContextInfosView extends StatelessWidget {
  const _ContextInfosView({required this.carInfos});

  final CarInfos carInfos;

  @override
  Widget build(final BuildContext context) => Container(
    padding: const EdgeInsets.only(top: DsfrSpacings.s2w),
    decoration: const ShapeDecoration(shape: Border(top: BorderSide(color: DsfrColors.blueFrance950))),
    width: 270,
    child: Wrap(
      spacing: DsfrSpacings.s1w,
      runSpacing: DsfrSpacings.s1w,
      children: [
        _ContextInfo(label: carInfos.size.label),
        _ContextInfo(label: carInfos.motorisation.label),
        if (carInfos.fuel == null) const SizedBox.shrink() else _ContextInfo(label: carInfos.fuel!.label),
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
