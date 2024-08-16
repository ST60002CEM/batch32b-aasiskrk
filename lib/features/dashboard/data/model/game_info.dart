class GameInfo {
  final String title;
  final String thumbnail;
  final String author;
  final String link;
  final String rating;

  GameInfo({
    required this.title,
    required this.thumbnail,
    required this.author,
    required this.link,
    required this.rating,
  });

  factory GameInfo.fromJson(Map<String, dynamic> json) {
    return GameInfo(
      title: json['title'] ?? 'No Title',
      thumbnail: json['thumbnail'] ?? '',
      author: json['author'] ?? 'Unknown Author',
      link: json['link'] ?? '',
      rating: json['rating'] ?? 'N/A',
    );
  }
}
