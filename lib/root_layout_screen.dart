import 'package:bears_palace_app/colors.dart';
import 'package:bears_palace_app/screens/account_screen.dart';
import 'package:bears_palace_app/screens/book_screen.dart';
import 'package:bears_palace_app/screens/chat/chats_screen.dart';
import 'package:bears_palace_app/screens/home_screen.dart';
import 'package:bears_palace_app/screens/photos_screen.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

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
    ChatsScreen(),
    AccountScreen(),
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
          BottomNavigationBarItem(
            label: 'Home',
            activeIcon: null,
            icon: Icon(Icons.home_filled,
                color: Color(int.parse(AppColors.primaryColor))),

          ),
          BottomNavigationBarItem(
            label: 'Dinning',
            icon: Icon(Icons.food_bank_outlined,
                color: Color(int.parse(AppColors.primaryColor))),

          ),
          BottomNavigationBarItem(
            label: 'Resort',
            icon: Icon(Icons.house_outlined,
                color: Color(int.parse(AppColors.primaryColor))),

          ),
          BottomNavigationBarItem(
            label: 'Rewards',
            icon: Icon(Icons.wallet_giftcard,
                color: Color(int.parse(AppColors.primaryColor))),

          ),
          BottomNavigationBarItem(
            label: 'Me',
            icon: Icon(Icons.person,
                color: Color(int.parse(AppColors.primaryColor))),

          ),

        ],
          selectedItemColor: Colors.blueAccent,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold
          ),
          unselectedItemColor: Colors.blueGrey,
          showUnselectedLabels: true,
          unselectedFontSize: 12,
          type: BottomNavigationBarType.shifting,
          currentIndex: _currentIndex,
          iconSize: 30,
          onTap: _onItemTapped,
          elevation: 5
      ),
    );
  }
}
