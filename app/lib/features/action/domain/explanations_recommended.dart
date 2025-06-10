import 'package:equatable/equatable.dart';

class ExplanationsRecommended extends Equatable {
  const ExplanationsRecommended(this.isExcluded, this.explanations);

  ExplanationsRecommended.fromJson(final Map<String, dynamic> json)
    : this(
        json['est_exclu'] as bool,
        (json['liste_explications'] as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map((final e) => e['label_explication'] as String)
            .toList(),
      );

  final bool isExcluded;
  final List<String> explanations;

  @override
  List<Object?> get props => [isExcluded, explanations];
}
