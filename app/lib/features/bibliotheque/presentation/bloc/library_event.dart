import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class LibraryEvent extends Equatable {
  const LibraryEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class LibraryFetchRequested extends LibraryEvent {
  const LibraryFetchRequested();
}

@immutable
final class LibrarySearchEntered extends LibraryEvent {
  const LibrarySearchEntered(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

@immutable
final class LibraryThemeSelected extends LibraryEvent {
  const LibraryThemeSelected(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

@immutable
final class LibraryFavoritesSelected extends LibraryEvent {
  const LibraryFavoritesSelected(this.value);

  final bool value;

  @override
  List<Object> get props => [value];
}

@immutable
final class LibraryAlreadyReadSelected extends LibraryEvent {
  const LibraryAlreadyReadSelected(this.value);

  final bool value;

  @override
  List<Object> get props => [value];
}
