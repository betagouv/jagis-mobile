import 'package:app/features/action/domain/action.dart';
import 'package:app/features/quiz/presentation/widgets/quiz_part.dart';
import 'package:flutter/material.dart';

class ActionQuizView extends StatelessWidget {
  const ActionQuizView({super.key, required this.action});

  final ActionQuiz action;

  @override
  Widget build(final BuildContext context) =>
      QuizPart(id: action.id, name: action.emojiTitle, quizzes: action.quizzes, congratulatoryText: action.congratulatoryText);
}
