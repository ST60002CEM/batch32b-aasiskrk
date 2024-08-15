import 'dart:math';

import '../../domain/entity/forum_entity.dart';

class ForumState {
  final bool isLoading;
  final String? error;
  final List<ForumPostEntity> posts;
  final List<ForumPostEntity> userPosts;
  final List<ForumPostEntity> searchResults;
  final ForumPostEntity? singlePost;
  final bool hasReachedMax;
  final int page;

  ForumState({
    required this.isLoading,
    this.error,
    required this.searchResults,
    required this.posts,
    required this.page,
    required this.hasReachedMax,
    required this.userPosts,
    this.singlePost,
  });

  factory ForumState.initial() {
    return ForumState(
      isLoading: false,
      error: null,
      posts: [],
      searchResults: [],
      hasReachedMax: false,
      page: 0,
      userPosts: [],
      singlePost: null,
    );
  }

  ForumState copyWith({
    bool? isLoading,
    String? error,
    int? page,
    List<ForumPostEntity>? posts,
    List<ForumPostEntity>? searchResults,
    bool? hasReachedMax,
    List<ForumPostEntity>? userPosts,
    ForumPostEntity? singlePost,
  }) {
    return ForumState(
      isLoading: isLoading ?? this.isLoading,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      error: error ?? this.error,
      page: page ?? this.page,
      posts: posts ?? this.posts,
      userPosts: userPosts ?? this.userPosts,
      searchResults: searchResults ?? this.searchResults,
      singlePost: singlePost ?? this.singlePost,
    );
  }
}
