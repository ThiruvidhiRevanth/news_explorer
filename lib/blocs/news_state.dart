import '../models/article_model.dart';

abstract class NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<Article> articles;
  NewsLoaded(this.articles);
}

class NewsError extends NewsState {}
