
import 'package:bears_palace_app/screens/room_search_screen.dart';
import 'package:bears_palace_app/screens/spa_packages_screen.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black12,
        body: SingleChildScrollView(
          child: Column(children: [
            headerBackgroundImage(context),
            belowHeaderScrollingList(context),
            callToActionCard(context),
            callToActionCard2(context),
            rewardsCard(context)
          ]),
        ));
  }

  Widget callToActionCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(children: [
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            color: Colors.blue,
            child: Opacity(
                opacity: 0.3,
                child: Image.asset(
                  'assets/images/home_screen_bg.jpg',
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: 180,
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Book Now for the Best Rates',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Best rates guaranteed, entertainment deals, and \naccess to exclusive rooms & suiters',
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orangeAccent,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> SpaPackagesScreen()));
                  },
                  child: Text(
                    'Book now',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ))
            ],
          ),
        )
      ]),
    );
  }

  Widget callToActionCard2(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(children: [
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            color: Colors.orangeAccent,
            child: Opacity(
                opacity: 0.3,
                child: Image.asset(
                  'assets/images/spa_treatment.jpg',
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: 180,
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Spa Treatment',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Best rates guaranteed, entertainment deals, and \naccess to exclusive rooms & suiters',
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> SpaPackagesScreen()));
                  },
                  child: Text(
                    'View Packages',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ))
            ],
          ),
        )
      ]),
    );
  }

  Widget headerBackgroundImage(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      child: Container(
        color: Colors.black,
        child: Stack(
          children: [
            Opacity(
                opacity: 0.5,
                child: Image.asset('assets/images/home_screen_bg.jpg',
                height: 180,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,)),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 60,),
                  Text(
                    'Welcome to \nCarolina Resort',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget belowHeaderScrollingList(BuildContext context) {
    return Container(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(10),
        children: <Widget>[
          Container(
              width: 150,
              height: 70,
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.blueAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.work,
                          size: 40,
                          color: Colors.white,
                        ),
                        Text(
                          'Check In',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ))),
          Container(
              width: 150,
              height: 70,
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> RoomSearchScreen()));
                },
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.airline_seat_flat,
                            size: 40,
                            color: Colors.blueAccent,
                          ),
                          Text(
                            'Book stay',
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                        ],
                      ),
                    )),
              )),
          Container(
              width: 150,
              height: 70,
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.wb_sunny_outlined,
                          size: 40,
                          color: Colors.blueAccent,
                        ),
                        Text(
                          'Day visits',
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      ],
                    ),
                  ))),
        ],
      ),
    );
  }

  Widget rewardsCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 10,),
        RichText(
            text: TextSpan(
              text: 'Star Life',
              style: TextStyle(color: Colors.blueAccent, fontSize: 16),
              children: <TextSpan>[
                TextSpan(
                  text: ' Rewards',
                  style: TextStyle(color: Colors.blueAccent, fontSize: 16, fontWeight: FontWeight.bold),
                )
              ],
            ),
        ),
                  SizedBox(height: 15,),
                  Text('Book your stay and skip the check-in. Earn rewards whenever you dine, stay or play.')
      ]),
          )),
    );
  }
}
