import 'package:app/features/ranking/domain/user_rank.dart';

class UserRankDto extends UserRank {
  const UserRankDto({required super.points, required super.rank, required super.pseudo, required super.id});

  factory UserRankDto.fromJson(final Map<String, dynamic> json) => UserRankDto(
    points: json['points'] as int,
    rank: json['rank'] as int,
    pseudo: json['pseudo'] as String?,
    id: json['id'] as String,
  );
}
