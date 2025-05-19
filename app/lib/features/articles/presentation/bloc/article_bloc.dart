import 'package:app/features/articles/infrastructure/articles_repository.dart';
import 'package:app/features/articles/presentation/bloc/article_event.dart';
import 'package:app/features/articles/presentation/bloc/article_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleBloc({required final ArticlesRepository articlesRepository}) : super(const ArticleState(article: null)) {
    on<ArticleRecuperationDemandee>((final event, final emit) async {
      final result = await articlesRepository.recupererArticle(event.id);
      await result.fold((final l) {}, (final r) async {
        emit(ArticleState(article: r));
      });
    });
    on<ArticleAddToFavoritesPressed>((final event, final emit) async {
      final article = state.article;
      if (article == null) {
        return;
      }
      await articlesRepository.addToFavorites(article.id);
      final updatedArticle = article.copyWith(isFavorite: true);
      emit(ArticleState(article: updatedArticle));
    });
    on<ArticleRemoveToFavoritesPressed>((final event, final emit) async {
      final article = state.article;
      if (article == null) {
        return;
      }
      await articlesRepository.removeToFavorites(article.id);
      final updatedArticle = article.copyWith(isFavorite: false);
      emit(ArticleState(article: updatedArticle));
    });
    on<ArticleSharePressed>((final event, final emit) async {
      final article = state.article;
      if (article == null) {
        return;
      }
      await articlesRepository.share(article.id);
    });
  }
}
