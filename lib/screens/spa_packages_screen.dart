import 'dart:convert';

import 'package:bears_palace_app/helpers/constants.dart';
import 'package:bears_palace_app/models/spa_package_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SpaPackagesScreen extends StatefulWidget {
  const SpaPackagesScreen({Key key}) : super(key: key);

  @override
  _SpaPackagesScreenState createState() => _SpaPackagesScreenState();
}

class _SpaPackagesScreenState extends State<SpaPackagesScreen> {

  Future<List<SpaPackageModel>> _getSpaTreatmentPackages() async {
    var data = await http.get(Constants.apiServerUrl + 'services/read.php');

    var jsonData = json.decode(data.body);

    List<SpaPackageModel> packages = [];

    for (var p in jsonData) {
      SpaPackageModel packageModel = SpaPackageModel(
          p['id'],
          p['title'],
          p['description'],
          p['price'],
          p['service_category_id'],
          p['service_image_url'],
          p['qty'],
          p['unit_of_measurement']);

      packages.add(packageModel);

      print(packages.length);
      return packages;
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Text('Spa Packages and Facial Treatments',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black)
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: _getSpaTreatmentPackages(),
                    builder: (context, snapshot) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext ctx, int index) {
                          return _buildCategoryCard(context, snapshot,index);
                        },
                      );
                    }
                  ),
                ),
                //CategoryBottomBar()
              ],
            )
        )
    );
  }

  Widget _buildCategoryCard(BuildContext context, snapshot,index) {
    return Container(
        margin: EdgeInsets.all(20),
        height: 150,
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                    'assets/images/spa.jpg',
                    fit: BoxFit.cover),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.7),
                            Colors.transparent
                          ]))),
            ),
            Positioned(
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(snapshot.data[index].title,
                        style: TextStyle(color: Colors.white, fontSize: 25)),
                    Text(snapshot.data[index].description,
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
