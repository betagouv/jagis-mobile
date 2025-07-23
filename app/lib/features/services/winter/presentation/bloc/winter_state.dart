import 'package:app/core/address/address.dart';
import 'package:app/features/services/winter/domain/winter_my_consumption_data.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

enum RegistrationType { address, prm }

@immutable
sealed class WinterState extends Equatable {
  const WinterState();

  @override
  List<Object?> get props => [];
}

@immutable
final class WinterLoading extends WinterState {
  const WinterLoading();
}

@immutable
final class WinterInitial extends WinterState {
  const WinterInitial();
}

enum WinterConnectionStatus { unknown, loading, established, failed }

@immutable
final class WinterForm extends WinterState {
  const WinterForm({
    required this.formType,
    required this.address,
    required this.isAddressCompleted,
    required this.lastName,
    required this.prmNumber,
    required this.isDeclarationChecked,
    required this.connectionStatus,
  });

  final RegistrationType formType;
  final Address? address;
  final bool isAddressCompleted;
  final String lastName;
  final String prmNumber;
  final bool isDeclarationChecked;
  final WinterConnectionStatus connectionStatus;

  bool get isFormValid => switch (formType) {
    RegistrationType.address => address != null && address!.isFull && lastName.isNotEmpty && isDeclarationChecked,
    RegistrationType.prm => prmNumber.isNotEmpty && isDeclarationChecked,
  };
  bool get isFormInvalid => !isFormValid;

  WinterForm copyWith({
    final RegistrationType? formType,
    final Address? address,
    final bool? isAddressCompleted,
    final String? lastName,
    final String? prmNumber,
    final bool? isDeclarationChecked,
    final WinterConnectionStatus? connectionStatus,
  }) => WinterForm(
    formType: formType ?? this.formType,
    address: address ?? this.address,
    isAddressCompleted: isAddressCompleted ?? this.isAddressCompleted,
    lastName: lastName ?? this.lastName,
    prmNumber: prmNumber ?? this.prmNumber,
    isDeclarationChecked: isDeclarationChecked ?? this.isDeclarationChecked,
    connectionStatus: connectionStatus ?? this.connectionStatus,
  );

  @override
  List<Object?> get props => [formType, address, isAddressCompleted, lastName, prmNumber, isDeclarationChecked, connectionStatus];
}

@immutable
final class WinterQuestionsState extends WinterState {
  const WinterQuestionsState();
}

@immutable
final class WinterMyConsumption extends WinterState {
  const WinterMyConsumption({required this.data, required this.numberOfActions});

  final WinterMyConsumptionData data;
  final int numberOfActions;

  @override
  List<Object> get props => [data, numberOfActions];
}
