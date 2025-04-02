import 'package:app/features/library/infrastructure/library_repository.dart';
import 'package:app/features/library/presentation/bloc/library_event.dart';
import 'package:app/features/library/presentation/bloc/library_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  LibraryBloc(final LibraryRepository repository) : super(const LibraryState.empty()) {
    on<LibraryFetchRequested>((final event, final emit) async {
      emit(state.copyWith(status: LibraryStatus.loading));
      final result = await repository.fetch(themes: null, title: null, isFavorites: null, areAlreadyRead: null);
      result.fold((final l) => null, (final r) => emit(state.copyWith(library: r, status: LibraryStatus.success)));
    });
    on<LibrarySearchEntered>((final event, final emit) async {
      final recherche = event.value;
      final result = await repository.fetch(
        themes: state.themes,
        title: recherche,
        isFavorites: state.isFavorites,
        areAlreadyRead: state.areAlreadyRead,
      );
      result.fold(
        (final l) => null,
        (final r) => emit(state.copyWith(library: r, inputSearch: recherche, status: LibraryStatus.success)),
      );
    });
    on<LibraryThemeSelected>((final event, final emit) async {
      final thematiques = state.themes.toList();
      thematiques.contains(event.value) ? thematiques.remove(event.value) : thematiques.add(event.value);
      final result = await repository.fetch(
        themes: thematiques,
        title: state.inputSearch,
        isFavorites: state.isFavorites,
        areAlreadyRead: state.areAlreadyRead,
      );
      result.fold(
        (final l) => null,
        (final r) => emit(state.copyWith(library: r, themes: thematiques, status: LibraryStatus.success)),
      );
    });
    on<LibraryFavoritesSelected>((final event, final emit) async {
      final result = await repository.fetch(
        themes: state.themes,
        title: state.inputSearch,
        isFavorites: event.value,
        areAlreadyRead: state.areAlreadyRead,
      );
      result.fold(
        (final l) => null,
        (final r) => emit(state.copyWith(library: r, isFavorites: event.value, status: LibraryStatus.success)),
      );
    });
    on<LibraryAlreadyReadSelected>((final event, final emit) async {
      final result = await repository.fetch(
        themes: state.themes,
        title: state.inputSearch,
        isFavorites: state.isFavorites,
        areAlreadyRead: event.value,
      );
      result.fold(
        (final l) => null,
        (final r) => emit(state.copyWith(library: r, areAlreadyRead: event.value, status: LibraryStatus.success)),
      );
    });
  }
}
