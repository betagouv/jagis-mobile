import 'package:app/features/recommandations/domain/recommendation.dart';
import 'package:equatable/equatable.dart';

class Library extends Equatable {
  const Library({required this.contents, required this.filters});

  final List<Recommendation> contents;
  final List<LibraryFilter> filters;

  @override
  List<Object> get props => [contents, filters];
}

class LibraryFilter extends Equatable {
  const LibraryFilter({required this.code, required this.title, required this.isSelected});

  final String code;
  final String title;
  final bool isSelected;

  @override
  List<Object?> get props => [code, title, isSelected];
}
