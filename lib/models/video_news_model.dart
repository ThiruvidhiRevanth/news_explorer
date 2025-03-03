class VideoNews {
  final String title;
  final String videoUrl;
  final String description;

  VideoNews({required this.title, required this.videoUrl, required this.description});

  factory VideoNews.fromJson(Map<String, dynamic> json) {
    return VideoNews(
      title: json['title'],
      videoUrl: json['videoUrl'],
      description: json['description'],
    );
  }
}
