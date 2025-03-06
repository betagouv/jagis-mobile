import 'package:equatable/equatable.dart';

class Response extends Equatable {
  const Response({required this.value, this.unit});

  final String value;
  final Unit? unit;

  Response copyWith({final String? value, final Unit? unit}) => Response(value: value ?? this.value, unit: unit ?? this.unit);

  @override
  List<Object?> get props => [value, unit];
}

final class Unit extends Equatable {
  const Unit({required this.abreviation, this.long});

  final String abreviation;
  final String? long;

  @override
  List<Object?> get props => [abreviation, long];
}
