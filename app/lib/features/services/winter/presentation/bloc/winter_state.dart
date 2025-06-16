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

@immutable
final class WinterLoading extends WinterState {
  const WinterLoading();
}

enum WinterConnectionStatus { unknown, established, failed }

@immutable
final class WinterForm extends WinterState {
  const WinterForm({
    required this.address,
    required this.lastName,
    required this.isDeclarationChecked,
    required this.connectionStatus,
  });

  final String address;
  final String lastName;
  final bool isDeclarationChecked;
  final WinterConnectionStatus connectionStatus;

  bool get isFormValid => address.isNotEmpty && lastName.isNotEmpty && isDeclarationChecked;
  bool get isFormInvalid => !isFormValid;

  WinterForm copyWith({
    final String? address,
    final String? lastName,
    final bool? isDeclarationChecked,
    final WinterConnectionStatus? connectionStatus,
  }) => WinterForm(
    address: address ?? this.address,
    lastName: lastName ?? this.lastName,
    isDeclarationChecked: isDeclarationChecked ?? this.isDeclarationChecked,
    connectionStatus: connectionStatus ?? this.connectionStatus,
  );

  @override
  List<Object> get props => [address, lastName, isDeclarationChecked, connectionStatus];
}
