import 'package:bears_palace_app/models/service_model.dart';
import 'package:bears_palace_app/screens/spa/spa_booking_form.dart';
import 'package:bears_palace_app/screens/spa/spa_service_booking_confirm_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
        child: _buildSpaServicesList(context)
      ),
    );
  }

  Widget _buildSpaServicesList(BuildContext context) {
    CollectionReference spaServicesCollection = FirebaseFirestore.instance.collection('spa_services');

    return FutureBuilder<QuerySnapshot>(
      future: spaServicesCollection.get(),
      builder:
          (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(child: Text("Something went wrong"));
          }

          if (snapshot.hasData) {
            final List<DocumentSnapshot> listOfSpaServices = snapshot.data.docs;
            return ListView(
                children: listOfSpaServices.map((doc) => Card(
                  child: ListTile(
                    title: Text(doc['name']),
                    subtitle: Column(
                      children: [
                        Text(doc['description']),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('R ' + doc['price'].toString()),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SpaBookingFormScreen(service: doc)),
                                );
                              },
                              child: Text(
                                "Book Now",
                                style: TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )).toList());
          }
        }

        return Center(
          child: Column(
            children: [
              CircularProgressIndicator(),
              Text("loading"),
            ],
          ),
        );
      },
    );
  }
}
