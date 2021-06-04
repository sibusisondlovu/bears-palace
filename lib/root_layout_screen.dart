import 'package:bears_palace_app/colors.dart';
import 'package:bears_palace_app/screens/account_screen.dart';
import 'package:bears_palace_app/screens/book_screen.dart';
import 'package:bears_palace_app/screens/chat/chats_screen.dart';
import 'package:bears_palace_app/screens/explore_screen.dart';
import 'package:bears_palace_app/screens/home_screen.dart';
import 'package:bears_palace_app/screens/photos_screen.dart';
import 'package:bears_palace_app/screens/resort_screen.dart';
import 'package:bears_palace_app/screens/restaurant_screen.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
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
    RestaurantScreen(),
    ExploreScreen(),
    AccountScreen(),
    ResortScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.3),
       // toolbarHeight: 70,
        title: Image.asset('assets/images/app_bar_logo.png', height: 50,),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipOval(
            child: Image.asset(
              'assets/images/default_profile_avatar.jpg',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
        ),
        actions: [
          Icon(Icons.notification_important_sharp, color: Colors.cyan,)
          ],
      ),
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
            label: 'Restaurant',
            icon: Icon(Icons.food_bank_outlined,
                color: Color(int.parse(AppColors.primaryColor))),

          ),
          BottomNavigationBarItem(
            label: 'Explore',
            icon: Icon(Icons.map_outlined,
                color: Color(int.parse(AppColors.primaryColor))),

          ),
          BottomNavigationBarItem(
            label: 'Rewards',
            icon: Icon(Icons.wallet_giftcard,
                color: Color(int.parse(AppColors.primaryColor))),

          ),
          BottomNavigationBarItem(
            label: 'Resort',
            icon: Icon(Icons.house_siding,
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
