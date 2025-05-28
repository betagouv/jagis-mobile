import 'package:app/features/articles/domain/article.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class ArticleState extends Equatable {
  const ArticleState({required this.article});

  final Article? article;

  @override
  List<Object?> get props => [article];
}
