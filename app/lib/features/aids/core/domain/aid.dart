import 'package:app/features/aids/core/domain/aid_summary.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';

class Aid extends AidSummary {
  const Aid({
    required super.id,
    required super.title,
    required super.maxAmount,
    required super.isFree,
    required super.partner,
    required this.themeType,
    super.scale,
    required this.content,
    this.simulatorUrl,
  });

  final ThemeType themeType;
  final String content;
  final String? simulatorUrl;
  bool get hasBikeSimulator => simulatorUrl == '/aides/velo';

  @override
  bool get hasSimulator => simulatorUrl != null && simulatorUrl!.isNotEmpty;

  @override
  List<Object?> get props => [...super.props, themeType, simulatorUrl, content];
}
