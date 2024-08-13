class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);

  static const String baseUrl = "http://192.168.1.66:5000/api/";
  static const String imageBaseUrl = "http://192.168.1.66:5000/forum/";
  static const String profileImageUrl = "http://192.168.1.66:5000/profile/";
  //static const String baseUrl = "http://192.168.4.4:3000/api/v1/";

  static const limitPage = 5;

  // ====================== Auth Routes ======================
  static const String login = "user/login";
  static const String register = "user/create";
  // static const String getAllUser = "auth/getAllUsers";
  // static const String updateUser = "auth/updateUser/";
  // static const String deleteUser = "auth/deleteUser/";
  // static const String imageUrl = "http://10.0.2.2:5000/uploads/";
  static const String uploadImage = "auth/uploadImage";
  static const String currentUser = "user/get_user/";

  // ====================== Forum Routes ======================
  static const String search = "forum/search";
  static const String createPost = "forum/create";
  static const String getAllForumPosts = "forum/get_all_post";
  static const String getPagination = "forum/pagination";
  static const String getSingleForumPost = "forum/get_single_post/";
  static const String getUserPost = "forum/user_posts/";

  static const String editPost = "forum/edit_post/";
  static const String deletePost = "forum/delete_post/";
  static const String addComment = "forum/add_comment/";
  static const String deleteComment = "forum/delete_comment/";
  static const String getDetails = "forum/getDetails/";
}
