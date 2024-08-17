import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playforge/core/failure/failure.dart';
import 'package:playforge/core/shared_prefs/user_shared_prefs.dart';
import 'package:playforge/features/dashboard/presentation/navigator/home_navigator.dart';
import 'package:playforge/features/dashboard/presentation/navigator/post_navigator.dart';
import '../../../../app/constants/api_endpoint.dart';
import '../../../../core/common/my_snackbar.dart';
import '../../domain/entity/comment_entity.dart';
import '../../domain/entity/forum_entity.dart';
import '../../domain/usecases/forum_usecase.dart';
import '../state/forum_state.dart';

final forumViewModelProvider =
    StateNotifierProvider<ForumViewModel, ForumState>((ref) => ForumViewModel(
        ref.read(forumUseCaseProvider), ref.read(homeViewNavigatorProvider)));

class ForumViewModel extends StateNotifier<ForumState> {
  HomeViewNavigator navigator;
  final ForumUseCase forumUseCase;
  UserSharedPrefs? userSharedPrefs;

  ForumViewModel(this.forumUseCase, this.navigator)
      : super(ForumState.initial()) {
    getAllPosts();
    getUsersPosts();
  }

  Future resetState() async {
    state = ForumState.initial();
    getUsersPosts();
    getAllPosts();
  }

  Future<void> getAllPosts(
      {int? page, String sortOption = "mostRecent", bool reset = false}) async {
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final currentPage = reset ? 1 : (page ?? state.page + 1);
    final currentPosts = reset ? [] : state.posts;
    final hasReachedMax = state.hasReachedMax && !reset;

    if (!hasReachedMax) {
      final result =
          await forumUseCase.getAllForumPosts(currentPage, sortOption);
      result.fold(
        (failure) =>
            state = state.copyWith(hasReachedMax: true, isLoading: false),
        (data) {
          if (data.isEmpty) {
            state = state.copyWith(hasReachedMax: true, isLoading: false);
          } else {
            state = state.copyWith(
              posts: currentPage == 1 ? data : [...currentPosts, ...data],
              page: currentPage,
              hasReachedMax: data.length < ApiEndpoints.limitPage,
              isLoading: false,
            );
          }
        },
      );
    }
  }

  Future<void> getUsersPosts() async {
    state = state.copyWith(isLoading: true);

    final result = await forumUseCase.getForumPost();
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

  Future getPosts(String postId) async {
    // String productId = '';// get the product Id
    state = state.copyWith(isLoading: true);

    // get data from data source
    final result = await forumUseCase.getPosts(postId);
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        print("Error: ${failure.error}");
      },
      (product) {
        state =
            state.copyWith(isLoading: false, singlePost: product, error: null);
        print("Post loaded: ${product.postTitle}");
      },
    );
  }

  void openPostPage(String postId) {
    navigator.openPostDetailsView(postId);
  }

  Future<void> likePost(String postId) async {
    var data = await forumUseCase.likePost(postId);

    data.fold((l) {
      showMySnackBar(message: l.error, color: Colors.red);
    }, (r) {
      // Assuming state.posts is a List<PostEntity>
      final updatedPosts = state.posts.map((post) {
        if (post.id == postId) {
          // Increment the like count if the post is liked
          return post.copyWith(
            postLikes: post.postLikes + 1,
          );
        }
        return post;
      }).toList(); // Don't forget to convert the iterable back to a List

      final updatedSinglePost = state.singlePost?.id == postId
          ? state.singlePost!.copyWith(
              postLikes: state.singlePost!.postLikes + 1,
            )
          : state.singlePost;

      state = state.copyWith(posts: updatedPosts);
      state = state.copyWith(singlePost: updatedSinglePost);
      showMySnackBar(message: 'Post liked successfully');
    });
  }

  Future<void> dislikePost(String postId) async {
    var data = await forumUseCase.dislikePost(postId);

    data.fold((l) {
      showMySnackBar(message: l.error, color: Colors.red);
    }, (r) {
      // Assuming state.posts is a List<PostEntity>
      final updatedPosts = state.posts.map((post) {
        if (post.id == postId) {
          // Increment the like count if the post is liked
          return post.copyWith(
            postDislikes: post.postDislikes + 1,
          );
        }
        return post;
      }).toList();
      // Update the singlePost if it matches the disliked post
      final updatedSinglePost = state.singlePost?.id == postId
          ? state.singlePost!.copyWith(
              postDislikes: state.singlePost!.postDislikes + 1,
            )
          : state.singlePost;

      state = state.copyWith(posts: updatedPosts);
      state = state.copyWith(singlePost: updatedSinglePost);
      showMySnackBar(message: 'Post Disliked successfully');
    });
  }

  Future<void> viewPost(String postId) async {
    var data = await forumUseCase.viewPost(postId);

    data.fold((l) {
      showMySnackBar(message: l.error, color: Colors.red);
    }, (r) {
      // Assuming state.posts is a List<PostEntity>
      final updatedPosts = state.posts.map((post) {
        if (post.id == postId) {
          // Increment the like count if the post is liked
          return post.copyWith(
            postViews: post.postViews + 1,
          );
        }
        return post;
      }).toList(); // Don't forget to convert the iterable back to a List

      state = state.copyWith(posts: updatedPosts);
    });
  }

  Future<void> addComment(String postId, AddCommentEntity comment) async {
    final result = await forumUseCase.addComment(postId, comment);
    result.fold(
      (failure) {
        showMySnackBar(message: failure.error, color: Colors.red);
      },
      (success) {
        showMySnackBar(message: 'Comment added successfully');

        // Convert AddCommentEntity to CommentEntity
        final newComment = CommentEntity(
          comment: comment.comment,
          userId: comment.userId,
          commentedAt: DateTime.now(), userName: comment.userName,
          // Add other fields from AddCommentEntity that are necessary
        );

        // Update the state by adding the new comment to the post's comment list
        final updatedPosts = state.posts.map((post) {
          if (post.id == postId) {
            return post.copyWith(
              postComments: [...post.postComments, newComment],
            );
          }
          return post;
        }).toList();

        // Update the state for singlePost if it matches the commented post
        final updatedSinglePost = state.singlePost?.id == postId
            ? state.singlePost!.copyWith(
                postComments: [...state.singlePost!.postComments, newComment],
              )
            : state.singlePost;

        state = state.copyWith(posts: updatedPosts);
        state = state.copyWith(singlePost: updatedSinglePost);
      },
    );
  }

  Future<void> editPost(String postId, ForumPostEntity updatedPost) async {
    final result = await forumUseCase.editPost(postId, updatedPost);
    result.fold(
      (failure) {
        showMySnackBar(message: failure.error, color: Colors.red);
      },
      (success) {
        showMySnackBar(message: 'Post updated successfully');
        // Optionally, refresh the post state after editing
        getPosts(postId);
      },
    );
  }

  Future<void> deletePost(String postId) async {
    final result = await forumUseCase.deletePost(postId);
    result.fold(
      (failure) {
        showMySnackBar(message: failure.error, color: Colors.red);
      },
      (success) {
        showMySnackBar(message: 'Post deleted successfully');
        // Optionally, refresh the list of posts after deleting
        state = state.copyWith(
            posts: state.posts.where((post) => post.id != postId).toList(),
            userPosts:
                state.userPosts.where((post) => post.id != postId).toList());
      },
    );
  }

  Future<void> searchGamesApi(
      String query, String category, String? sectionPageToken) async {
    state = state.copyWith(isLoading: true); // Show loading state

    try {
      final result = await forumUseCase.searchGamesApi(
          query, category, sectionPageToken ?? '');

      result.fold(
        (failure) {
          state = state.copyWith(
            isLoading: false,
            error: failure.error,
          );
          showMySnackBar(message: failure.error, color: Colors.red);
        },
        (games) {
          print("Fetched Games: $games"); //
          state = state.copyWith(
            isLoading: false,
            games: games,
          );
        },
      );
    } on Exception catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'An unexpected error occurred',
      );
      showMySnackBar(
          message: 'An unexpected error occurred', color: Colors.red);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'An unexpected error occurred',
      );
      showMySnackBar(
          message: 'An unexpected error occurred', color: Colors.red);
    }
  }
}
