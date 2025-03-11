import 'package:app/features/aids/core/domain/aid.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class AidState extends Equatable {
  const AidState();
}

@immutable
final class AidStateLoading extends AidState {
  const AidStateLoading();

  @override
  List<Object> get props => [];
}

@immutable
final class AidStateSuccess extends AidState {
  const AidStateSuccess(this.aid);

  final Aid aid;

  @override
  List<Object> get props => [aid];
}

@immutable
final class AidStateErrorLoading extends AidState {
  const AidStateErrorLoading(this.exn);

  final Exception exn;

  @override
  List<Object> get props => [exn];
}
