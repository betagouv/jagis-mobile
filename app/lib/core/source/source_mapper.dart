import 'package:app/core/source/source.dart';

abstract final class SourceMapper {
  const SourceMapper._();

  static Source fromJson(final Map<String, dynamic> json) => Source(label: json['label'] as String, url: json['url'] as String);
}
