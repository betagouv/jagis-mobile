import 'package:app/core/address/address.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class MaifEvent extends Equatable {
  const MaifEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class MaifLoadRequested extends MaifEvent {
  const MaifLoadRequested();
}

@immutable
final class MaifAddressChanged extends MaifEvent {
  const MaifAddressChanged(this.value);

  final Address value;

  @override
  List<Object> get props => [value];
}

@immutable
final class MaifNewAddressChosen extends MaifEvent {
  const MaifNewAddressChosen(this.value);

  final Address value;

  @override
  List<Object> get props => [value];
}
