import 'package:app/core/address/address.dart';
import 'package:app/features/services/winter/domain/winter_registration.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class WinterState extends Equatable {
  const WinterState();

  @override
  List<Object> get props => [];
}

@immutable
final class WinterInitial extends WinterState {
  const WinterInitial();
}

enum WinterConnectionStatus { unknown, established, failed }

@immutable
final class WinterForm extends WinterState {
  const WinterForm({
    required this.formType,
    required this.address,
    required this.lastName,
    required this.prmNumber,
    required this.isDeclarationChecked,
    required this.connectionStatus,
  });

  final RegistrationType formType;
  final Address address;
  final String lastName;
  final String prmNumber;
  final bool isDeclarationChecked;
  final WinterConnectionStatus connectionStatus;

  bool get isFormValid => switch (formType) {
    RegistrationType.address => address.isFull && lastName.isNotEmpty && isDeclarationChecked,
    RegistrationType.prm => prmNumber.isNotEmpty && isDeclarationChecked,
  };
  bool get isFormInvalid => !isFormValid;

  WinterForm copyWith({
    final RegistrationType? formType,
    final Address? address,
    final String? lastName,
    final String? prmNumber,
    final bool? isDeclarationChecked,
    final WinterConnectionStatus? connectionStatus,
  }) => WinterForm(
    formType: formType ?? this.formType,
    address: address ?? this.address,
    lastName: lastName ?? this.lastName,
    prmNumber: prmNumber ?? this.prmNumber,
    isDeclarationChecked: isDeclarationChecked ?? this.isDeclarationChecked,
    connectionStatus: connectionStatus ?? this.connectionStatus,
  );

  @override
  List<Object> get props => [formType, address, lastName, prmNumber, isDeclarationChecked, connectionStatus];
}
