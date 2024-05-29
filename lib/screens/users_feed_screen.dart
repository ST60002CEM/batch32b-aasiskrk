import 'package:flutter/material.dart';

class UsersFeedScreen extends StatefulWidget {
  const UsersFeedScreen({super.key});

  @override
  State<UsersFeedScreen> createState() => _UsersFeedScreenState();
}

class _UsersFeedScreenState extends State<UsersFeedScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox.expand(
        child: Column(
          children: [Text("Your feed is empty")],
        ),
      ),
    );
  }
}
