import 'package:flutter/material.dart';

class SpaServiceBookingConfirmScreen extends StatefulWidget {
  @override
  _SpaServiceBookingConfirmScreenState createState() => _SpaServiceBookingConfirmScreenState();
}

class _SpaServiceBookingConfirmScreenState extends State<SpaServiceBookingConfirmScreen> {
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
                        Text('Sibusiso Ndlovu'),
                        SizedBox(height: 10,),
                        Text('Contact Number:'),
                        Text('083 743 5269'),
                        SizedBox(height: 10,),
                        Text('Email Address:'),
                        Text('sibusiso@jaspa.co.za'),
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
                        Text('Queen of Treatment'),
                        SizedBox(height: 10,),
                        Text('Appointment Date:'),
                        Text('30 April 2021, @ 14h00'),
                        SizedBox(height: 10,),
                        Text('Number of people:'),
                        Text('1'),
                        SizedBox(height: 10,),
                        Text('Amount:'),
                        Text('R 1,456.90'),
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SpaServiceBookingConfirmScreen()),
          );
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
