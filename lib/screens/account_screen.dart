import 'package:bears_palace_app/screens/activation/activate_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../colors.dart';
import 'activation/profile_activation_screen.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  bool isProfileActivated = false;

  void checkIfUserIsLoggedIn(){
    FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser == null) {
      setState(() {
        isProfileActivated = false;
      });
    }else{
      setState(() {
        isProfileActivated = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkIfUserIsLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Account'),
      ),
      drawer: sideDrawer(context),
      body: SafeArea(
        child: isProfileActivated? _profileActivated(context): _profileNotActivated(context)
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context){
    return Image.asset('assets/images/avatar.png', width: MediaQuery.of(context).size.width * 0.35,);
  }

  Widget _profileActivated(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildProfileHeader(context),
          Text('Sibusiso Ndlovu', style: TextStyle(
              fontSize: 18
          ),),
          Text('Silver Bear', style: TextStyle(
              fontSize: 12
          ),),
          Text('Points: 1000 bp', style: TextStyle(
              fontSize: 12
          ),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text('0', style: TextStyle(
                            fontSize: 38
                        ),),
                        Text('PHOTOS')
                      ],

                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text('0', style: TextStyle(
                            fontSize: 38
                        ),),
                        Text('FOLLOWERS')
                      ],

                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text('0', style: TextStyle(
                            fontSize: 38
                        ),),
                        Text('FOLLOWING')
                      ],

                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _profileNotActivated(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset('assets/images/activate.png',
            width: MediaQuery.of(context).size.width * 0.6,),
          Text('Profile Not Activated',
            style: TextStyle(
                fontSize: 22,
                fontFamily: 'Bold'
            ),
          ),
          Text('Thank you for using our app! At the moment you only \n have access to limited functionality. Please activate \nyour profile to enjoy the best experience on the go.', textAlign: TextAlign.center,),

          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: Colors.white,
            textColor: Colors.red,
            padding: EdgeInsets.all(10.0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileActivationScreen()),
              );
            },
            child: Text(
              "Start Profile Activation".toUpperCase(),
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ),
        ],
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
