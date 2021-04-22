import 'package:bears_palace_app/models/service_model.dart';
import 'package:bears_palace_app/screens/spa/spa_booking_form.dart';
import 'package:flutter/material.dart';

class SpaServicesScreen extends StatefulWidget {
  @override
  _SpaServicesScreenState createState() => _SpaServicesScreenState();
}

class _SpaServicesScreenState extends State<SpaServicesScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Spa Services'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                child: ListTile(
                  title: Text('Queen of Treatment'),
                  subtitle: Column(
                    children: [
                      Text('A luxurious sugar body scrub with a combination of a '
                          'Thai herbal hot compress de stressing massage pedicure and foot massage '
                          'for stress relief and silky soft skin',
                      style: TextStyle(
                        fontSize: 13
                      ),),
                      ElevatedButton(onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SpaBookingFormScreen()),
                        );
                      }, child: Text('Book Now'))
                    ],
                  ),
                  trailing: Column(
                    children: [
                      Text('R 1,220'),
                      Text('3.5 hours', style: TextStyle(
                        fontSize: 12
                      ),)
                    ],
                  ),
                  onTap: () {
                    print('sheep');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
