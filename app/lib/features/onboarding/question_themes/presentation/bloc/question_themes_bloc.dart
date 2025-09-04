import 'package:app/core/question/domain/question.dart';
import 'package:app/core/question/infrastructure/question_repository.dart';
import 'package:app/features/onboarding/question_themes/presentation/bloc/question_themes_event.dart';
import 'package:app/features/onboarding/question_themes/presentation/bloc/question_themes_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionThemesBloc extends Bloc<QuestionThemesEvent, QuestionThemesState> {
  QuestionThemesBloc({required final QuestionRepository questionRepository}) : super(const QuestionThemesState(valeur: [])) {
    on<QuestionThemesRecuperationDemandee>((final event, final emit) async {
      final result = await questionRepository.fetchQuestion(_id);
      result.fold((final l) => null, (final question) => emit(state.copyWith(question: question)));
    });
    on<QuestionThemesOntChange>((final event, final emit) => emit(state.copyWith(valeur: event.valeur)));
    on<QuestionThemesMiseAJourDemandee>((final event, final emit) async {
      final question = state.question;
      if (question != null) {
        final answers = question.answers as AnswersMultiple;
        final selectedCodes = answers.responses
            .where((final r) => state.valeur.contains(r.code) || state.valeur.contains(r.label))
            .map((final r) => r.code)
            .toList();
        final changeResponses = answers.changeResponses(selectedCodes);
        final newQuestion = question.copyWith(answers: changeResponses);
        await questionRepository.update(newQuestion.code, newQuestion.answers);
      }
    });
  }

  final _id = 'KYC_preference';
}
