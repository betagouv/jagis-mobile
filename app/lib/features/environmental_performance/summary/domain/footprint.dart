import 'package:equatable/equatable.dart';

class Footprint extends Equatable {
  Footprint(this.value)
    : tonnesRepresentation = (value / 1000).toStringAsFixed(1).replaceAll('.', ','),
      kilogramsRepresentation = value.toStringAsFixed(0).replaceAll('.', ','),
      percentageOfMaxFootprint = value / _maxCarbonFootprint;

  final double value;
  final String tonnesRepresentation;
  final String kilogramsRepresentation;
  final double percentageOfMaxFootprint;

  /// La valeur maximum pour le bilan carbone.
  static const _maxCarbonFootprint = 12000;

  @override
  List<Object> get props => [value, tonnesRepresentation, kilogramsRepresentation, percentageOfMaxFootprint];
}
