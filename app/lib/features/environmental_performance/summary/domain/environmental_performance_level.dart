enum EnvironmentalPerformanceLevel { low, medium, high, veryHigh }

class EnvironmentalPerformancePartialLevel {
  const EnvironmentalPerformancePartialLevel({
    required this.performanceOnTransport,
    required this.performanceOnFood,
    required this.performanceOnHousing,
    required this.performanceOnConsumption,
  });

  final EnvironmentalPerformanceLevel? performanceOnTransport;
  final EnvironmentalPerformanceLevel? performanceOnFood;
  final EnvironmentalPerformanceLevel? performanceOnHousing;
  final EnvironmentalPerformanceLevel? performanceOnConsumption;
}
