import 'package:flutter/material.dart';

class CustomForumCard extends StatelessWidget {
  final String postTitle;
  final String postImage;
  final List<String> tags;
  // final String profileImage;
  final int views;
  final int upvotes;
  final int downvotes;
  final int comments;

  CustomForumCard({
    required this.postTitle,
    required this.postImage,
    required this.tags,
    // required this.profileImage,
    required this.views,
    required this.upvotes,
    required this.downvotes,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color:
          BottomAppBarTheme.of(context).color, // Background color of the card
      elevation: 4,
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(15)), // Rounded corners for the image
            child: Image.network(
              postImage,
              width: double.infinity, // Make image span full width
              height: 200, // Set a fixed height for the image
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  postTitle,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Wrap(
                  spacing: 5.0,
                  children: tags.map((tag) => Chip(label: Text(tag))).toList(),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    // CircleAvatar(
                    //   backgroundImage: NetworkImage(profileImage),
                    // ),
                    SizedBox(width: 10),
                    Text(
                      'Views: $views',
                      style: TextStyle(fontSize: 16),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.thumb_up),
                      onPressed: () {},
                    ),
                    Text('$upvotes'),
                    IconButton(
                      icon: Icon(Icons.thumb_down),
                      onPressed: () {},
                    ),
                    Text('$downvotes'),
                    IconButton(
                      icon: Icon(Icons.comment),
                      onPressed: () {},
                    ),
                    Text('$comments'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
