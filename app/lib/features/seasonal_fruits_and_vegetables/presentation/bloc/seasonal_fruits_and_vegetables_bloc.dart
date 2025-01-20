import 'package:app/features/seasonal_fruits_and_vegetables/domain/seasonal_fruits_and_vegetables_month.dart';
import 'package:app/features/seasonal_fruits_and_vegetables/infrastructure/seasonal_fruits_and_vegetables_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'seasonal_fruits_and_vegetables_event.dart';
part 'seasonal_fruits_and_vegetables_state.dart';

class SeasonalFruitsAndVegetablesBloc extends Bloc<
    SeasonalFruitsAndVegetablesEvent, SeasonalFruitsAndVegetablesState> {
  SeasonalFruitsAndVegetablesBloc({
    required final SeasonalFruitsAndVegetablesRepository repository,
  }) : super(const SeasonalFruitsAndVegetablesInitial()) {
    on<SeasonalFruitsAndVegetablesFetch>((final event, final emit) async {
      emit(const SeasonalFruitsAndVegetablesLoadInProgress());

      final result = await repository.fetch();

      result.fold(
        (final l) => emit(SeasonalFruitsAndVegetablesLoadFailure(l.toString())),
        (final r) => emit(SeasonalFruitsAndVegetablesLoadSuccess(r)),
      );
    });
  }
}
