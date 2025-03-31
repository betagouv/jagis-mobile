import 'package:app/features/utilisateur/infrastructure/user_repository.dart';
import 'package:app/features/utilisateur/presentation/bloc/user_event.dart';
import 'package:app/features/utilisateur/presentation/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// FIXME(lsaudon): Refacto le bloc pour utiliser un state initial
class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required final UserRepository repository}) : super(const UserState()) {
    on<UserFetchRequested>((final event, final emit) async {
      final result = await repository.fetch();
      result.fold((final l) {}, (final r) => emit(UserState(user: r)));
    });
  }
}
