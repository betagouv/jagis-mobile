class QuizScore {
  const QuizScore({required this.correctAnswerCount, required this.totalQuestionsCount});

  factory QuizScore.fromJson(final Map<String, dynamic> json) =>
      QuizScore(correctAnswerCount: json['nombre_bonnes_reponses'] as int, totalQuestionsCount: json['nombre_quizz_done'] as int);

  final int correctAnswerCount;

  final int totalQuestionsCount;
}
