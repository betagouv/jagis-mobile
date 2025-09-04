import 'package:app/core/question/domain/response.dart';
import 'package:app/core/question/domain/response_choice.dart';
import 'package:app/core/question/domain/response_mosaic.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

sealed class Answers extends Equatable {
  const Answers();

  String responsesDisplay();

  /// Shape answers into the API payload expected by the backend.$
  ///
  /// For unique answers: `[{ 'value': string }]`.
  /// For choice/mosaic answers: `[{ 'code': string, 'selected': bool }, ...]`.
  List<Map<String, dynamic>> toApiPayload();

  bool get isEmpty;
  bool get isNotEmpty => !isEmpty;

  @override
  List<Object> get props => [];
}

sealed class AnswersUnique extends Answers {
  const AnswersUnique({required this.response});

  final Response response;

  AnswersUnique changeResponse(final String value);

  @override
  bool get isEmpty => response.value.trim().isEmpty;

  @override
  List<Object> get props => [response];
}

final class AnswersOpen extends AnswersUnique {
  const AnswersOpen({required super.response});

  @override
  String responsesDisplay() => response.value;

  @override
  AnswersOpen changeResponse(final String value) => AnswersOpen(response: response.copyWith(value: value));

  @override
  List<Map<String, dynamic>> toApiPayload() => [
    {'value': response.value},
  ];
}

final class AnswersInteger extends AnswersUnique {
  const AnswersInteger({required super.response});

  @override
  String responsesDisplay() => response.value;

  @override
  AnswersInteger changeResponse(final String value) => AnswersInteger(response: response.copyWith(value: value));

  @override
  List<Map<String, dynamic>> toApiPayload() => [
    {'value': response.value},
  ];
}

final class AnswersDecimal extends AnswersUnique {
  const AnswersDecimal({required super.response});

  @override
  String responsesDisplay() => response.value;

  @override
  AnswersDecimal changeResponse(final String value) => AnswersDecimal(response: response.copyWith(value: value));

  @override
  List<Map<String, dynamic>> toApiPayload() => [
    {'value': response.value},
  ];
}

sealed class AnswersMultiple extends Answers {
  const AnswersMultiple({required this.responses});

  final List<ResponseChoice> responses;

  AnswersMultiple changeResponses(final List<String> values);

  @override
  bool get isEmpty => !responses.any((final e) => e.isSelected);

  @override
  List<Object> get props => [...super.props, responses];
}

final class AnswersSingleChoice extends AnswersMultiple {
  const AnswersSingleChoice({required super.responses});

  @override
  String responsesDisplay() => responses.firstWhereOrNull((final r) => r.isSelected)?.label ?? '';

  @override
  AnswersSingleChoice changeResponses(final List<String> values) =>
      AnswersSingleChoice(responses: responses.map((final r) => r.copyWith(isSelected: values.contains(r.code))).toList());

  @override
  List<Map<String, dynamic>> toApiPayload() => responses.map((final e) => {'code': e.code, 'selected': e.isSelected}).toList();
}

final class AnswersMultipleChoice extends AnswersMultiple {
  const AnswersMultipleChoice({required super.responses});

  @override
  String responsesDisplay() => responses.where((final r) => r.isSelected).map((final e) => e.label).join(' - ');

  @override
  AnswersMultipleChoice changeResponses(final List<String> values) =>
      AnswersMultipleChoice(responses: responses.map((final r) => r.copyWith(isSelected: values.contains(r.code))).toList());

  @override
  List<Map<String, dynamic>> toApiPayload() => responses.map((final e) => {'code': e.code, 'selected': e.isSelected}).toList();
}

final class AnswersMosaicBoolean extends Answers {
  const AnswersMosaicBoolean({required this.responses});

  final List<ResponseMosaic> responses;

  @override
  String responsesDisplay() => responses.where((final r) => r.isSelected).map((final e) => e.label).join(' - ');

  AnswersMosaicBoolean changeResponses(final List<String> values) =>
      AnswersMosaicBoolean(responses: responses.map((final r) => r.copyWith(isSelected: values.contains(r.code))).toList());

  @override
  bool get isEmpty => !responses.any((final e) => e.isSelected);

  @override
  List<Object> get props => [...super.props, responses];

  @override
  List<Map<String, dynamic>> toApiPayload() => responses.map((final e) => {'code': e.code, 'selected': e.isSelected}).toList();
}

final class Question extends Equatable {
  const Question({
    required this.code,
    required this.theme,
    required this.label,
    required this.isMandatory,
    required this.points,
    required this.answers,
  });

  final String code;
  final ThemeType theme;
  final String label;
  final bool isMandatory;
  final int points;
  final Answers answers;

  bool get isAnswered => answers.isNotEmpty;

  Question copyWith({
    final String? code,
    final ThemeType? theme,
    final String? label,
    final bool? isMandatory,
    final int? points,
    final Answers? answers,
  }) => Question(
    code: code ?? this.code,
    theme: theme ?? this.theme,
    label: label ?? this.label,
    isMandatory: isMandatory ?? this.isMandatory,
    points: points ?? this.points,
    answers: answers ?? this.answers,
  );

  @override
  List<Object> get props => [code, theme, label, isMandatory, points, answers];
}
