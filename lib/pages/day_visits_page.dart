import 'package:bears_palace_app/pages/recreation/recreation_services_list.dart';
import 'package:bears_palace_app/screens/spa/spa_services_screen.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class DayVisitsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(int.parse(AppColors.primaryColor)),
        title: Text('Explore'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Image.asset('assets/images/restaurant.jpg'),
            SizedBox(height: 10,),
            GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RecreationServicesList()),
                  );
                },
                child: Image.asset('assets/images/recreation.jpg')),
            SizedBox(height: 10,),
            GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SpaServicesScreen()),
                  );
                },
                child: Image.asset('assets/images/spa.png')),
          ],
        ),
      ),
    );
  }
}
