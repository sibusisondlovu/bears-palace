import 'dart:convert';

import 'package:bears_palace_app/colors.dart';
import 'package:bears_palace_app/pages/day_visits_page.dart';
import 'package:bears_palace_app/screens/activation/activate_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  var _userInfo;

  _getCurrentUserDetails() async {
    FirebaseAuth.instance.authStateChanges().listen((User user) async {
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
            print(
                'Document does not exist on the database with UID:' + user.uid);
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _getCurrentUserDetails();
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black12,
          body: Column(children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              child: Container(
                color: Colors.black,
                child: Opacity(
                    opacity: 0.3,
                    child: Image.asset('assets/images/home_screen_bg.jpg')),
              ),
            ),
            SizedBox(height: 5,),
            Container(
              height: 130,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(10),
                children: <Widget>[
                  Container(
                    width: 150,
                      height: 90,
                      child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        color: Colors.blueAccent,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.work, size: 50,color: Colors.white,),
                                Text('Check In', style: TextStyle(
                                  color: Colors.white
                                ),),
                              ],
                            ),
                          ))),

                  Container(
                      width: 150,
                      height: 90,
                      child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.airline_seat_flat, size: 50,color: Colors.blueAccent,),
                                Text('Book stay', style: TextStyle(
                                    color: Colors.blueAccent
                                ),),
                              ],
                            ),
                          ))),

                  Container(
                      width: 150,
                      height: 90,
                      child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.wb_sunny_outlined, size: 50,color: Colors.blueAccent,),
                                Text('Day visits', style: TextStyle(
                                    color: Colors.blueAccent
                                ),),
                              ],
                            ),
                          ))),

                ],
              ),
            )
          ])),
    );
  }
}
