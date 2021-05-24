import 'package:bears_palace_app/root_layout_screen.dart';
import 'package:bears_palace_app/screens/book_screen.dart';
import 'package:bears_palace_app/screens/onboarding_screen.dart';
import 'package:bears_palace_app/screens/room_booking_screen.dart';
import 'package:bears_palace_app/screens/room_search_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Bears Palace',
      theme: ThemeData(fontFamily: 'Regular'),
      home: RoomBookingScreen()
    );
  }
}



