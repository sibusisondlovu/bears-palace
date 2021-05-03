import 'dart:convert';

import 'package:bears_palace_app/screens/bookings/add_booking_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../colors.dart';

class BookScreen extends StatefulWidget {
  @override
  _BookScreenState createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {

  var _bookings;
  bool isLoading = false;
  bool isProfileActivated = false;
  var myBookingsList;

  fetchBookings() async {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User user) {
      if (user == null) {
        setState(() {
          isProfileActivated = false;
        });
      } else {
        FirebaseFirestore.instance
            .collection('bookings')
            .where('uid', isEqualTo: user.uid)
            .get()
            .then((value) {
              if (value.docs.isEmpty) {
                print('You do not have any bookings. Make you first booking');
              }else{
                print(_bookings);
                setState(() {
                  _bookings =  value;
                });
              }

        });

        setState(() {
          isProfileActivated = true;
        });
      }
    });

  }

  @override
  void initState() {
    fetchBookings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(int.parse(AppColors.primaryColor)),
        title: Text('My Bookings'),
      ),
      body:Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: _buildBookingsTile(context)
      )//_buildBookingsTile(context) ,
    );
  }

  // bookings tile
  Widget _buildBookingsTile(BuildContext context) {
    CollectionReference spaServicesCollection = FirebaseFirestore.instance.collection('bookings');

    return FutureBuilder<QuerySnapshot>(
      future: spaServicesCollection.get(),
      builder:
          (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(child: Text("Something went wrong"));
          }

          if (snapshot.hasData) {
            final List<DocumentSnapshot> listOfSpaServices = snapshot.data.docs;
            return ListView(
                children: listOfSpaServices.map((doc) => Card(
                  child: ListTile(
                    title: Text(doc['service']),
                    subtitle: Text(doc['bookingReferenceNumber']),
                    trailing: Text(doc['bookedDate']),
                  ),
                )).toList());
          }else {
            return _buildNoBookings(context);
          }
        }

        return Center(
          child: Column(
            children: [
              CircularProgressIndicator(),
              Text("loading"),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNoBookings(BuildContext context) {
    return Center(
      child:  Column(

        children: [
          Image.asset('assets/images/no_events.png', width: 100,),
          SizedBox(height:15),
          Text('You do not have any booking history', style: TextStyle(fontFamily: 'Bold', fontSize: 18
          )),
          SizedBox(height:10),
          Text('Tap on Book Now to make your first booking \nand get 100 Bears Points', textAlign: TextAlign.center,),
        ],
      ),
    );
  }
}
