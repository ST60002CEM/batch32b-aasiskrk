import '../../data/model/game_info.dart';

class GameEntity {
  final String productId;
  final String title;
  final String author;
  final String thumbnail;
  final String link;
  final double rating;

  GameEntity({
    required this.productId,
    required this.title,
    required this.author,
    required this.thumbnail,
    required this.link,
    required this.rating,
  });

  factory GameEntity.fromGameInfo(GameInfo gameInfo) {
    return GameEntity(
      productId: "", // Generate or map a unique ID
      title: gameInfo.title,
      author: gameInfo.author,
      thumbnail: gameInfo.thumbnail,
      link: gameInfo.link,
      rating: double.tryParse(gameInfo.rating) ?? 0.0,
    );
  }
  @override
  String toString() {
    return 'GameEntity(title: $title, author: $author, thumbnail: $thumbnail, rating: $rating)';
  }
}
