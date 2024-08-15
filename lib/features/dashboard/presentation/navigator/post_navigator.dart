import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playforge/features/dashboard/presentation/view/single_post_view.dart';
import 'package:riverpod/riverpod.dart';
import '../../../../app/navigator/navigator.dart';

final postViewNavigatorProvider =
    Provider<PostViewNavigator>((ref) => PostViewNavigator());

class PostViewNavigator {}

mixin PostViewRoute {
  void openPostDetailsView(String postId) {
    NavigateRoute.pushRoute(SinglePostView(postId: postId));
  }
}
