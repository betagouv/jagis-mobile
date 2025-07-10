import 'package:app/features/aids/core/domain/geographical_scale.dart';
import 'package:app/features/articles/domain/partner.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:equatable/equatable.dart';

class AidSummary extends Equatable {
  const AidSummary({
    required this.id,
    required this.themeType,
    required this.title,
    required this.isFree,
    required this.partner,
    this.scale,
    this.maxAmount,
    this.simulatorUrl,
  });

  final String id;
  final ThemeType themeType;
  final String title;
  final GeographicalScale? scale;
  final int? maxAmount;
  final bool isFree;
  final Partner? partner;
  final String? simulatorUrl;

  bool get hasBikeSimulator => simulatorUrl == '/aides/velo';

  bool get hasSimulator => simulatorUrl != null && simulatorUrl!.isNotEmpty;

  @override
  List<Object?> get props => [id, title, scale, maxAmount, isFree, partner, hasSimulator, themeType, simulatorUrl];
}
