import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:playforge/core/shared_prefs/user_shared_prefs.dart';

import '../../../../app/constants/api_endpoint.dart';
import '../../../../core/common/custom_game_card.dart';
import '../../../dashboard/presentation/viewmodel/forum_view_model.dart';

class UsersFeedScreen extends ConsumerStatefulWidget {
  const UsersFeedScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UsersFeedScreen> createState() => _UsersFeedScreenState();
}

class _UsersFeedScreenState extends ConsumerState<UsersFeedScreen> {
  UserSharedPrefs? userSharedPrefs;
  final ScrollController _scrollController = ScrollController();
  int noOfButtons = 0;
  int noOfPosts = 0;

  @override
  void initState() {
    super.initState();
    _fetchUserPosts();
    userSharedPrefs;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _fetchUserPosts();
    super.dispose();
  }

  Future<void> _fetchUserPosts() async {
    final userId = await userSharedPrefs
        ?.getUserId(); // Replace this with the actual way to get userId
    await ref
        .read(forumViewModelProvider.notifier)
        .getUsersPosts(userId.toString());
  }

  @override
  Widget build(BuildContext context) {
    final forumState = ref.watch(forumViewModelProvider);

    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      noOfButtons = 4;
      noOfPosts = 5;
    } else {
      noOfButtons = 2;
      noOfPosts = 1;
    }

    return SafeArea(
      child: SizedBox.expand(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(47.0),
            child: AppBar(
              title: const Text(
                "Your Posts",
                style: TextStyle(fontSize: 16),
              ),
              centerTitle: true,
              backgroundColor: BottomAppBarTheme.of(context).color,
              elevation: 0,
            ),
          ),
          body: LiquidPullToRefresh(
            showChildOpacityTransition: false,
            height: 50,
            animSpeedFactor: 2,
            color: Theme.of(context).canvasColor,
            backgroundColor: Colors.green,
            onRefresh: () async {
              await ref.read(forumViewModelProvider.notifier).resetState();
            },
            child: DefaultTabController(
              length: 2, // Number of tabs
              child: SafeArea(
                child: Container(
                  color: Theme.of(context).canvasColor,
                  child: Column(
                    children: [
                      Expanded(
                        child: forumState.isLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : forumState.userPosts.isEmpty
                                ? const Center(
                                    child: Text("No posts found"),
                                  )
                                : GridView.builder(
                                    controller: _scrollController,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: noOfPosts,
                                      crossAxisSpacing: 5,
                                      mainAxisSpacing: 5,
                                      childAspectRatio: 1,
                                    ),
                                    itemCount: forumState.userPosts.length,
                                    itemBuilder: (context, index) {
                                      final post = forumState.userPosts[index];
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                            '${ApiEndpoints.imageBaseUrl}${post.postPicture ?? ''}',
                                            width: double.infinity,
                                            height: 182,
                                            fit: BoxFit.cover,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  post.postTitle,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                Text(post.postedFullname),
                                                const SizedBox(height: 5),
                                                Wrap(
                                                  spacing: 5.0,
                                                  children: post.postTags
                                                      .map((tag) => Chip(
                                                          label: Text(tag)))
                                                      .toList(),
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    const SizedBox(width: 10),
                                                    Text(
                                                      'Views: ${post.postViews}',
                                                      style: const TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                    const Spacer(),
                                                    IconButton(
                                                      icon: const Icon(
                                                          Icons.thumb_up),
                                                      onPressed: () {},
                                                    ),
                                                    Text('${post.postLikes}'),
                                                    IconButton(
                                                      icon: const Icon(
                                                          Icons.thumb_down),
                                                      onPressed: () {},
                                                    ),
                                                    Text(
                                                        '${post.postDislikes}'),
                                                    IconButton(
                                                      icon: const Icon(
                                                          Icons.comment),
                                                      onPressed: () {},
                                                    ),
                                                    Text(
                                                        '${post.postComments.length}'),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
