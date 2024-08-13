import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/common/my_snackbar.dart';
import '../../domain/entity/forum_entity.dart';
import '../../domain/usecases/forum_usecase.dart';
import '../state/forum_state.dart';

final forumViewModelProvider =
    StateNotifierProvider<ForumViewModel, ForumState>(
  (ref) => ForumViewModel(ref.read(forumUseCaseProvider)),
);

class ForumViewModel extends StateNotifier<ForumState> {
  final ForumUseCase forumUseCase;

  ForumViewModel(this.forumUseCase) : super(ForumState.initial()) {
    getAllPosts();
  }

  Future resetState() async {
    state = ForumState.initial();
    getAllPosts();
  }

  Future<void> getAllPosts({int? page}) async {
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final currentPage = page ?? currentState.page + 1;
    final posts = currentState.posts;
    final hasReachedMax = currentState.hasReachedMax;

    if (!hasReachedMax) {
      final result = await forumUseCase.getAllForumPosts(currentPage);
      result.fold(
        (failure) =>
            state = state.copyWith(hasReachedMax: true, isLoading: false),
        (data) {
          if (data.isEmpty) {
            state = state.copyWith(hasReachedMax: true, isLoading: false);
          } else {
            state = state.copyWith(
              posts: currentPage == 1 ? data : [...posts, ...data],
              page: currentPage,
              isLoading: false,
            );
          }
        },
      );
    }
  }

  Future<void> getUsersPosts(String userId) async {
    state = state.copyWith(isLoading: true);

    final result = await forumUseCase.getForumPost(userId);
    result.fold(
      (failure) => state = state.copyWith(isLoading: false),
      (data) {
        if (data.isEmpty) {
          state = state.copyWith(isLoading: false);
        } else {
          state = state.copyWith(
            userPosts: data,
            isLoading: false,
          );
        }
      },
    );
  }

  // Add the searchAllPosts method here
  Future<void> searchPosts(String searchTerm) async {
    state = state.copyWith(isLoading: true);
    final result = await forumUseCase.searchAllPosts(searchTerm);
    result.fold(
      (failure) => state = state.copyWith(isLoading: false, searchResults: []),
      (posts) => state = state.copyWith(isLoading: false, searchResults: posts),
    );
  }
}
