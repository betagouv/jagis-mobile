import 'package:equatable/equatable.dart';

class UserRank extends Equatable {
  const UserRank({required this.points, required this.rank, required this.pseudo, required this.id});

  final int points;
  final int rank;
  final String? pseudo;
  final String id;

  @override
  List<Object?> get props => [points, rank, pseudo, id];
}
