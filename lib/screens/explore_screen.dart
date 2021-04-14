import 'package:bears_palace_app/pages/day_visits_page.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
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
      ),
    );
  }
}
