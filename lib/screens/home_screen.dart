import 'dart:convert';

import 'package:bears_palace_app/colors.dart';
import 'package:bears_palace_app/pages/day_visits_page.dart';
import 'package:bears_palace_app/screens/activation/activate_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool isLoading = false;
  var _userInfo;

  _getCurrentUserDetails()  async{

    FirebaseAuth.instance
        .authStateChanges()
        .listen((User user) async {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        var endpointUrl = 'http://backend.bearspalace.co.za/api/v1/users/get_user_details.php';
        Map<String, String> queryParams = {
          'uid': user.uid
        };
        String queryString = Uri(queryParameters: queryParams).query;

        var requestUrl = endpointUrl + '?' + queryString;
        var response = await http.get(requestUrl);
        _userInfo = json.decode(response.body);
      }
    });

      setState(() {
        isLoading = true;
      });


  }

  @override
  void initState() {
    super.initState();
    _getCurrentUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    _getCurrentUserDetails();
    return Scaffold(
      drawer: sideDrawer(context),
      appBar: AppBar(
        backgroundColor: Color(int.parse(AppColors.primaryColor)),
        title: Text('Bears Palace'),
        actions: [
          Icon(Icons.notification_important),
          SizedBox(width: 5,)
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: _userInfo !=null? Text('Hello, '+  _userInfo[0]['name'] ):  Text('Hello, Guest'),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Your Bears Palace Points',),
                        ListTile(
                          title: _userInfo!=null? Text(_userInfo[0]['points'] +' bp', style: TextStyle(
                            fontSize: 28
                          ),): Text('0.00 bp', style: TextStyle(
                              fontSize: 28
                          ),),
                          trailing: OutlineButton(
                            child: Text('Redeem'),
                          ),
                        ),
                        _userInfo !=null && _userInfo[0]['status']== 'ACTIVATED'? Container(): Text('Your account has not been activated. Please activate account to use full app features'),
                        RaisedButton(onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ActivateProfile()),
                          );
                        },
                        child: Text('Activate Profile'),)
                      ],
                    ),
                  ),
                ),SizedBox(height: 25,),
                Column(
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget sideDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/app_logo.png',),
                fit: BoxFit.cover,
              )
            ),
            child: Text("Header"),

          ),
          ListTile(
            title: Text("Home"),
          ),
          ListTile(
            title: Text("Home"),
          ),
          ListTile(
            title: Text("Home"),
          ),
          Divider(),
          ListTile(
            title: Text('App version 1.0.0'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
