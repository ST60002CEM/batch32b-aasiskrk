import 'package:flutter/material.dart';

class CustomGameCard extends StatelessWidget {
  final String gameName;
  final String gameImage;

  CustomGameCard({
    required this.gameName,
    required this.gameImage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color:
          BottomAppBarTheme.of(context).color, // Background color of the card
      elevation: 0,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20)), // Rounded corners for the image
            child: Image.network(
              gameImage,
              width: double.infinity, // Make image span full width
              height: 140, // Set a fixed height for the image
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              gameName,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
