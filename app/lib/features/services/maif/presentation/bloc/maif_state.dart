import 'package:app/core/address/address.dart';
import 'package:app/features/services/maif/domain/maif_risk.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class MaifState extends Equatable {
  const MaifState();

  @override
  List<Object?> get props => [];
}

@immutable
final class MaifInitial extends MaifState {
  const MaifInitial();
}

@immutable
final class MaifLoadInProgress extends MaifState {
  const MaifLoadInProgress();
}

@immutable
final class MaifLoadSuccess extends MaifState {
  const MaifLoadSuccess({
    required this.userAddress,
    required this.searchAddress,
    required this.risks,
    required this.numberOfCatNat,
    required this.droughtPercentage,
    required this.floodPercentage,
    required this.isLoading,
  });

  final Address userAddress;
  final Address searchAddress;
  final List<MaifRisk> risks;
  final int numberOfCatNat;
  final int droughtPercentage;
  final int floodPercentage;
  final bool isLoading;

  bool get isNewAddress => userAddress != searchAddress;

  MaifLoadSuccess copyWith({
    final Address? userAddress,
    final Address? searchAddress,
    final List<MaifRisk>? risks,
    final int? numberOfCatNat,
    final int? droughtPercentage,
    final int? floodPercentage,
    final bool? isLoading,
  }) => MaifLoadSuccess(
    userAddress: userAddress ?? this.userAddress,
    searchAddress: searchAddress ?? this.searchAddress,
    risks: risks ?? this.risks,
    numberOfCatNat: numberOfCatNat ?? this.numberOfCatNat,
    droughtPercentage: droughtPercentage ?? this.droughtPercentage,
    floodPercentage: floodPercentage ?? this.floodPercentage,
    isLoading: isLoading ?? this.isLoading,
  );

  @override
  List<Object?> get props => [userAddress, searchAddress, risks, numberOfCatNat, droughtPercentage, floodPercentage, isLoading];
}

@immutable
final class MaifLoadFailure extends MaifState {
  const MaifLoadFailure();
}
