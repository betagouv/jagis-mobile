import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

final class WinterMyConsumptionData extends Equatable {
  const WinterMyConsumptionData({
    required this.totalConsumptionEuros,
    required this.possibleSavingsEuros,
    required this.realizedSavingsEuros,
    required this.numberOfAssociatedActions,
    required this.usageDetails,
  });

  factory WinterMyConsumptionData.fromJson(final Map<String, dynamic> json) => WinterMyConsumptionData(
    totalConsumptionEuros: json['consommation_totale_euros'] as int,
    possibleSavingsEuros: json['economies_possibles_euros'] as int,
    realizedSavingsEuros: json['economies_realisees_euros'] as int,
    numberOfAssociatedActions: json['nombre_actions_associees'] as int,
    usageDetails: (json['detail_usages'] as List<dynamic>)
        .map((final e) => WinterUsageDetail.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  final int totalConsumptionEuros;
  final int possibleSavingsEuros;
  final int realizedSavingsEuros;
  final int numberOfAssociatedActions;
  final List<WinterUsageDetail> usageDetails;

  @override
  List<Object> get props => [
    totalConsumptionEuros,
    possibleSavingsEuros,
    realizedSavingsEuros,
    numberOfAssociatedActions,
    usageDetails,
  ];
}

@immutable
final class WinterUsageDetail extends Equatable {
  const WinterUsageDetail({
    required this.price,
    required this.percent,
    required this.type,
    required this.color,
    required this.emoji,
  });

  factory WinterUsageDetail.fromJson(final Map<String, dynamic> json) => WinterUsageDetail(
    price: json['eur'] as int,
    percent: (json['percent'] as num).toDouble(),
    type: json['type'] as String,
    color: json['couleur'] as String,
    emoji: json['emoji'] as String,
  );

  final int price;
  final double percent;
  final String type;
  final String color;
  final String emoji;

  @override
  List<Object> get props => [price, percent, type, color, emoji];
}
