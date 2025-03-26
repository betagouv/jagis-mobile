import 'package:app/features/actions/infrastructure/actions_repository.dart';
import 'package:app/features/environmental_performance/summary/domain/environmental_performance_data.dart';
import 'package:app/features/environmental_performance/summary/infrastructure/environmental_performance_summary_repository.dart';
import 'package:app/features/home/home_dashboard/bloc/home_dashboard_event.dart';
import 'package:app/features/home/home_dashboard/bloc/home_dashboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class HomeDashboardBloc extends Bloc<HomeDashboardEvent, HomeDashboardState> {
  HomeDashboardBloc({
    required final ActionsRepository actionRepository,
    required final EnvironmentalPerformanceSummaryRepository environmentalPerformanceSummaryRepository,
  }) : super(const HomeDashboardInitial()) {
    on<HomeDashboardLoadRequested>((final event, final emit) async {
      emit(const HomeDashboardLoadInProgress());
      final actionsFetchResult = await actionRepository.fetch(onlyDone: true);
      if (actionsFetchResult.isLeft()) {
        emit(HomeDashboardLoadFailure(errorMessage: actionsFetchResult.getLeft().toString()));
        return;
      }

      final nbActionsDone = actionsFetchResult.getRight().map((final catalog) => catalog.actions.length).getOrElse(() => 0);
      final bilanCarboneFetchResult = await environmentalPerformanceSummaryRepository.fetch();

      bilanCarboneFetchResult.fold((final l) => emit(HomeDashboardLoadFailure(errorMessage: l.toString())), (final r) {
        // final bilanCarbonPercentageCompletion = (r is EnvironmentalPerformancePartial) ? r.percentageCompletion : 100;
        emit(
          HomeDashboardLoadSuccess(
            nbActionsDone: nbActionsDone,
            bilanCarbonePercentageCompletion: 67,
            // bilanCarbonPercentageCompletion,
          ),
        );
      });
    });
  }
}
