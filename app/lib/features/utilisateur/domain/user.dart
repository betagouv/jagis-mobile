import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({required this.pseudonym, required this.isIntegrationCompleted, required this.shouldShowResetPopup});

  final String pseudonym;
  final bool? isIntegrationCompleted;
  final bool? shouldShowResetPopup;

  @override
  List<Object?> get props => [pseudonym, isIntegrationCompleted, shouldShowResetPopup];
}
