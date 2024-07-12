import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:playforge/features/dashboard/domain/entity/forum_entity.dart';
import 'package:playforge/features/dashboard/domain/usecases/forum_usecase.dart';
import 'package:playforge/features/dashboard/presentation/viewmodel/forum_view_model.dart';

import '../test_data/forum_test_data.dart';
import 'forum_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<ForumUseCase>(),
])
void main() {
  late ForumUseCase mockForumUseCase;
  late ProviderContainer container;
  late List<ForumPostEntity> lstForums;

  setUp(() {
    mockForumUseCase = MockForumUseCase();
    lstForums = ForumTestData.getForumTestData();

    container = ProviderContainer(
      overrides: [
        forumViewModelProvider.overrideWith(
          (ref) => ForumViewModel(
            mockForumUseCase,
          ),
        )
      ],
    );
  });

  test('Check forum intial state', () async {
    int page = 1;
    when(mockForumUseCase.getAllForumPosts(page))
        .thenAnswer((_) => Future.value(Right(lstForums)));

    //get all batches
    await container.read(forumViewModelProvider.notifier).getAllForumPosts();

    //store the state
    final forumState = container.read(forumViewModelProvider);

    //check the state
    expect(forumState.isLoading, false);
    expect(forumState.error, isNull);
    expect(forumState.posts, lstForums);
    expect(forumState.hasReachedMax, false);
  });

  tearDown(
    () {
      container.dispose();
    },
  );
}
