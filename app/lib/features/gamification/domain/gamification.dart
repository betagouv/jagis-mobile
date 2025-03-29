import 'package:equatable/equatable.dart';

class Gamification extends Equatable {
  const Gamification({required this.points, required this.badges});

  final int points;
  final int badges;

  @override
  List<Object?> get props => [points, badges];
}
