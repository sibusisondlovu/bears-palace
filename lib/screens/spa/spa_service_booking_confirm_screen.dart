import 'package:bears_palace_app/screens/payfast/payfast_check_out_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SpaServiceBookingConfirmScreen extends StatefulWidget {

  final booking;

  SpaServiceBookingConfirmScreen({Key key, @required this.booking}):super(key: key);

  @override
  _SpaServiceBookingConfirmScreenState createState() => _SpaServiceBookingConfirmScreenState();

}

class _SpaServiceBookingConfirmScreenState extends State<SpaServiceBookingConfirmScreen> {

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

            print('Document data from Booking Form: ${documentSnapshot.data()}');
          } else {
            print('Document does not exist on the database with UID:' + user.uid);
          }
        });
      }
    });

  }

  @override
  void initState() {
    _getCurrentUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Booking Summary'),
      ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 10,),
                Text('YOUR DETAILS'),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name and Surname:'),
                        _userInfo !=null? Text(_userInfo['displayName']): Container(),
                        SizedBox(height: 10,),
                        Text('Contact Number:'),
                        _userInfo !=null? Text(_userInfo['phoneNumber']): Container(),
                        SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Text('BOOKING SUMMARY'),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Service:'),
                        Text(widget.booking['service'].toString()),
                        SizedBox(height: 10,),
                        Text('Appointment Date:'),
                        Text(widget.booking['bookingDate'].toString()),
                        SizedBox(height: 10,),
                        Text('Number of people:'),
                        Text(widget.booking['numberOfGuests'].toString()),
                        SizedBox(height: 10,),
                        Text('Cost:'),
                        Text('R ' + widget.booking['price'].toString()),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                _buildPayNowButton(context)
              ],
            ),
          ),
        ));
  }

  Widget _buildPayNowButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(

        onPressed: () {
          var data = {
            'totalAmount': 1000,
            'bookingReferenceNumber': '123456789'
          };

           Navigator.push(
             context,
             MaterialPageRoute(builder: (context) => PayfastCheckOutScreen(),settings: RouteSettings(
               arguments: data
             )),
           );

           print('going to payfast');
          // save booking to database -> cloud firestore
          // generate booking reference number
          // send email to admin with new booking details
          // on success payment, update booking status
          

        },
        child: Text(
          "PAY NOW",
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }
}
