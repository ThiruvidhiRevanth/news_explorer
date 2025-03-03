import 'package:flutter_bloc/flutter_bloc.dart';
import '../api_service.dart';
import 'news_event.dart';
import 'news_state.dart';


class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final ApiService apiService;

  NewsBloc(this.apiService) : super(NewsLoading()) {
    on<FetchNews>((event, emit) async {
      try {
        final articles = await apiService.fetchNews(category: event.category);
        emit(NewsLoaded(articles));
      } catch (_) {
        emit(NewsError());
      }
    });
  }
}
