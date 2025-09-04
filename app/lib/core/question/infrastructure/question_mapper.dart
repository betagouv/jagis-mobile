import 'package:app/core/helpers/json_mapper.dart';
import 'package:app/core/infrastructure/theme_type_mapper.dart';
import 'package:app/core/question/domain/question.dart';
import 'package:app/core/question/domain/response.dart';
import 'package:app/core/question/domain/response_choice.dart';
import 'package:app/core/question/domain/response_mosaic.dart';

abstract final class QuestionMapper {
  const QuestionMapper._();

  static Question fromJson(final Map<String, dynamic> json) {
    final type = json['type'] as String;

    return Question(
      code: json['code'] as String,
      theme: ThemeTypeMapper.convert(json['thematique'] as String),
      label: json['question'] as String,
      isMandatory: JsonHelpers.toBool(json, 'is_mandatory'),
      points: (json['points'] as num).toInt(),
      answers: switch (type) {
        'mosaic_boolean' => AnswersMosaicBoolean(
          responses: QuestionMapper._responseMosaics(json['reponse_multiple'] as List<dynamic>),
        ),
        'choix_multiple' => AnswersMultipleChoice(
          responses: QuestionMapper._responseChoices(json['reponse_multiple'] as List<dynamic>),
        ),
        'choix_unique' => AnswersSingleChoice(
          responses: QuestionMapper._responseChoices(json['reponse_multiple'] as List<dynamic>),
        ),
        'libre' => AnswersOpen(response: QuestionMapper._response(json['reponse_unique'] as Map<String, dynamic>)),
        'entier' => AnswersInteger(response: QuestionMapper._response(json['reponse_unique'] as Map<String, dynamic>)),
        'decimal' => AnswersDecimal(response: QuestionMapper._response(json['reponse_unique'] as Map<String, dynamic>)),
        _ => throw ArgumentError('Unknown question type: $type'),
      },
    );
  }

  static List<ResponseChoice> _responseChoices(final List<dynamic> json) => json
      .cast<Map<String, dynamic>>()
      .map((final e) => ResponseChoice(code: e['code'] as String, label: e['label'] as String, isSelected: e['selected'] as bool))
      .toList();

  static Response _response(final Map<String, dynamic> json) => Response(
    value: json.containsKey('value') ? json['value'] as String : '',
    unit: json.containsKey('unite') ? _unit(json['unite'] as Map<String, dynamic>) : null,
  );

  static Unit _unit(final Map<String, dynamic> json) =>
      Unit(abbreviation: json['abreviation'] as String, long: json.containsKey('long') ? json['long'] as String : null);

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
