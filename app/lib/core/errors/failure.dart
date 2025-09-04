import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  const Failure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

final class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

final class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message);
}
