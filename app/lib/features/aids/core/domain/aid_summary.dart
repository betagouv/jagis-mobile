import 'package:app/features/aids/core/domain/geographical_scale.dart';
import 'package:app/features/articles/domain/partner.dart';
import 'package:equatable/equatable.dart';

class AidSummary extends Equatable {
  const AidSummary({
    required this.id,
    required this.title,
    required this.isFree,
    required this.partner,
    this.scale,
    this.maxAmount,
    this.hasSimulator = false,
  });

  final String id;
  final String title;
  final GeographicalScale? scale;
  final int? maxAmount;
  final bool isFree;
  final Partner? partner;
  final bool hasSimulator;

  @override
  List<Object?> get props => [id, title, scale, maxAmount, isFree, partner, hasSimulator];
}
