import 'package:app/core/question/domain/question.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta/meta.dart';

@immutable
sealed class MyAnswersState extends Equatable {
  const MyAnswersState();

  @override
  List<Object?> get props => [];
}

@immutable
final class MyAnswersInitial extends MyAnswersState {
  const MyAnswersInitial();
}

@immutable
final class MyAnswersLoading extends MyAnswersState {
  const MyAnswersLoading();
}

@immutable
final class MyAnswersSuccess extends MyAnswersState {
  const MyAnswersSuccess({required this.allQuestions, this.themeSelected = const None()});

  final List<Question> allQuestions;
  final Option<ThemeType> themeSelected;

  List<Question> get questionsFiltered =>
      themeSelected.fold(() => allQuestions, (final s) => allQuestions.where((final question) => question.theme == s).toList());

  MyAnswersSuccess copyWith({final List<Question>? allQuestions, final Option<ThemeType>? themeSelected}) =>
      MyAnswersSuccess(allQuestions: allQuestions ?? this.allQuestions, themeSelected: themeSelected ?? this.themeSelected);

  @override
  List<Object?> get props => [allQuestions, themeSelected];
}

@immutable
final class MyAnswersFailure extends MyAnswersState {
  const MyAnswersFailure({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
