import 'package:app/core/address/address.dart';
import 'package:app/features/services/maif/domain/maif_risk.dart';
import 'package:app/features/services/maif/infrastructure/maif_repository.dart';
import 'package:collection/collection.dart';
import 'package:fpdart/fpdart.dart';

class FetchRiskInfoForAddress {
  const FetchRiskInfoForAddress(this._port);

  final MaifRepository _port;

  Future<Either<Exception, List<MaifRisk>>> run(final Address address) async {
    final result = await _port.fetchScore(address.latitude!, address.longitude!);

    return result.fold(
      Left.new,
      (final r) async => Right(
        r
            .whereNot((final element) => element.level == RiskLevel.unknown)
            .whereNot((final element) => element.level == RiskLevel.veryLow)
            .sorted((final a, final b) => b.level.index.compareTo(a.level.index))
            .toList(),
      ),
    );
  }
}
