import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playforge/core/common/custom_forum_card.dart';
import '../../../../core/common/custom_game_card.dart';
import '../viewmodel/forum_view_model.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final ScrollController _scrollController = ScrollController();
  int noOfButtons = 0;
  int noOfPosts = 0;

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
      noOfPosts = 2;
    } else {
      noOfButtons = 2;
      noOfPosts = 1;
    }

    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          // Scroll garda feri last ma ho ki haina bhanera check garne ani data call garne
          if (_scrollController.position.extentAfter == 0) {
            ref.read(forumViewModelProvider.notifier).getAllForumPosts();
          }
        }
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: LiquidPullToRefresh(
            showChildOpacityTransition: false,
            height: 50,
            animSpeedFactor: 2,
            color: Colors.green,
            backgroundColor: Colors.black,
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
                      // Custom Tab Bar
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.menu),
                              onPressed: () {
                                // Implement your menu functionality here
                              },
                            ),
                            Expanded(
                              child: TabBar(
                                padding: EdgeInsets.symmetric(horizontal: 60),
                                tabAlignment: TabAlignment.fill,
                                labelColor: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                                indicatorSize: TabBarIndicatorSize.tab,
                                dividerColor: Theme.of(context).canvasColor,
                                indicatorColor: Colors.green,
                                tabs: const [
                                  Tab(text: 'Forum'),
                                  Tab(text: 'Games'),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.person),
                              onPressed: () {
                                // Implement your profile functionality here
                              },
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
                                        return CustomForumCard(
                                          postTitle: post.postTitle,
                                          postImage: post.postPicture,
                                          tags: post.postTags,
                                          // profileImage: post.postPicture,
                                          views: post.postViews,
                                          upvotes: post.postLikes,
                                          downvotes: post.postDislikes,
                                          comments: post.postLikes,
                                        );
                                      },
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
                                padding: EdgeInsets.all(10),
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          foregroundColor: Colors.white,
          backgroundColor: Colors.green,
          splashColor: Colors.white60,
          onPressed: () {
            // Implement your FAB functionality here
          },
          child: Icon(
            Icons.add,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
//ConstrainedBox(
//                                   constraints: BoxConstraints(maxHeight: 390),
//                                   child: CustomForumCard(
//                                     postTitle:
//                                         "Mobile Legends yet another Update!",
//                                     postImage:
//                                         "https://enazoapps.com/wp-content/uploads/2024/01/MOBILE-LEGENDS-BANG-BANG-MOD-APK-2.webp",
//                                     tags: const ["Action", "Multiplayer"],
//                                     profileImage:
//                                         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAHzOeCh-5vdpkA3FKLvVcIajDKBtIV3EXAHNBpTXxXw&s",
//                                     views: 2131,
//                                     upvotes: 200,
//                                     downvotes: 35,
//                                     comments: 10,
//                                   ),
//                                 ),
//                                 ConstrainedBox(
//                                   constraints: BoxConstraints(maxHeight: 390),
//                                   child: CustomForumCard(
//                                     postTitle: "Top 15 Best Online RPG",
//                                     postImage:
//                                         "https://english.makalukhabar.com/wp-content/uploads/2023/06/PUBG-MK.jpg",
//                                     tags: const [
//                                       "Battle Royale",
//                                       "Multiplayer",
//                                     ],
//                                     profileImage:
//                                         "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
//                                     views: 1230,
//                                     upvotes: 20,
//                                     downvotes: 5,
//                                     comments: 1,
//                                   ),
//                                 ),
//                                 ConstrainedBox(
//                                   constraints: BoxConstraints(maxHeight: 390),
//                                   child: CustomForumCard(
//                                     postTitle:
//                                         "Blue Lock Blaze Battle Gameplay",
//                                     postImage:
//                                         "https://o.qoo-img.com/storage.qoo-img.com/game/22523/023E33SVvRLaUhw9bf2v1zYGvikHi0q6.jpg?w=800",
//                                     tags: const ["Multiplayer"],
//                                     profileImage:
//                                         "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg",
//                                     views: 2310,
//                                     upvotes: 210,
//                                     downvotes: 15,
//                                     comments: 30,
//                                   ),
//                                 ),
