import 'dart:convert';

import 'package:bears_palace_app/colors.dart';
import 'package:bears_palace_app/pages/day_visits_page.dart';
import 'package:bears_palace_app/screens/activation/activate_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool isLoading = false;
  var _userInfo;

  _getCurrentUserDetails()  async{

    FirebaseAuth.instance
        .authStateChanges()
        .listen((User user) async {
      if (user == null) {
        // print('User is currently signed out!');
      } else {
        FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            setState(() {
              _userInfo = documentSnapshot.data();
            });

          } else {
            print('Document does not exist on the database with UID:' + user.uid);
          }
        });
      }
    });

  }

  @override
  void initState() {
    super.initState();
    _getCurrentUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    _getCurrentUserDetails();
    return Scaffold(
      drawer: sideDrawer(context),
      appBar: AppBar(
        backgroundColor: Color(int.parse(AppColors.primaryColor)),
        title: Text('Bears Palace'),
        actions: [
          Icon(Icons.notification_important),
          SizedBox(width: 5,)
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: _userInfo !=null? Text('Hello, '+  _userInfo['displayName'] ):  Text('Hello, Guest'),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Your have Bears Bucks'),
                        ListTile(
                          title: _userInfo!=null? Text(_userInfo['points'].toString() +' BB', style: TextStyle(
                            fontSize: 28
                          ),): Text('0.00 BB', style: TextStyle(
                              fontSize: 28
                          ),),
                          trailing: OutlineButton(
                            child: Text('Redeem'),
                          ),
                        ),
                        _userInfo !=null && _userInfo['status']== 'ACTIVATED'? Container(): Text('Your account has not been activated. Please activate account to use full app features'),
                        _userInfo !=null && _userInfo['status']== 'ACTIVATED'? Container(): RaisedButton(onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ActivateProfile()),
                          );
                        },
                        child: Text('Activate Profile'),)
                      ],
                    ),
                  ),
                ),SizedBox(height: 25,),
                Column(
                  children: [
                    GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DayVisitsPage()),
                          );
                        },
                        child: Image.asset('assets/images/day_visit.jpg')),
                    SizedBox(height: 10,),
                    Image.asset('assets/images/bookings.jpg'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget sideDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/app_logo.png',),
                fit: BoxFit.cover,
              )
            ),
            child: Text("Header"),

          ),
          ListTile(
            title: Text("Home"),
          ),
          ListTile(
            title: Text("Home"),
          ),
          ListTile(
            title: Text("Home"),
          ),
          Divider(),
          ListTile(
            title: Text('App version 1.0.0'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
