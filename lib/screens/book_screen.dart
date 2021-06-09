
import 'package:bears_palace_app/helpers/colors.dart';
import 'package:bears_palace_app/screens/bookings/add_booking_screen.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookScreen extends StatefulWidget {
  @override
  _BookScreenState createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {

  var _bookings;
  bool isLoading = false;
  bool isProfileActivated = false;
  var myBookingsList;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(int.parse(AppColors.primaryColor)),
        title: Text('My Bookings'),
        actions: [
          FlatButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddBookingScreen()),
              );
            },
            child: Text('Book Now', style: TextStyle(
              fontFamily: 'Bold',
              color: Colors.white
            ),),)
        ],
      ),
      body:Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _bookings  == null ? _buildNoBookings(context): _buildBookingsTile(context),
          ],
        ),
      )//_buildBookingsTile(context) ,
    );
  }

  // bookings tile
  Widget _buildBookingsTile(BuildContext context) {
    return  Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: _bookings == null ? 0 : _bookings.length,
        itemBuilder: (context, index){

          return  GestureDetector(
            onTap: (){

            },
            child: Card(
              child: ListTile(
                title: Text(_bookings[index]['service']),
                subtitle: Text(_bookings[index]['reference_number'] + ' - ' + _bookings[index]['booking_date']),
                trailing: Icon(Icons.more_vert),
              ),
            ),
          );
        },
        ),
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
