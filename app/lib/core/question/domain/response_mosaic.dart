import 'package:app/core/question/domain/response_choice.dart';

class ResponseMosaic extends ResponseChoice {
  const ResponseMosaic({required super.code, required super.label, required this.emoji, required super.isSelected});

  final String? emoji;

  @override
  ResponseMosaic copyWith({
    final String? code,
    final String? label,
    final String? emoji,
    final String? imageUrl,
    final bool? isSelected,
  }) => ResponseMosaic(
    code: code ?? this.code,
    label: label ?? this.label,
    emoji: emoji ?? this.emoji,
    isSelected: isSelected ?? this.isSelected,
  );

  @override
  List<Object?> get props => [...super.props, emoji];
}
