

import 'package:bears_palace_app/screens/horse_riding/horse_riding_screen.dart';
import 'package:flutter/material.dart';

import '../../colors.dart';

class RecreationServicesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(int.parse(AppColors.primaryColor)),
          title: Text('Recreational'),
        ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset('assets/images/chess.jpg'),
              SizedBox(height: 10,),
              Image.asset('assets/images/cycling.jpg'),
              SizedBox(height: 10,),
              Image.asset('assets/images/dart_games.jpg'),
              SizedBox(height: 10,),
              Image.asset('assets/images/go_karting.jpg'),
              SizedBox(height: 10,),
              GestureDetector(
                  onTap: (){
                     Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => HorseRidingScreen()),
                     );
                  },
                  child: Image.asset('assets/images/horse_riding.jpg')),
              SizedBox(height: 10,),
              Image.asset('assets/images/quad_bikes.jpg'),
            ]
          ),
        ),
      )
    );
  }
}
