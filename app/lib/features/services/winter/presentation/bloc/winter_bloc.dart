import 'package:app/features/services/winter/infrastructure/winter_repository.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_event.dart';
import 'package:app/features/services/winter/presentation/bloc/winter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WinterBloc extends Bloc<WinterEvent, WinterState> {
  WinterBloc(final WinterRepository repository) : super(const WinterInitial()) {
    on<WinterStarted>((final event, final emit) {
      emit(const WinterLoading());
      // Récupérer l'adresse de l'utilisateur
      emit(
        const WinterForm(
          address: '',
          lastName: '',
          isDeclarationChecked: false,
          connectionStatus: WinterConnectionStatus.unknown,
        ),
      );
    });
    on<WinterAddressChanged>((final event, final emit) {
      if (state is WinterForm) {
        final currentState = state as WinterForm;
        emit(currentState.copyWith(address: event.value));
      }
    });
    on<WinterLastNameChanged>((final event, final emit) {
      if (state is WinterForm) {
        final currentState = state as WinterForm;
        emit(currentState.copyWith(lastName: event.value));
      }
    });
    on<WinterDeclarationChanged>((final event, final emit) {
      if (state is WinterForm) {
        final currentState = state as WinterForm;
        emit(currentState.copyWith(isDeclarationChecked: event.value));
      }
    });
    on<WinterSubmit>((final event, final emit) async {
      final currentState = state;

      if (currentState is! WinterForm || currentState.isFormInvalid) {
        return;
      }

      final verificationResult = await repository.verify(currentState.address, currentState.lastName);
      final connectionStatus = verificationResult.fold(
        (final l) => WinterConnectionStatus.failed,
        (final r) => WinterConnectionStatus.established,
      );
      emit(currentState.copyWith(connectionStatus: connectionStatus));
    });
  }
}
