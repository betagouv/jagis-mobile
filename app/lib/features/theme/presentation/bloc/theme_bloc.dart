import 'package:app/features/theme/core/infrastructure/theme_repository.dart';
import 'package:app/features/theme/presentation/bloc/theme_event.dart';
import 'package:app/features/theme/presentation/bloc/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({required final ThemeRepository themeRepository}) : super(const ThemeInitial()) {
    on<ThemeFetchRequested>((final event, final emit) async {
      emit(const ThemeLoadInProgress());
      final themeType = event.themeType;
      final themeDataResult = await themeRepository.fetchTheme(themeType: themeType);
      final missionsResult = await themeRepository.getMissions(themeType);
      final servicesResult = await themeRepository.getServices(themeType);
      themeDataResult.fold(
        (final l) => emit(ThemeLoadFailure(errorMessage: l.toString())),
        (final theme) => missionsResult.fold(
          (final l) => emit(ThemeLoadFailure(errorMessage: l.toString())),
          (final missions) => servicesResult.fold(
            (final l) => emit(ThemeLoadFailure(errorMessage: l.toString())),
            (final services) => emit(ThemeLoadSuccess(theme: theme, missions: missions, services: services)),
          ),
        ),
      );
    });
  }
}
