import 'package:playforge/features/dashboard/domain/entity/forum_entity.dart';

class ForumTestData {
  ForumTestData._(); // Private constructor to prevent instantiation

  static List<ForumPostEntity> getForumTestData() {
    // Create some test CommentEntity instances
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

    // Create a test PostedUserEntity instance
    final postedUser = PostedUserEntity(
      userId: 'user_3',
      fullName: 'User Three',
      profilePicture: 'https://example.com/profile_picture.png',
    );

    // Create a list of ForumPostEntity with test data
    List<ForumPostEntity> lstForums = [
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
        postedUserId:
            postedUser.userId, // Assuming postedUserId can be a String
        postedFullname: postedUser.fullName,
      ),
      const ForumPostEntity(
        id: "66bf087517b3dcd4106abaa9",
        postPicture: "1723795573188-1000029311.jpg",
        postTitle: "HSHSJSJS",
        postDescription: "jshshsjs",
        postTags: ["jshshshs"],
        postLikes: 1,
        postDislikes: 0,
        postViews: 12,
        postedUserId: "user_4", // Updated to a String user ID for consistency
        postedFullname: "Aashista Karki",
        postComments: [],
        postedTime: "2024-08-16T08:06:13.195Z",
      ),
    ];

    return lstForums;
  }
}
