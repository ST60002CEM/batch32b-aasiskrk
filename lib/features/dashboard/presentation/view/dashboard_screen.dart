import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playforge/features/dashboard/presentation/view/home_view.dart';
import 'package:playforge/features/dashboard/presentation/view/notification_screen.dart';
import 'package:playforge/features/dashboard/presentation/view/search_screen.dart';
import 'package:playforge/features/dashboard/presentation/view/users_feed_screen.dart';
import 'package:all_sensors2/all_sensors2.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  int _selectedIndex = 0;
  List<Widget> lstBottomScreen = [
    HomeView(),
    SearchScreen(),
    UsersFeedScreen(),
    NotificationScreen(),
    // Add your other screens here
  ];

  final double shakeThreshold = 19.0;
  List<double> _accelerometerValues = [0, 0, 0];
  bool _isBottomSheetOpen = false;

  @override
  void initState() {
    super.initState();
    accelerometerEvents?.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValues = [event.x, event.y, event.z];
        if (isShaking(_accelerometerValues)) {
          if (!_isBottomSheetOpen) {
            _showReportBottomSheet();
          }
        }
      });
    });
  }

  bool isShaking(List<double> values) {
    double acceleration =
        values[0] * values[0] + values[1] * values[1] + values[2] * values[2];
    return acceleration > shakeThreshold * shakeThreshold;
  }

  void _showReportBottomSheet() {
    _isBottomSheetOpen = true;
    showModalBottomSheet(
      context: context,
      elevation: 5,
      backgroundColor: BottomAppBarTheme.of(context).color,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Text('Shake to Report',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 16),
              Center(
                  child: Text(
                      'Do you want to report a bug or leave a suggestion?')),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Handle report bug action
                  Navigator.pop(context);
                },
                child: Text(
                  'Report Bug',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8), // Less rounded corners
                  ),
                  backgroundColor: const Color.fromRGBO(
                      48, 255, 81, 1), // Green accent color
                ),
              ),
              SizedBox(height: 10), // Add some space between buttons
              ElevatedButton(
                onPressed: () {
                  // Handle suggest something action
                  Navigator.pop(context);
                },
                child: Text(
                  'Suggest Something',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8), // Less rounded corners
                  ),
                  backgroundColor: const Color.fromRGBO(
                      48, 255, 81, 1), // Green accent color
                ),
              ),
            ],
          ),
        );
      },
    ).whenComplete(() {
      _isBottomSheetOpen = false;
    });
  }

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
