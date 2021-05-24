import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RoomSearchScreen extends StatefulWidget {
  const RoomSearchScreen({Key key}) : super(key: key);

  @override
  _RoomSearchScreenState createState() => _RoomSearchScreenState();
}

class _RoomSearchScreenState extends State<RoomSearchScreen> {

  String _checkInDate = 'Tap to select';
  DateTime _selectedCheckinDate;
  String _checkOutDate = 'Tap to select';
  String _guests = '1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                child: Image.asset('assets/images/search_room_bg.jpg')),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    checkinCard(context),
                    guestsAndRoomsCard(context),
                    SizedBox(height: 20,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                            ),
                          ),
                          onPressed: () {}, child: Text('Search', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),)),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  Widget checkinCard(context) {

    return SizedBox(
      child: Row(
        children: [
          GestureDetector(
            onTap: (){
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2019, 1),
                lastDate: DateTime(2021, 12),
              ).then((pickedDate) {
                setState(() {
                  _selectedCheckinDate = pickedDate;
                  _checkInDate = DateFormat('dd MMM yyyy').format(pickedDate).toString();
                });
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Check out',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blueAccent),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            border: Border.all(
                              color: Colors.blueAccent,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.event),
                              Text(_checkInDate)
                            ],
                          ),
                        )
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Check out',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blueAccent),
                  ),
                  GestureDetector(
                    onTap: (){
                      showDatePicker(
                        context: context,
                        initialDate: _selectedCheckinDate.add(Duration(days: 1)),
                        firstDate: _selectedCheckinDate.add(Duration(days: 1)),
                        lastDate: DateTime(2021, 12),
                      ).then((pickedDate) {
                        setState(() {
                          _checkOutDate = DateFormat('dd MMM yyyy').format(pickedDate).toString();
                        });
                      });
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                            border: Border.all(
                              color: Colors.blueAccent,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Icon(Icons.event),
                            Expanded(child: Container()),
                            Text(_checkOutDate)
                          ],
                        ),
                      )
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget guestsAndRoomsCard(context) {
    return SizedBox(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Guests',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blueAccent),
                  ),
                  TextFormField(
                    onChanged: (value){
                      _guests = value;
                    },
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      fillColor: Colors.blueAccent,
                      hintText: _guests.toString(),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 2),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }
}
