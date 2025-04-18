import 'package:app/core/question/infrastructure/question_mapper.dart';
import 'package:app/core/question_flow/domain/current_question.dart';

abstract final class CurrentQuestionMapper {
  const CurrentQuestionMapper._();

  static CurrentQuestion fromJson(final Map<String, dynamic> json) => CurrentQuestion(
    question: QuestionMapper.fromJson(json['question_courante'] as Map<String, dynamic>),
    currentPosition: (json['position_courante'] as num).toInt(),
    totalNumberOfQuestions: (json['nombre_total_questions_effectives'] as num).toInt(),
  );
}
