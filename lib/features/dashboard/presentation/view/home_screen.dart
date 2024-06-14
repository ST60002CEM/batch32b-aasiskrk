import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playforge/core/common/custom_forum_card.dart';
import '../../../../core/common/custom_game_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int noOfButtons = 0;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      noOfButtons = 4;
    } else {
      noOfButtons = 2;
    }

    return Scaffold(
      body: DefaultTabController(
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
                          labelColor:
                              Theme.of(context).brightness == Brightness.dark
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
                      SingleChildScrollView(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(maxHeight: 390),
                                child: CustomForumCard(
                                  postTitle:
                                      "Mobile Legends yet another Update!",
                                  postImage:
                                      "https://enazoapps.com/wp-content/uploads/2024/01/MOBILE-LEGENDS-BANG-BANG-MOD-APK-2.webp",
                                  tags: const ["Action", "Multiplayer"],
                                  profileImage:
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAHzOeCh-5vdpkA3FKLvVcIajDKBtIV3EXAHNBpTXxXw&s",
                                  views: 2131,
                                  upvotes: 200,
                                  downvotes: 35,
                                  comments: 10,
                                ),
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints(maxHeight: 390),
                                child: CustomForumCard(
                                  postTitle: "Top 15 Best Online RPG",
                                  postImage:
                                      "https://english.makalukhabar.com/wp-content/uploads/2023/06/PUBG-MK.jpg",
                                  tags: const [
                                    "Battle Royale",
                                    "Multiplayer",
                                  ],
                                  profileImage:
                                      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                                  views: 1230,
                                  upvotes: 20,
                                  downvotes: 5,
                                  comments: 1,
                                ),
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints(maxHeight: 390),
                                child: CustomForumCard(
                                  postTitle: "Blue Lock Blaze Battle Gameplay",
                                  postImage:
                                      "https://o.qoo-img.com/storage.qoo-img.com/game/22523/023E33SVvRLaUhw9bf2v1zYGvikHi0q6.jpg?w=800",
                                  tags: const ["Multiplayer"],
                                  profileImage:
                                      "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg",
                                  views: 2310,
                                  upvotes: 210,
                                  downvotes: 15,
                                  comments: 30,
                                ),
                              ),
                            ],
                          ),
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
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
    );
  }
}
