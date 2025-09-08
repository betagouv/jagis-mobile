import 'package:equatable/equatable.dart';

final class Municipality extends Equatable {
  const Municipality({required this.code, required this.label});

  Municipality.fromJson(final Map<String, dynamic> json) : this(code: json['code'] as String, label: json['label'] as String);

  final String code;
  final String label;

  @override
  List<Object?> get props => [code, label];
}
