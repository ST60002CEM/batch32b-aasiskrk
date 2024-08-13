import '../../domain/entity/post_entity.dart';

class PostState {
  final PostEntity? post;
  final bool hasReachedMax;
  final int page;
  final bool isLoading;
  final String? error;

  PostState({
    this.post,
    required this.hasReachedMax,
    required this.page,
    required this.isLoading,
    this.error,
  });

  factory PostState.initial() {
    return PostState(
      post: null,
      hasReachedMax: false,
      page: 0,
      isLoading: false,
      error: null,
    );
  }

  PostState copyWith({
    PostEntity? post,
    bool? hasReachedMax,
    int? page,
    bool? isLoading,
    String? error,
  }) {
    return PostState(
      post: post ?? this.post,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
