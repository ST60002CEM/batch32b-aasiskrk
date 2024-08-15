import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playforge/features/dashboard/presentation/viewmodel/forum_view_model.dart';
import 'package:playforge/features/profile/presentation/viewmodel/profile_viewmodel.dart';
import '../../../../core/shared_prefs/user_shared_prefs.dart';
import '../viewmodel/splash_view_model.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  UserSharedPrefs? userSharedPrefs;

  @override
  void initState() {
    super.initState();
    userSharedPrefs;
    // Trigger the openLoginView method from the ViewModel
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(splashViewModelProvider.notifier).checkAuthStatus();
      ref.read(forumViewModelProvider.notifier).getAllPosts();
      ref.read(profileViewModelProvider.notifier).getCurrentUser();
      ref.read(forumViewModelProvider.notifier).getUsersPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Center(
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
                        Theme.of(context).brightness == Brightness.dark
                            ? 'assets/images/logowhite.png'
                            : 'assets/images/logoblack.png',
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
                  ],
                ),
              ),
            ),
            const Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                  strokeWidth: 4,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
