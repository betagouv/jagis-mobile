import 'package:app/core/infrastructure/theme_type_mapper.dart';
import 'package:app/core/question/domain/question.dart';
import 'package:app/core/question/domain/question_code.dart';
import 'package:app/core/question/domain/response.dart';
import 'package:app/core/question/domain/response_choice.dart';
import 'package:app/core/question/domain/response_mosaic.dart';

abstract final class QuestionMapper {
  const QuestionMapper._();

  static Question fromJson(final Map<String, dynamic> json) {
    final type = json['type'] as String;

    return switch (type) {
      'choix_multiple' => _questionMultipleChoice(json),
      'choix_unique' => _questionSingleChoice(json),
      'libre' => _questionOpen(json),
      'mosaic_boolean' => _questionMosaicBoolean(json),
      'entier' => _questionInteger(json),
      'decimal' => _questionDecimal(json),
      _ => throw ArgumentError('Unknown question type: $type'),
    };
  }

  static QuestionMultipleChoice _questionMultipleChoice(final Map<String, dynamic> json) => QuestionMultipleChoice(
    code: QuestionCode(json['code'] as String),
    theme: ThemeTypeMapper.convert(json['thematique'] as String),
    label: json['question'] as String,
    isAnswered: json['is_answered'] as bool,
    responses: _responseChoices(json['reponse_multiple'] as List<dynamic>),
    points: (json['points'] as num).toInt(),
  );

  static QuestionSingleChoice _questionSingleChoice(final Map<String, dynamic> json) => QuestionSingleChoice(
    code: QuestionCode(json['code'] as String),
    theme: ThemeTypeMapper.convert(json['thematique'] as String),
    label: json['question'] as String,
    isAnswered: json['is_answered'] as bool,
    responses: _responseChoices(json['reponse_multiple'] as List<dynamic>),
    points: (json['points'] as num).toInt(),
  );

  static List<ResponseChoice> _responseChoices(final List<dynamic> json) => json
      .cast<Map<String, dynamic>>()
      .map((final e) => ResponseChoice(code: e['code'] as String, label: e['label'] as String, isSelected: e['selected'] as bool))
      .toList();

  static QuestionOpen _questionOpen(final Map<String, dynamic> json) => QuestionOpen(
    code: QuestionCode(json['code'] as String),
    theme: ThemeTypeMapper.convert(json['thematique'] as String),
    label: json['question'] as String,
    isAnswered: json['is_answered'] as bool,
    response: _response(json['reponse_unique'] as Map<String, dynamic>),
    points: (json['points'] as num).toInt(),
  );

  static QuestionInteger _questionInteger(final Map<String, dynamic> json) => QuestionInteger(
    code: QuestionCode(json['code'] as String),
    theme: ThemeTypeMapper.convert(json['thematique'] as String),
    label: json['question'] as String,
    isAnswered: json['is_answered'] as bool,
    response: _response(json['reponse_unique'] as Map<String, dynamic>),
    points: (json['points'] as num).toInt(),
  );

  static QuestionDecimal _questionDecimal(final Map<String, dynamic> json) => QuestionDecimal(
    code: QuestionCode(json['code'] as String),
    theme: ThemeTypeMapper.convert(json['thematique'] as String),
    label: json['question'] as String,
    isAnswered: json['is_answered'] as bool,
    response: _response(json['reponse_unique'] as Map<String, dynamic>),
    points: (json['points'] as num).toInt(),
  );

  static Response _response(final Map<String, dynamic> json) => Response(
    value: json.containsKey('value') ? json['value'] as String : '',
    unit: json.containsKey('unite') ? _unit(json['unite'] as Map<String, dynamic>) : null,
  );

  static Unit _unit(final Map<String, dynamic> json) =>
      Unit(abbreviation: json['abreviation'] as String, long: json.containsKey('long') ? json['long'] as String : null);

  static QuestionMosaicBoolean _questionMosaicBoolean(final Map<String, dynamic> json) => QuestionMosaicBoolean(
    code: QuestionCode(json['code'] as String),
    theme: ThemeTypeMapper.convert(json['thematique'] as String),
    label: json['question'] as String,
    isAnswered: json['is_answered'] as bool,
    responses: _responseMosaics(json['reponse_multiple'] as List<dynamic>),
    points: (json['points'] as num).toInt(),
  );

  static List<ResponseMosaic> _responseMosaics(final List<dynamic> json) => json
      .cast<Map<String, dynamic>>()
      .map(
        (final e) => ResponseMosaic(
          code: e['code'] as String,
          label: e['label'] as String,
          emoji: e['emoji'] as String?,
          isSelected: e['selected'] as bool,
        ),
      )
      .toList();
}
