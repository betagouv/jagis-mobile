import 'package:app/features/faq/domain/faq.dart';

abstract final class FAQItemMapper {
  static FAQItem fromJson(final Map<String, dynamic> json) =>
      FAQItem(question: json['question'] as String, answer: json['reponse'] as String);
}
