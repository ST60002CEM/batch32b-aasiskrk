import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:playforge/features/auth/data/model/auth_hive_model.dart';
import '../../../app/constants/hive_table_constant.dart';
import '../../../features/dashboard/data/model/forum_hive_model.dart';

final hiveServiceProvider = Provider((ref) => HiveService());

class HiveService {
  Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    // Register Adapters
    Hive.registerAdapter(AuthHiveModelAdapter());
    Hive.registerAdapter(ForumHiveModelAdapter());
  }

  // User methods
  Future<void> addUser(AuthHiveModel user) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.put(user.userId, user);
  }

  Future<AuthHiveModel?> login(String email, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    var user = box.values.firstWhere(
        (element) => element.email == email && element.password == password);
    box.close();
    return user;
  }

  Future<List<AuthHiveModel>> getAllUsers() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    var users = box.values.toList();
    box.close();
    return users;
  }

  // Forum methods
  Future<void> addForumPost(ForumHiveModel post) async {
    var box =
        await Hive.openBox<ForumHiveModel>(HiveTableConstant.forumPostBox);
    await box.put(post.postId, post);
  }

  Future<List<ForumHiveModel>> getAllForumPosts(int page) async {
    var box =
        await Hive.openBox<ForumHiveModel>(HiveTableConstant.forumPostBox);
    var posts = box.values.toList();
    box.close();
    return posts;
  }

  Future<ForumHiveModel?> getForumPost(String postId) async {
    var box =
        await Hive.openBox<ForumHiveModel>(HiveTableConstant.forumPostBox);
    var post = box.get(postId);
    box.close();
    return post;
  }
}
