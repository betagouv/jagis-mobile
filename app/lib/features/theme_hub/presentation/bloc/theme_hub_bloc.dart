import 'package:app/features/theme_hub/domain/theme_hub_model.dart';
import 'package:app/features/theme_hub/infrastructure/theme_hub_repository.dart';
import 'package:app/features/theme_hub/presentation/bloc/theme_hub_event.dart';
import 'package:app/features/theme_hub/presentation/bloc/theme_hub_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeHubBloc extends Bloc<ThemeHubEvent, ThemeHubState> {
  ThemeHubBloc({required final ThemeHubRepository repository}) : super(const ThemeHubInitial()) {
    on<ThemeHubLoadRequested>((final event, final emit) async {
      emit(const ThemeHubLoadInProgress());
      final result = await repository.fetch();
      final updatedState = result.fold((final l) => const ThemeHubLoadFailure(), _success);
      emit(updatedState);
    });
  }

  ThemeHubLoadSuccess _success(final ThemeHubModel model) => ThemeHubLoadSuccess(model: model);
}
