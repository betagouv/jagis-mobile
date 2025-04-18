import 'package:equatable/equatable.dart';

class QuestionCode extends Equatable {
  const QuestionCode(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}
