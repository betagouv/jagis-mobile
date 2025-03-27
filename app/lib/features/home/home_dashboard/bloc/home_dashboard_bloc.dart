import 'package:app/features/home/home_dashboard/bloc/home_dashboard_event.dart';
import 'package:app/features/home/home_dashboard/bloc/home_dashboard_state.dart';
import 'package:app/features/home/home_dashboard/infrastructure/home_dashboard_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeDashboardBloc extends Bloc<HomeDashboardEvent, HomeDashboardState> {
  HomeDashboardBloc({required final HomeDashboardRepository repository}) : super(const HomeDashboardState.init()) {
    on<HomeDashboardLoadRequested>((final event, final emit) async {
      emit(const HomeDashboardState.loading());

      final result = await repository.fetch();

      result.fold((final l) => emit(HomeDashboardState.failure(l.toString())), (final r) {
        emit(HomeDashboardState.success(r));
      });
    });
  }
}
