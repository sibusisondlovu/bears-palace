import 'package:bears_palace_app/colors.dart';
import 'package:bears_palace_app/screens/account_screen.dart';
import 'package:bears_palace_app/screens/book_screen.dart';
import 'package:bears_palace_app/screens/home_screen.dart';
import 'package:bears_palace_app/screens/photos_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class RootLayoutScreen extends StatefulWidget {
  @override
  _RootLayoutScreenState createState() => _RootLayoutScreenState();
}

class _RootLayoutScreenState extends State<RootLayoutScreen> {
  int _currentIndex = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  final tabs = [
    HomeScreen(),
    BookScreen(),
    PhotoScreen(),
    AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.explore,color: Color(int.parse(AppColors.primaryColor))),
          title: Text(
            'Discover', style: TextStyle(
              color: Color(int.parse(AppColors.primaryColor))
          ),
          ),

          ),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today_outlined,
              color: Color(int.parse(AppColors.primaryColor))),
            title: Text(
              'My Bookings', style: TextStyle(
                color: Color(int.parse(AppColors.primaryColor))
            ),
            ),
          ),
          BottomNavigationBarItem(icon: Icon(Icons.chat,color: Color(int.parse(AppColors.primaryColor))),
            title: Text(
              'Bears Chat', style: TextStyle(
                color: Color(int.parse(AppColors.primaryColor))
            ),
            ),
          ),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle,color: Color(int.parse(AppColors.primaryColor))),
            title: Text(
              'Account', style: TextStyle(
                color: Color(int.parse(AppColors.primaryColor))
            ),
            ),
          ),
        ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _currentIndex,
          iconSize: 30,
          onTap: _onItemTapped,
          elevation: 5
      ),
    );
  }
}
