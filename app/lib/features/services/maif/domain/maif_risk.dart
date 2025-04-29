import 'package:equatable/equatable.dart';

final class MaifRisk extends Equatable {
  const MaifRisk({required this.title, required this.level, required this.type});

  final String title;
  final RiskLevel level;
  final RiskType type;

  @override
  List<Object?> get props => [title, level, type];
}

enum RiskLevel { veryLow, low, medium, high, veryHigh }

enum RiskType {
  /// Séisme
  earthquake,

  /// Sécheresse
  drought,

  /// Inondation
  flood,

  /// Submersion
  flooding,

  /// Tempête
  storm,

  /// Argile
  clay,

  /// Radon
  radon,
}
