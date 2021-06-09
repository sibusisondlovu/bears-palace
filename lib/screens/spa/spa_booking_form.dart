import 'package:bears_palace_app/screens/spa/spa_service_booking_confirm_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SpaBookingFormScreen extends StatefulWidget {
  @override
  _SpaBookingFormScreenState createState() => _SpaBookingFormScreenState();
}

class _SpaBookingFormScreenState extends State<SpaBookingFormScreen> {
  bool loading = true;
  final dateFormat = DateFormat("dd MMM yyyy");
  final timeFormat = DateFormat("HH:mm");

  String _strService;
  String _strBookingDate;
  String _strStartTime;
  String _strEndTime;
  String _dblFee;
  String _numberOfGuests;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Spa Service Booking'),
      ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(height: 15,),
                Text('Number of people'),
                SizedBox(
                    width: 120,
                    child: TextField()),
                SizedBox(height: 15,),
                Text('Booking terms and conditions goes here', style: TextStyle(
                  fontSize: 12
                ),),
                SizedBox(height: 15,),
                _buildContinueButton(context)
              ],
            ),
          ),
        ));
  }

  Widget _buildContinueButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SpaServiceBookingConfirmScreen()),
          );
        },
        child: Text(
          "Continue",
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }
}
