import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({required this.pseudonym, this.isIntegrationCompleted});

  final String pseudonym;
  final bool? isIntegrationCompleted;

  @override
  List<Object?> get props => [pseudonym, isIntegrationCompleted];
}
