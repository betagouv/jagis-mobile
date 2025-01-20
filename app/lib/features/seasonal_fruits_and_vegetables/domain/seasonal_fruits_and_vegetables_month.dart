import 'package:equatable/equatable.dart';

class SeasonalFruitsAndVegetablesMonth extends Equatable {
  const SeasonalFruitsAndVegetablesMonth({
    required this.code,
    required this.label,
    required this.value,
  });

  final String code;
  final String label;
  final bool value;

  @override
  List<Object?> get props => [code, label, value];
}
