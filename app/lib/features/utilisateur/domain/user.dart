import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.pseudonym,
    required this.isUserFranceConnect,
    required this.isIntegrationCompleted,
    required this.shouldShowResetPopup,
  });

  final String pseudonym;
  final bool isUserFranceConnect;
  final bool isIntegrationCompleted;
  final bool shouldShowResetPopup;

  @override
  List<Object?> get props => [pseudonym, isUserFranceConnect, isIntegrationCompleted, shouldShowResetPopup];
}
