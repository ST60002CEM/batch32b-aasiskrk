import 'dart:io';

import 'package:flutter/material.dart';
import 'package:playforge/features/dashboard/presentation/viewmodel/forum_view_model.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../core/common/my_snackbar.dart';
import '../../domain/entity/post_entity.dart';
import '../../domain/usecases/post_usecase.dart';
import '../../../dashboard/presentation/navigator/home_navigator.dart';
import '../state/post_state.dart';

final homeViewModelProvider =
    StateNotifierProvider<HomeViewModel, PostState>((ref) {
  final navigator = ref.read(homeViewNavigatorProvider);
  final postUseCase = ref.read(postUseCaseProvider);
  return HomeViewModel(navigator, postUseCase, ref);
});

class HomeViewModel extends StateNotifier<PostState> {
  // HomeViewModel(this.navigator, this._postsDataSource) : super(null);

  HomeViewNavigator navigator;

  final PostUseCase _postUsecase;
  final Ref _ref;

  HomeViewModel(
    this.navigator,
    this._postUsecase,
    this._ref,
  ) : super(
          PostState.initial(),
        ) {}

  Future resetState() async {
    state = PostState.initial();
  }

  Future<void> addPost1(PostEntity? post, File? image) async {
    //Progress bar
    state = state.copyWith(isLoading: true);
    var data = await _postUsecase.addPost1(
        post!, image!); //remove '!, ?'if throws error

    data.fold((l) {
      state = state.copyWith(isLoading: false);
      showMySnackBar(message: l.error, color: Colors.red);
    }, (r) {
      state = state.copyWith(isLoading: false);
      showMySnackBar(message: 'Post added successfully');
      _ref.read(forumViewModelProvider.notifier).resetState();
    });
  }
}
