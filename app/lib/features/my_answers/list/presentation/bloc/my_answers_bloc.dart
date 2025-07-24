import 'package:app/core/error/domain/api_erreur.dart';
import 'package:app/features/my_answers/list/infrastructure/my_answers_repository.dart';
import 'package:app/features/my_answers/list/presentation/bloc/my_answers_event.dart';
import 'package:app/features/my_answers/list/presentation/bloc/my_answers_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAnswersBloc extends Bloc<MyAnswersEvent, MyAnswersState> {
  MyAnswersBloc({required final MyAnswersRepository repository}) : super(const MyAnswersInitial()) {
    on<MyAnswersStarted>((final event, final emit) async {
      emit(const MyAnswersLoading());
      final result = await repository.fetchQuestions();
      result.fold(
        (final l) => emit(MyAnswersFailure(errorMessage: l is ApiErreur ? l.message : l.toString())),
        (final r) => emit(MyAnswersSuccess(allQuestions: r)),
      );
    });
    on<MyAnswersRefreshNeed>((final event, final emit) async {
      final aState = state;
      if (aState is MyAnswersSuccess) {
        final result = await repository.fetchQuestions();
        result.fold(
          (final l) => emit(MyAnswersFailure(errorMessage: l is ApiErreur ? l.message : l.toString())),
          (final r) => emit(aState.copyWith(allQuestions: r)),
        );
      }
    });
    on<MyAnswersThemePressed>((final event, final emit) async {
      final aState = state;
      if (aState is MyAnswersSuccess) {
        emit(aState.copyWith(themeSelected: event.theme));
      }
    });
  }
}
