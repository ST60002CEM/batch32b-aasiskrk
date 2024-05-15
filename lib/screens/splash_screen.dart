import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child:
                      Container(), // Adding an empty container to create space
                ),
                Expanded(
                  flex: 2, // Adjust this ratio as needed
                  child: Image.asset(
                    'assets/images/logowhite.png',
                    // Add margin to move the logo down
                  ),
                ),
                Expanded(
                  flex: 5, // Adjust this ratio as needed
                  child: Image.asset(
                    'assets/images/splashscreen.gif',
                    // Set width to match the screen width
                    height: 450,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                CircularProgressIndicator()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
