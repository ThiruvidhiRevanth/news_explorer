class Article {
  final String title;
  final String description;
  final String urlToImage;
  final String url;
  final String publishedAt;
  final String author ;
  final String content;
  


  Article({required this.title, required this.description, required this.urlToImage, required this.url,required this.publishedAt, required this.author ,required this.content});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json["title"] ?? "No title",
      description: json["description"] ?? "No Description",
      urlToImage: json["urlToImage"] ?? "",
      url: json["url"] ?? "",
      publishedAt: json["publishedAt"] ?? "",
      author: json["author"] ?? "",
      content: json["content"] ?? "",
     


    );
  }
}
