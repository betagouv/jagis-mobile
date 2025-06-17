import 'package:equatable/equatable.dart';

class UserRank extends Equatable {
  UserRank.fromJson(final Map<String, dynamic> json)
    : points = json['points'] as int,
      rank = json['rank'] as int,
      pseudo = json['pseudo'] as String?,
      id = json['id'] as String;

  final int points;
  final int rank;
  final String? pseudo;

  final String id;

  @override
  List<Object?> get props => [points, rank, pseudo, id];
}
