import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playforge/features/forum/presentation/view/forum_view.dart';
import 'package:playforge/features/dashboard/presentation/viewmodel/forum_view_model.dart';
import '../../../../core/common/custom_game_card.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../../../app/constants/api_endpoint.dart';

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
          // Scroll garda feri last ma ho ki haina bhanera check garne ani data call garne
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
                    // Logo at the top

                    // Custom Tab Bar
                    Container(
                      color: BottomAppBarTheme.of(context).color,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Image.asset('assets/images/Inside.png',
                                height: 30,
                                width: 30 // Adjust the height as needed
                                ),
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
                                    color: Theme.of(context).canvasColor,
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
                                        crossAxisSpacing: 5,
                                        mainAxisSpacing: 5,
                                        childAspectRatio: 1,
                                      ),
                                      itemCount: forumState.posts.length,
                                      itemBuilder: (context, index) {
                                        final post = forumState.posts[index];
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.network(
                                              '${ApiEndpoints.imageBaseUrl}${(post.postPicture).toString() ?? 'https://via.placeholder.com/800x400'}',
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
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                ),
                                if (forumState.isLoading)
                                  const CircularProgressIndicator(
                                      color: Colors.red),
                              ],
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Expanded(
                                child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        noOfButtons, // Number of buttons per row
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5,
                                    childAspectRatio:
                                        0.9, // Adjust based on card size
                                  ),
                                  itemCount: 10, // Number of items in your grid
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
            // mini: true,
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
            child: const Icon(
              Icons.add,
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        ),
      ),
    );
  }
}
