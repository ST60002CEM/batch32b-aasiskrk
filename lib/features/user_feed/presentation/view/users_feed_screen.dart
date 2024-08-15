import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:playforge/core/shared_prefs/user_shared_prefs.dart';

import '../../../../app/constants/api_endpoint.dart';
import '../../../../core/common/custom_game_card.dart';
import '../../../dashboard/presentation/viewmodel/forum_view_model.dart';
import '../../../forum/presentation/view/forum_view.dart';

class UsersFeedScreen extends ConsumerStatefulWidget {
  const UsersFeedScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UsersFeedScreen> createState() => _UsersFeedScreenState();
}

class _UsersFeedScreenState extends ConsumerState<UsersFeedScreen> {
  String formatDateTime(String isoDate) {
    try {
      final DateTime dateTime = DateTime.parse(isoDate);
      final DateFormat formatter = DateFormat('MMM d, yyyy • h:mm a');
      return formatter.format(dateTime);
    } catch (e) {
      return 'Invalid date';
    }
  }

  UserSharedPrefs? userSharedPrefs;
  final ScrollController _scrollController = ScrollController();
  int noOfButtons = 0;
  int noOfPosts = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   ref.read(forumViewModelProvider.notifier).getUsersPosts();
  //   userSharedPrefs;
  // }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
              backgroundColor: Theme.of(context).canvasColor,
              elevation: 0,
            ),
          ),
          body: Container(
            color: Theme.of(context).primaryColorDark,
            child: LiquidPullToRefresh(
              showChildOpacityTransition: false,
              height: 50,
              animSpeedFactor: 2,
              color: Theme.of(context).primaryColorDark,
              backgroundColor: Colors.green,
              onRefresh: () async {
                ref.read(forumViewModelProvider.notifier).resetState();
              },
              child: SafeArea(
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
                                    crossAxisSpacing: 2,
                                    mainAxisSpacing: 2,
                                    childAspectRatio: 1.05,
                                  ),
                                  itemCount: forumState.userPosts.length,
                                  itemBuilder: (context, index) {
                                    final post = forumState.userPosts[index];

                                    return GestureDetector(
                                      onTap: () {
                                        // Navigate to another page with post details
                                        ref
                                            .read(
                                                forumViewModelProvider.notifier)
                                            .openPostPage(post.id);
                                      },
                                      child: Card(
                                        margin: EdgeInsets.all(0),
                                        elevation: 0,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 7),
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(
                                                      post.postedUserId
                                                                  ?.profilePicture !=
                                                              null
                                                          ? '${ApiEndpoints.profileImageUrl}${post.postedUserId?.profilePicture}'
                                                          : 'https://via.placeholder.com/800x400',
                                                    ),
                                                    radius: 20,
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              post.postedFullname,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            Text(
                                                                formatDateTime(post
                                                                    .postedTime),
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .grey,
                                                                )),
                                                          ],
                                                        ),
                                                        Wrap(
                                                          spacing: 5.0,
                                                          children: post
                                                              .postTags
                                                              .map((tag) => Chip(
                                                                  label: Text(
                                                                      tag)))
                                                              .toList(),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 15.0,
                                              ),
                                              child: Text(
                                                post.postTitle,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w900,
                                                    fontFamily:
                                                        'Times new roman'),
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Image.network(
                                              '${ApiEndpoints.imageBaseUrl}${post.postPicture ?? 'https://via.placeholder.com/800x400'}',
                                              width: double.infinity,
                                              height: 213,
                                              fit: BoxFit.cover,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(height: 5),
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                        icon: const Icon(
                                                          Icons.thumb_up,
                                                          size: 18,
                                                        ),
                                                        onPressed: () {
                                                          ref
                                                              .read(
                                                                  forumViewModelProvider
                                                                      .notifier)
                                                              .likePost(
                                                                  post.id);
                                                        },
                                                      ),
                                                      Text('${post.postLikes}'),
                                                      IconButton(
                                                        icon: const Icon(
                                                          Icons.thumb_down,
                                                          size: 18,
                                                        ),
                                                        onPressed: () {
                                                          ref
                                                              .read(
                                                                  forumViewModelProvider
                                                                      .notifier)
                                                              .dislikePost(
                                                                  post.id);
                                                        },
                                                      ),
                                                      Text(
                                                          '${post.postDislikes}'),
                                                      IconButton(
                                                        icon: const Icon(
                                                          Icons.comment,
                                                          size: 18,
                                                        ),
                                                        onPressed: () {},
                                                      ),
                                                      Text(
                                                          '${post.postComments.length}'),
                                                      const Spacer(),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 10),
                                                        child: Text(
                                                          'Views: ${post.postViews}',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 12),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Divider(
                                              height: 1,
                                              color: Colors.white54,
                                            ),
                                          ],
                                        ),
                                      ),
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
    );
  }
}
