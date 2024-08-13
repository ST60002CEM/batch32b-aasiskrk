import 'package:flutter/material.dart';

class CustomForumCard extends StatelessWidget {
  final String postTitle;
  final String postImage;
  final List<String> tags;
  final String postedFullname;
  final int views;
  final int upvotes;
  final int downvotes;
  final int comments;

  CustomForumCard({
    required this.postTitle,
    required this.postImage,
    required this.postedFullname,
    required this.tags,
    required this.views,
    required this.upvotes,
    required this.downvotes,
    required this.comments,
  });
  final String baseUrlPhoto = "http://192.168.18.107:5000/forum/";

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
              '$baseUrlPhoto${postImage ?? ''}',
              width: double.infinity, // Make image span full width
              height: 182, // Set a fixed height for the image
              fit: BoxFit.cover,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey,
                  child:
                      Icon(Icons.broken_image, size: 50, color: Colors.white),
                );
              },
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
                Text(postedFullname),
                SizedBox(
                  height: 5,
                ),
                Wrap(
                  spacing: 5.0,
                  children: tags.map((tag) => Chip(label: Text(tag))).toList(),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
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
