import 'package:flutter/material.dart';

class RoomSearchResultsScreen extends StatefulWidget {
  const RoomSearchResultsScreen({Key key}) : super(key: key);

  @override
  _RoomSearchResultsScreenState createState() => _RoomSearchResultsScreenState();
}

class _RoomSearchResultsScreenState extends State<RoomSearchResultsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: ListTile(
            title: Text('Presedential Suite Roo'),
          ),
        ));
  }
}
