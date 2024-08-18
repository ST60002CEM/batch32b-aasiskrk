// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:playforge/core/common/my_snackbar.dart';
// import 'package:playforge/core/failure/failure.dart';
// import 'package:playforge/core/failure/post_failure.dart';
// import 'package:playforge/features/dashboard/domain/entity/comment_entity.dart';
// import 'package:playforge/features/dashboard/domain/entity/forum_entity.dart';
// import 'package:playforge/features/dashboard/domain/entity/game_entity.dart';
// import 'package:playforge/features/dashboard/domain/usecases/forum_usecase.dart';
// import 'package:playforge/features/dashboard/presentation/navigator/home_navigator.dart';
// import 'package:playforge/features/dashboard/presentation/state/forum_state.dart';
// import 'package:playforge/features/dashboard/presentation/viewmodel/forum_view_model.dart';
// import 'package:dartz/dartz.dart';
//
// import '../test_data/forum_test_data.dart';
// import 'forum_test.mocks.dart';
//
// @GenerateMocks([ForumUseCase, HomeViewNavigator])
// void main() {
//   late MockForumUseCase mockForumUseCase;
//   late MockHomeViewNavigator mockHomeViewNavigator;
//   late ForumViewModel forumViewModel;
//
//   setUp(() {
//     mockForumUseCase = MockForumUseCase();
//     mockHomeViewNavigator = MockHomeViewNavigator();
//
//     when(mockForumUseCase.getAllForumPosts(any, any))
//         .thenAnswer((_) async => Right([]));
//     when(mockForumUseCase.getForumPost()).thenAnswer((_) async => Right([]));
//     forumViewModel = ForumViewModel(mockForumUseCase, mockHomeViewNavigator);
//     TestWidgetsFlutterBinding.ensureInitialized();
//   });
//
//   group('ForumViewModel Tests', () {
//     test('getAllPosts failure', () async {
//       final error = Failure(error: 'Error fetching posts');
//       when(mockForumUseCase.getAllForumPosts(any, any))
//           .thenAnswer((_) async => Left(error));
//
//       await forumViewModel.getAllPosts();
//
//       expect(forumViewModel.state.isLoading, false);
//       expect(forumViewModel.state.posts, []);
//       verify(mockForumUseCase.getAllForumPosts(any, any)).called(1);
//     });
//
//     test('getUsersPosts success', () async {
//       final posts = [
//         ForumPostEntity(
//           id: '1',
//           postTitle: 'Search Post',
//           postPicture: '',
//           postDescription: '',
//           postTags: [],
//           postComments: [],
//           postLikes: 0,
//           postDislikes: 0,
//           postViews: 0,
//           postedTime: '',
//           postedUserId: '',
//           postedFullname: '',
//         )
//       ];
//       when(mockForumUseCase.getForumPost())
//           .thenAnswer((_) async => Right(posts));
//
//       await forumViewModel.getUsersPosts();
//
//       expect(forumViewModel.state.isLoading, false);
//       expect(forumViewModel.state.userPosts, posts);
//       verify(mockForumUseCase.getForumPost()).called(2);
//     });
//
//     test('getUsersPosts failure', () async {
//       final error = Failure(error: 'Error fetching user posts');
//       when(mockForumUseCase.getForumPost())
//           .thenAnswer((_) async => Left(error));
//
//       await forumViewModel.getUsersPosts();
//
//       expect(forumViewModel.state.isLoading, false);
//       expect(forumViewModel.state.userPosts, []);
//       verify(mockForumUseCase.getForumPost()).called(1);
//     });
//
//     test('searchPosts success', () async {
//       final posts = [
//         ForumPostEntity(
//           id: '1',
//           postTitle: 'Search Post',
//           postPicture: '',
//           postDescription: '',
//           postTags: [],
//           postComments: [],
//           postLikes: 0,
//           postDislikes: 0,
//           postViews: 0,
//           postedTime: '',
//           postedUserId: '',
//           postedFullname: '',
//         )
//       ];
//       when(mockForumUseCase.searchAllPosts(any))
//           .thenAnswer((_) async => Right(posts));
//
//       await forumViewModel.searchPosts('searchTerm');
//
//       expect(forumViewModel.state.isLoading, false);
//       expect(forumViewModel.state.searchResults, posts);
//       verify(mockForumUseCase.searchAllPosts(any)).called(1);
//     });
//
//     test('searchPosts failure', () async {
//       final error = PostFailure(message: 'Error searching posts');
//       when(mockForumUseCase.searchAllPosts(any))
//           .thenAnswer((_) async => Left(error));
//
//       await forumViewModel.searchPosts('searchTerm');
//
//       expect(forumViewModel.state.isLoading, true);
//       expect(forumViewModel.state.searchResults, []);
//       verify(mockForumUseCase.searchAllPosts(any)).called(1);
//     });
//
//     test('getPosts success', () async {
//       final post = ForumPostEntity(
//         id: '1',
//         postTitle: 'Search Post',
//         postPicture: '',
//         postDescription: '',
//         postTags: [],
//         postComments: [],
//         postLikes: 0,
//         postDislikes: 0,
//         postViews: 0,
//         postedTime: '',
//         postedUserId: '',
//         postedFullname: '',
//       );
//       when(mockForumUseCase.getPosts(any)).thenAnswer((_) async => Right(post));
//
//       await forumViewModel.getPosts('1');
//
//       expect(forumViewModel.state.isLoading, false);
//       expect(forumViewModel.state.singlePost, post);
//       verify(mockForumUseCase.getPosts(any)).called(1);
//     });
//
//     test('getPosts failure', () async {
//       final error = Failure(error: 'Error fetching post');
//       when(mockForumUseCase.getPosts(any)).thenAnswer((_) async => Left(error));
//
//       await forumViewModel.getPosts('1');
//
//       expect(forumViewModel.state.isLoading, false);
//       expect(forumViewModel.state.singlePost, null);
//       expect(forumViewModel.state.error, error.error);
//       verify(mockForumUseCase.getPosts(any)).called(1);
//     });
//
//     test('likePost failure', () async {
//       final postId = '1';
//       final error = Failure(error: 'Error liking post');
//       when(mockForumUseCase.likePost(postId))
//           .thenAnswer((_) async => Left(error));
//
//       await forumViewModel.likePost(postId);
//
//       verify(mockForumUseCase.likePost(postId)).called(1);
//     });
//
//     test('dislikePost failure', () async {
//       final postId = '1';
//       final error = Failure(error: 'Error disliking post');
//       when(mockForumUseCase.dislikePost(postId))
//           .thenAnswer((_) async => Left(error));
//
//       await forumViewModel.dislikePost(postId);
//
//       verify(mockForumUseCase.dislikePost(postId)).called(1);
//     });
//
//     test('viewPost success', () async {
//       final postId = '1';
//       final posts = [
//         ForumPostEntity(
//           id: '1',
//           postTitle: 'Search Post',
//           postPicture: '',
//           postDescription: '',
//           postTags: [],
//           postComments: [],
//           postLikes: 0,
//           postDislikes: 0,
//           postViews: 0,
//           postedTime: '',
//           postedUserId: '',
//           postedFullname: '',
//         )
//       ];
//       forumViewModel.state = forumViewModel.state.copyWith(posts: posts);
//       when(mockForumUseCase.viewPost(postId))
//           .thenAnswer((_) async => Right(true));
//
//       await forumViewModel.viewPost(postId);
//
//       expect(forumViewModel.state.posts.first.postViews, 1);
//       verify(mockForumUseCase.viewPost(postId)).called(1);
//     });
//
//     test('viewPost failure', () async {
//       final postId = '1';
//       final error = Failure(error: 'Error viewing post');
//       when(mockForumUseCase.viewPost(postId))
//           .thenAnswer((_) async => Left(error));
//
//       await forumViewModel.viewPost(postId);
//
//       verify(mockForumUseCase.viewPost(postId)).called(1);
//     });
//
//     test('addComment failure', () async {
//       final postId = '1';
//       final comment = AddCommentEntity(
//           comment: 'Test Comment',
//           userId: '1',
//           userName: 'User',
//           commentedAt: '');
//       final error = Failure(error: 'Error adding comment');
//       when(mockForumUseCase.addComment(postId, comment))
//           .thenAnswer((_) async => Left(error));
//
//       await forumViewModel.addComment(postId, comment);
//
//       verify(mockForumUseCase.addComment(postId, comment)).called(1);
//     });
//
//     test('searchGamesApi success', () async {
//       final games = [
//         GameEntity(
//             productId: '1',
//             title: 'Test Game',
//             author: '',
//             thumbnail: '',
//             link: '',
//             rating: 0.0)
//       ];
//       when(mockForumUseCase.searchGamesApi(any, any, any))
//           .thenAnswer((_) async => Right(games));
//
//       await forumViewModel.searchGamesApi('query', 'category', 'token');
//
//       expect(forumViewModel.state.isLoading, false);
//       expect(forumViewModel.state.games, games);
//       verify(mockForumUseCase.searchGamesApi(any, any, any)).called(1);
//     });
//
//     test('searchGamesApi failure', () async {
//       final error = Failure(error: 'Error searching games');
//       when(mockForumUseCase.searchGamesApi(any, any, any))
//           .thenAnswer((_) async => Left(error));
//
//       await forumViewModel.searchGamesApi('query', 'category', 'token');
//
//       expect(forumViewModel.state.isLoading, false);
//       expect(forumViewModel.state.error, error.error);
//       verify(mockForumUseCase.searchGamesApi(any, any, any)).called(1);
//     });
//   });
// }
