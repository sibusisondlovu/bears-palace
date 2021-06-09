import 'package:bears_palace_app/root_layout_screen.dart';
import 'package:flutter/material.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Bears Palace',
      theme: ThemeData(fontFamily: 'Regular'),
      home: RootLayoutScreen()
    );
  }
}



