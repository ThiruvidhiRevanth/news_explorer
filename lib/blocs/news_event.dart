abstract class NewsEvent {}

class FetchNews extends NewsEvent {
  final String category;
  FetchNews({this.category = "General"});
}
