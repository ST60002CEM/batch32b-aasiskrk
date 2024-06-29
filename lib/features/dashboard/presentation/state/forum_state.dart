import '../../domain/entity/forum_entity.dart';

class ForumState {
  final bool isLoading;
  final String? error;
  final List<ForumPostEntity> posts;
  final bool hasReachedMax;
  final int page;

  ForumState({
    required this.isLoading,
    this.error,
    required this.posts,
    required this.page,
    required this.hasReachedMax,
  });

  factory ForumState.initial() {
    return ForumState(
      isLoading: false,
      error: null,
      posts: [],
      hasReachedMax: false,
      page: 0,
    );
  }

  ForumState copyWith({
    bool? isLoading,
    String? error,
    int? page,
    List<ForumPostEntity>? posts,
    bool? hasReachedMax,
  }) {
    return ForumState(
      isLoading: isLoading ?? this.isLoading,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      error: error ?? this.error,
      page: page ?? this.page,
      posts: posts ?? this.posts,
    );
  }

  @override
  String toString() =>
      'ForumState(isLoading: $isLoading, error: $error, posts: $posts, hasReachedMax: $hasReachedMax, page: $page)';
}
