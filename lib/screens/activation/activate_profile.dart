import 'package:bears_palace_app/screens/activation/profile_activation_screen.dart';
import 'package:flutter/material.dart';


class ActivateProfile extends StatefulWidget {
  @override
  _ActivateProfileState createState() => _ActivateProfileState();
}

class _ActivateProfileState extends State<ActivateProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset('assets/images/activate.png',
            width: MediaQuery.of(context).size.width * 0.6,),
            Text('Activate profile!',
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
                "Activate Profile".toUpperCase(),
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: Colors.white,
              textColor: Colors.red,
              padding: EdgeInsets.all(10.0),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Dimiss".toUpperCase(),
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
