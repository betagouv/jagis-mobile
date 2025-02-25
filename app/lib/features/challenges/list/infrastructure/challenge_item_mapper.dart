import 'package:app/core/infrastructure/theme_type_mapper.dart';
import 'package:app/features/challenges/core/domain/challenge_id.dart';
import 'package:app/features/challenges/core/domain/challenge_status.dart';
import 'package:app/features/challenges/list/domain/challenge_item.dart';

abstract final class ChallengeItemMapper {
  const ChallengeItemMapper._();

  static ChallengeItem fromJson(final Map<String, dynamic> json) => ChallengeItem(
    id: ChallengeId(json['id'] as String),
    themeType: ThemeTypeMapper.convert(json['thematique'] as String),
    titre: json['titre'] as String,
    status: _challengeStatusfromJson(json['status'] as String),
  );

  static ChallengeStatus _challengeStatusfromJson(final String json) => switch (json) {
    'todo' => ChallengeStatus.toDo,
    'en_cours' => ChallengeStatus.inProgress,
    'pas_envie' => ChallengeStatus.refused,
    'deja_fait' => ChallengeStatus.alreadyDone,
    'abondon' => ChallengeStatus.abandonned,
    'fait' => ChallengeStatus.done,
    // ignore: no-equal-switch-expression-cases
    _ => ChallengeStatus.toDo,
  };
}
