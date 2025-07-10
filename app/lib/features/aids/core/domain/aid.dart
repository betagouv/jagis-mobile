import 'package:app/features/aids/core/domain/aid_summary.dart';

class Aid extends AidSummary {
  const Aid({
    required super.id,
    required super.themeType,
    required super.title,
    required super.maxAmount,
    required super.isFree,
    required super.partner,
    required super.scale,
    required this.content,
    required super.simulatorUrl,
    this.aidUrl,
  });

  final String content;
  final String? aidUrl;

  @override
  List<Object?> get props => [...super.props, themeType, content, aidUrl, simulatorUrl];
}
