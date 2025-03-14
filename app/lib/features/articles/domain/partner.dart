import 'package:equatable/equatable.dart';

class Partner extends Equatable {
  const Partner({required this.name, required this.logo, required this.url});

  final String name;
  final String logo;
  final String? url;

  @override
  List<Object?> get props => [name, logo, url];
}
