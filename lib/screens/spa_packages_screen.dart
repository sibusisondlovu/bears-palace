import 'package:flutter/material.dart';

class SpaPackagesScreen extends StatefulWidget {
  const SpaPackagesScreen({Key key}) : super(key: key);

  @override
  _SpaPackagesScreenState createState() => _SpaPackagesScreenState();
}

class _SpaPackagesScreenState extends State<SpaPackagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
           // child: SideMenuBar()
        ),
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
                  child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (BuildContext ctx, int index) {
                      return _buildCategoryCard(context);
                    },
                  ),
                ),
                //CategoryBottomBar()
              ],
            )
        )
    );
  }

  Widget _buildCategoryCard(BuildContext context) {
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
                    Text('Detox',
                        style: TextStyle(color: Colors.white, fontSize: 25)),
                    Text('Detox',
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
