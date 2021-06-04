import 'package:flutter/material.dart';

class ResortScreen extends StatefulWidget {
  const ResortScreen({Key key}) : super(key: key);

  @override
  _ResortScreenState createState() => _ResortScreenState();
}

class _ResortScreenState extends State<ResortScreen> {

  final List<String> entries = <String>['About Resort', 'Local Attractions',
    'Weather', 'Shuttle Services', 'Contact Us'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Card(
                  child: ListTile(
                    leading: Image.asset('assets/images/app_logo.png', width: 30,),
                    title: Text('About Resort'),
                    trailing: Icon(Icons.chevron_right),
                  ),
                ),
            Card(
              child: ListTile(
                leading: Image.asset('assets/images/local_attractions_icon.png', width: 30,),
                title: Text('Local Attractions'),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
            Card(
              child: ListTile(
                leading: Image.asset('assets/images/shuttle_services_icon.png', width: 30,),
                title: Text('Shuttle Services'),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
            Card(
              child: ListTile(
                leading: Image.asset('assets/images/weather_icon.png', width: 30,),
                title: Text('Weather'),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
            Card(
              child: ListTile(
                leading: Image.asset('assets/images/contact_us_icon.png', width: 30,),
                title: Text('Contact Information'),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
          ],
        ));
  }
}
