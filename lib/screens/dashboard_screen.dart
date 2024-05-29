import 'package:flutter/material.dart';
import 'package:playforge/screens/home_screen.dart';
import 'package:playforge/screens/notification_screen.dart';
import 'package:playforge/screens/search_screen.dart';
import 'package:playforge/screens/users_feed_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  List<Widget> lstBottomScreen = [
    HomeScreen(),
    SearchScreen(),
    UsersFeedScreen(),
    NotificationScreen(),

    // Add your other screens here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: lstBottomScreen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: BottomAppBarTheme.of(context).color,
        selectedItemColor: const Color.fromRGBO(48, 255, 81, 1),
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items:
            List.generate(4, (index) => _buildBottomNavigationBarItem(index)),
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(int index) {
    IconData icon;
    String label;

    switch (index) {
      case 0:
        icon = Icons.home;
        label = 'Home';
        break;
      case 1:
        icon = Icons.search;
        label = 'Search';
        break;
      case 2:
        icon = Icons.feed;
        label = 'Your Posts';
        break;
      case 3:
        icon = Icons.notifications;
        label = 'Notification';
        break;
      default:
        icon = Icons.home;
        label = 'Home';
    }

    return BottomNavigationBarItem(
      icon: _buildIconWithBackground(index, icon),
      label: label,
    );
  }

  Widget _buildIconWithBackground(int index, IconData icon) {
    bool isSelected = _selectedIndex == index;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: isSelected
          ? BoxDecoration(
              color: const Color.fromRGBO(48, 255, 81, 1),
              borderRadius: BorderRadius.circular(8),
            )
          : null,
      child: Icon(icon,
          color:
              isSelected ? BottomAppBarTheme.of(context).color : Colors.white),
    );
  }
}
