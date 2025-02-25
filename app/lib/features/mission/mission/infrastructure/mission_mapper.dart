import 'package:app/core/infrastructure/theme_type_mapper.dart';
import 'package:app/features/mission/mission/domain/content_id.dart';
import 'package:app/features/mission/mission/domain/mission.dart';
import 'package:app/features/mission/mission/domain/mission_article.dart';
import 'package:app/features/mission/mission/domain/mission_code.dart';
import 'package:app/features/mission/mission/domain/mission_kyc.dart';
import 'package:app/features/mission/mission/domain/mission_objectif.dart';
import 'package:app/features/mission/mission/domain/mission_quiz.dart';

abstract final class MissionMapper {
  const MissionMapper._();

  static Mission fromJson(final Map<String, dynamic> json) {
    final objectifs = <MissionObjectif>[];

    final objectifsList = json['objectifs'] as List<dynamic>;
    for (final item in objectifsList) {
      final o = item as Map<String, dynamic>;
      final type = o['type'] as String?;
      switch (type) {
        case 'kyc':
          objectifs.add(_fromJsonMissionKyc(o));
        case 'quizz':
          objectifs.add(_fromJsonMissionQuiz(o));
        case 'article':
          objectifs.add(_fromJsonMissionArticle(o));
      }
    }

    return Mission(
      code: MissionCode(json['code'] as String),
      themeType: ThemeTypeMapper.convert(json['thematique'] as String),
      title: json['titre'] as String,
      imageUrl: json['image_url'] as String,
      description: json['introduction'] as String?,
      objectifs: objectifs,
      canBeCompleted: json['terminable'] as bool,
      isCompleted: json['done_at'] != null,
    );
  }

  static MissionKyc _fromJsonMissionKyc(final Map<String, dynamic> json) => MissionKyc(
    contentId: ContentId(json['content_id'] as String),
    titre: json['titre'] as String,
    estFait: json['done'] as bool,
  );

  static MissionQuiz _fromJsonMissionQuiz(final Map<String, dynamic> json) => MissionQuiz(
    contentId: ContentId(json['content_id'] as String),
    titre: json['titre'] as String,
    estFait: json['done'] as bool,
  );

  static MissionArticle _fromJsonMissionArticle(final Map<String, dynamic> json) => MissionArticle(
    contentId: ContentId(json['content_id'] as String),
    titre: json['titre'] as String,
    estFait: json['done'] as bool,
  );
}
