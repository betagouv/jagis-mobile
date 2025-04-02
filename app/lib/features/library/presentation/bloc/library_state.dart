import 'package:app/features/library/domain/library.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

enum LibraryStatus { initial, loading, success }

@immutable
final class LibraryState extends Equatable {
  const LibraryState({
    required this.status,
    required this.library,
    required this.inputSearch,
    required this.themes,
    required this.isFavorites,
    required this.areAlreadyRead,
  });

  const LibraryState.empty()
    : this(
        status: LibraryStatus.initial,
        library: const Library(contents: [], filters: []),
        inputSearch: '',
        themes: const [],
        isFavorites: false,
        areAlreadyRead: false,
      );

  final LibraryStatus status;
  final Library library;
  final String inputSearch;
  final List<String> themes;
  final bool isFavorites;
  final bool areAlreadyRead;

  LibraryState copyWith({
    final Library? library,
    final String? inputSearch,
    final List<String>? themes,
    final bool? isFavorites,
    final bool? areAlreadyRead,
    final LibraryStatus? status,
  }) => LibraryState(
    status: status ?? this.status,
    library: library ?? this.library,
    inputSearch: inputSearch ?? this.inputSearch,
    themes: themes ?? this.themes,
    isFavorites: isFavorites ?? this.isFavorites,
    areAlreadyRead: areAlreadyRead ?? this.areAlreadyRead,
  );

  @override
  List<Object?> get props => [status, library, inputSearch, themes, isFavorites, areAlreadyRead];
}
