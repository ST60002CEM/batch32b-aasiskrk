import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playforge/features/dashboard/presentation/view/single_post_view.dart';
import 'package:playforge/features/forum/presentation/view/forum_view.dart';
import 'package:playforge/features/dashboard/presentation/viewmodel/forum_view_model.dart';
import 'package:playforge/features/forum/presentation/viewmodel/home_view_model.dart';
import '../../../../core/common/custom_game_card.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../../../app/constants/api_endpoint.dart';
import '../../data/model/forum_api_model.dart';
import '../../domain/entity/forum_entity.dart';
import 'package:intl/intl.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final ScrollController _scrollController = ScrollController();
  int noOfButtons = 0;
  int noOfPosts = 0;
  bool isLoading = false;
  int currentPage = 1;

  String formatDateTime(String isoDate) {
    try {
      final DateTime dateTime = DateTime.parse(isoDate);
      final DateFormat formatter = DateFormat('MMM d, yyyy • h:mm a');
      return formatter.format(dateTime);
    } catch (e) {
      return 'Invalid date';
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var forumState = ref.watch(forumViewModelProvider);
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      noOfButtons = 4;
      noOfPosts = 5;
    } else {
      noOfButtons = 2;
      noOfPosts = 1;
    }

    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          if (_scrollController.position.extentAfter == 0 &&
              !forumState.hasReachedMax) {
            ref.read(forumViewModelProvider.notifier).getAllPosts();
          }
        }
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: DefaultTabController(
            length: 2, // Number of tabs
            child: SafeArea(
              child: Container(
                color: Theme.of(context).canvasColor,
                child: Column(
                  children: [
                    // Custom Tab Bar
                    Container(
                      color: Theme.of(context).canvasColor,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Image.asset('assets/images/Inside.png',
                                height: 30, width: 30),
                          ),
                          Expanded(
                            flex: 6,
                            child: TabBar(
                              tabAlignment: TabAlignment.fill,
                              enableFeedback: true,
                              labelColor: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                              indicatorSize: TabBarIndicatorSize.tab,
                              dividerColor: BottomAppBarTheme.of(context).color,
                              indicatorColor: Colors.green,
                              tabs: const [
                                Tab(text: 'Forum'),
                                Tab(text: 'Games'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Tab Bar View
                    Expanded(
                      child: TabBarView(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Column(
                              children: [
                                Expanded(
                                  child: LiquidPullToRefresh(
                                    showChildOpacityTransition: false,
                                    height: 50,
                                    animSpeedFactor: 2,
                                    color: Theme.of(context).primaryColorDark,
                                    backgroundColor: Colors.green,
                                    onRefresh: () async {
                                      await ref
                                          .read(forumViewModelProvider.notifier)
                                          .resetState();
                                    },
                                    child: GridView.builder(
                                      controller: _scrollController,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: noOfPosts,
                                        crossAxisSpacing: 2,
                                        mainAxisSpacing: 2,
                                        childAspectRatio: 1.07,
                                      ),
                                      itemCount: forumState.posts.length,
                                      itemBuilder: (context, index) {
                                        final post = forumState.posts[index];

                                        return GestureDetector(
                                          onTap: () {
                                            // Navigate to another page with post details
                                            ref
                                                .read(forumViewModelProvider
                                                    .notifier)
                                                .openPostPage(post.id);
                                            ref
                                                .read(forumViewModelProvider
                                                    .notifier)
                                                .viewPost(post.id);
                                            ref.watch(forumViewModelProvider
                                                .notifier);
                                          },
                                          child: Card(
                                            margin: EdgeInsets.all(0),
                                            elevation: 0,
                                            color: Theme.of(context)
                                                .primaryColorDark,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
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
                                                                    fontSize:
                                                                        16,
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
                                                                      fontSize:
                                                                          12,
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
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 15.0,
                                                  ),
                                                  child: Text(
                                                    post.postTitle,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w900,
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
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
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
                                                                  .read(forumViewModelProvider
                                                                      .notifier)
                                                                  .likePost(
                                                                      post.id);
                                                            },
                                                          ),
                                                          Text(
                                                              '${post.postLikes}'),
                                                          IconButton(
                                                            icon: const Icon(
                                                              Icons.thumb_down,
                                                              size: 18,
                                                            ),
                                                            onPressed: () {
                                                              ref
                                                                  .read(forumViewModelProvider
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
                                                            onPressed: () {
                                                              ref
                                                                  .read(forumViewModelProvider
                                                                      .notifier)
                                                                  .openPostPage(
                                                                      post.id);
                                                            },
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
                                                                      fontSize:
                                                                          12),
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
                                ),
                                if (forumState.isLoading)
                                  const LinearProgressIndicator(
                                      color: Colors.green),
                              ],
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: noOfButtons,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                  childAspectRatio: 0.9,
                                ),
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return CustomGameCard(
                                    gameName: 'Game Title $index',
                                    gameImage:
                                        'https://via.placeholder.com/800x400',
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            elevation: 10,
            tooltip: "Add Post",
            enableFeedback: true,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            foregroundColor: BottomAppBarTheme.of(context).color,
            backgroundColor: const Color.fromRGBO(48, 255, 81, 1),
            splashColor: Colors.white60,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ForumView()));
            },
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        ),
      ),
    );
  }
}
