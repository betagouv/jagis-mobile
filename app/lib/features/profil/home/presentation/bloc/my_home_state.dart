import 'package:app/core/address/address.dart';
import 'package:app/features/communes/infrastructure/communes_repository.dart';
import 'package:app/features/profil/home/domain/home.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class MyHomeState extends Equatable {
  const MyHomeState();

  @override
  List<Object?> get props => [];
}

@immutable
final class MyHomeLoadInProgress extends MyHomeState {
  const MyHomeLoadInProgress();
}

@immutable
final class MyHomeLoadSuccess extends MyHomeState {
  const MyHomeLoadSuccess({required this.logement, required this.municipalities});

  final Home logement;
  final List<Commune> municipalities;

  MyHomeLoadSuccess copyWith({final Home? logement, final List<Commune>? municipalities}) =>
      MyHomeLoadSuccess(logement: logement ?? this.logement, municipalities: municipalities ?? this.municipalities);

  MyHomeLoadSuccess updateAddress(final Address address) => MyHomeLoadSuccess(
    logement: logement.copyWith(address: address),
    municipalities: municipalities,
  );

  @override
  List<Object?> get props => [municipalities, logement];
}

@immutable
final class MyHomeLoadFailure extends MyHomeState {
  const MyHomeLoadFailure();
}
