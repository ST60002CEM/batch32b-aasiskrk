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
    getAllForumPosts();
  }

  Future resetState() async {
    state = ForumState.initial();
    getAllForumPosts();
  }

  Future<void> addForumPost(ForumPostEntity post) async {
    state = state.copyWith(isLoading: true);
    var result = await forumUseCase.addForumPost(post);
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showMySnackBar(message: failure.error, color: Colors.red);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        showMySnackBar(message: "Post added successfully");
        getAllForumPosts();
      },
    );
  }

  Future<void> getAllForumPosts() async {
    if (state.isLoading || state.hasReachedMax) return;
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final page = currentState.page + 1;
    final posts = currentState.posts;
    final hasReachedMax = currentState.hasReachedMax;
    if (!hasReachedMax) {
      var result = await forumUseCase.getAllForumPosts(page);
      result.fold(
        (failure) {
          state = state.copyWith(
              isLoading: false, error: failure.error, hasReachedMax: true);
          showMySnackBar(message: failure.error, color: Colors.red);
        },
        (data) {
          if (data.isEmpty) {
            state = state.copyWith(hasReachedMax: true, isLoading: false);
          } else {
            state = state.copyWith(
              isLoading: false,
              error: null,
              posts: [...posts, ...data],
              page: page,
            );
          }
        },
      );
    }
  }

  Future<void> getForumPost(String postId) async {
    state = state.copyWith(isLoading: true);
    var result = await forumUseCase.getForumPost(postId);
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showMySnackBar(message: failure.error, color: Colors.red);
      },
      (post) {
        state = state.copyWith(isLoading: false, error: null, posts: [post!]);
      },
    );
  }
}
