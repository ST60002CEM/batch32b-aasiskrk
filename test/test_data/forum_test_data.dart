import 'package:playforge/features/dashboard/domain/entity/forum_entity.dart';

class ForumTestData {
  ForumTestData._();

  static List<ForumPostEntity> getForumTestData() {
    List<ForumPostEntity> lstForums = [
      const ForumPostEntity(
        postPicture: "1719126707658-wp4020212-dedsec-wallpapers.jpg",
        postTitle: "This is new title",
        postDescription: "This is desc",
        postTags: ["Tag1, tag2"],
        postComments: [],
        postLikes: 0,
        postDislikes: 0,
        postViews: 0,
        postedTime: "2024-06-23T07:11:47.676Z",
        postedUserId: "667406e9054482ecdd1c0890",
        postedFullname: "Aashista Karki",
      ),
      const ForumPostEntity(
        postPicture: "1719221994016-profile.png",
        postTitle: "new forum post ",
        postDescription: "testing ",
        postTags: ["tags 1 "],
        postComments: [],
        postLikes: 0,
        postDislikes: 0,
        postViews: 0,
        postedTime: "2024-06-24T09:39:54.030Z",
        postedUserId: "667406e9054482ecdd1c0890",
        postedFullname: "Aashista Karki",
      ),
    ];
    return lstForums;
  }
}
