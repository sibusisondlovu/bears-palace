import 'package:flutter/cupertino.dart';
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
            ListView(
              children: ListTile.divideTiles(
                  context: context,
                  tiles: [
                    ListTile(
                      title: Text('Sheep'),
                      subtitle: Text('Provides wool'),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        print('sheep');
                      },
                    ),
                    ListTile(
                      title: Text('Sheep'),
                      subtitle: Text('Provides wool'),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        print('sheep');
                      },
                    ),
                  ]
              ).toList(),
            )
          ],
        ),
      ),
    );
  }
}
