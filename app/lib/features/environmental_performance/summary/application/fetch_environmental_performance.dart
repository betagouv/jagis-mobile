import 'package:app/features/environmental_performance/summary/domain/environmental_performance_data.dart';
import 'package:app/features/environmental_performance/summary/infrastructure/environmental_performance_summary_repository.dart';
import 'package:fpdart/fpdart.dart';

class FetchEnvironmentalPerformance {
  const FetchEnvironmentalPerformance(this._port);

  final EnvironmentalPerformanceSummaryRepository _port;

  Future<Either<Exception, EnvironmentalPerformanceData>> run() async {
    final result = await _port.fetch();

    return result.fold(Left.new, (final r) async => Right(r));
  }
}
