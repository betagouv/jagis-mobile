import 'package:app/features/home/home_dashboard/bloc/home_dashboard_event.dart';
import 'package:app/features/home/home_dashboard/bloc/home_dashboard_state.dart';
import 'package:app/features/home/home_dashboard/infrastructure/home_dashboard_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeDashboardBloc extends Bloc<HomeDashboardEvent, HomeDashboardState> {
  HomeDashboardBloc({required final HomeDashboardRepository repository}) : super(const HomeDashboardInitial()) {
    on<HomeDashboardLoadRequested>((final event, final emit) async {
      emit(const HomeDashboardLoadInProgress());

      final result = await repository.fetch();

      result.fold((final l) => emit(HomeDashboardLoadFailure(errorMessage: l.toString())), (final r) {
        emit(
          HomeDashboardLoadSuccess(
            nbActionsDone: r.nbActionsDoneUser,
            bilanCarbonePercentageCompletion: r.environmentalImpactPercentageCompletion,
          ),
        );
      });
    });
  }
}
