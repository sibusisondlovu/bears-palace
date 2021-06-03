import 'package:flutter/material.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({Key key}) : super(key: key);

  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Carolina Resort'),
            bottom: TabBar(
              isScrollable: true,
              indicatorColor: Colors.cyan,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(40), // Creates border
                  color: Colors.greenAccent),
              tabs: [
                Tab(
                  text: 'All',
                ),
                Tab(
                  text: 'Breakfast',
                ),
                Tab(
                  text: 'Lunch',
                ),
                Tab(
                  text: 'Dinner',
                ),
                Tab(
                  text: 'Room Service',
                ),
                Tab(
                  text: 'Bar',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _allFoodsMenuTile(context),
              Text('Breakfast'),
              Text('Lunch'),
              Text('Dinner'),
              Text('Room Service'),
              Text('Bar'),
            ],
          ),
        )
    );
  }

  _allFoodsMenuTile(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index)=> Padding(
        padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 10),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text('Bad ur Remo Salamioa'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Text('Food description goes here and here and here and here'),
                  SizedBox(height: 10,),
                  Text('Breakfast',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12
                    ),),
                  Row(
                    children: [
                      Icon(Icons.access_time_outlined),
                      Text('7am to 11am'),
                    ],
                  ),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('R 20.00'),

                  Text('ORDER'),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
