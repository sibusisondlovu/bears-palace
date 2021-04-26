import 'package:flutter/material.dart';

class HorseRidingScreen extends StatefulWidget {
  @override
  _HorseRidingScreenState createState() => _HorseRidingScreenState();
}

class _HorseRidingScreenState extends State<HorseRidingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horse Riding'),
      ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Column(
                children: [
                  Image.asset('assets/images/horse_riding.jpg'),
                  Text('Experience Nature on Horseback! \n\nIdeal for Couples, Corporate Outings, Bachelorettes/Bachelors, '
                      'Birthday Parties, Kids Parties or …. A bunch of Family and Friends '
                      'looking for a fun, outdoor activity. \n\nTrained and enthusiastic staff accompany all rides and will '
                      'ensure that you are matched to the right horse, and that '
                      'the basic commands are explained to you. \n\nBeginners will be assisted throughout the ride while '
                      'more experienced riders will have plenty of opportunity to '
                      'trot and canter along the route. The emphasis is on '
                      'safe and enjoyable rides for all. \n\nWhere: Bears palace horse track. \n\nGroup size: One to Ten. \n\nDuration: 1 hour '
                      '| 1,5 hours | 2 hours (Arrive 45 minutes prior to your ride) \n\nGear: Supplied are Hard hats which must be worn. \n\nPlease ensure you wear long trousers and low heeled boots or '
                      'shoes for comfort and safety.  Rides go out every day on calm, '
                      'obedient and well-trained trail horses that will not run away with you. '
                      'Beginners, children, families and experienced riders are all welcome. \n\nPricing \nR330.00 per person – 30 Minutes \nR600.00 per person – 60 Minutes'),
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => SpaServiceBookingConfirmScreen(booking: booking)),
                      // );
                    },
                    child: Text(
                      "BOOK NOW   ",
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
