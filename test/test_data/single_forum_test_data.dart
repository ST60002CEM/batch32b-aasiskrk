import 'package:playforge/features/dashboard/domain/entity/forum_entity.dart';

class ForumTestData1 {
  ForumTestData1._(); // Private constructor to prevent instantiation

  static List<ForumPostEntity> getForumTestData() {
    // Create test CommentEntity instances
    final comment1 = CommentEntity(
      userId: 'user_1',
      comment: 'This is a great post!',
      commentedAt: DateTime.now().subtract(Duration(hours: 1)),
      userName: 'User One',
    );

    final comment2 = CommentEntity(
      userId: 'user_2',
      comment: 'Thanks for sharing this information.',
      commentedAt: DateTime.now().subtract(Duration(hours: 12)),
      userName: 'User Two',
    );

    // Create test PostedUserEntity instances
    final postedUser1 = PostedUserEntity(
      userId: 'user_3',
      fullName: 'User Three',
      profilePicture: 'https://example.com/profile_picture.png',
    );

    final postedUser2 = PostedUserEntity(
      userId: 'user_4',
      fullName: 'User Four',
      profilePicture: 'https://example.com/profile_picture2.png',
    );

    // Create a list of ForumPostEntity with test data
    return [
      ForumPostEntity(
        id: 'post_1',
        postPicture: 'https://example.com/post_picture.png',
        postTitle: 'My First Forum Post',
        postDescription: 'This is the description of the first forum post.',
        postTags: ['tag1', 'tag2', 'tag3'],
        postComments: [comment1, comment2],
        postLikes: 120,
        postDislikes: 10,
        postViews: 1500,
        postedTime: '2023-08-16T12:00:00Z',
        postedUserId: postedUser1.userId, // Assuming postedUserId is a String
        postedFullname: postedUser1.fullName,
      ),
      ForumPostEntity(
        id: 'post_2',
        postPicture: 'https://example.com/post_picture2.png',
        postTitle: 'Another Interesting Post',
        postDescription: 'This is the description of another interesting post.',
        postTags: ['tagA', 'tagB'],
        postComments: [comment2],
        postLikes: 45,
        postDislikes: 2,
        postViews: 300,
        postedTime: '2023-08-17T15:00:00Z',
        postedUserId: postedUser2.userId,
        postedFullname: postedUser2.fullName,
      ),
      ForumPostEntity(
        id: 'post_3',
        postPicture: 'https://example.com/post_picture3.png',
        postTitle: 'A Thought-Provoking Post',
        postDescription: 'This post discusses deep thoughts and ideas.',
        postTags: ['deep', 'thoughts', 'ideas'],
        postComments: [],
        postLikes: 200,
        postDislikes: 5,
        postViews: 1000,
        postedTime: '2023-08-18T09:00:00Z',
        postedUserId: postedUser1.userId,
        postedFullname: postedUser1.fullName,
      ),
    ];
  }
}
