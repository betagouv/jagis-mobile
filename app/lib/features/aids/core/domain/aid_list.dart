import 'package:app/features/aids/core/domain/aid_summary.dart';
import 'package:equatable/equatable.dart';

class AidList extends Equatable {
  const AidList({required this.isCovered, required this.aids});

  final bool isCovered;
  final List<AidSummary> aids;

  @override
  List<Object?> get props => [isCovered, aids];
}
