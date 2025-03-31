import 'package:equatable/equatable.dart';

class FAQItem extends Equatable {
  const FAQItem({required this.question, required this.answer});

  final String question;
  final String answer;

  @override
  List<Object?> get props => [question, answer];
}
