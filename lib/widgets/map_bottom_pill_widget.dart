import 'package:flutter/material.dart';

class MapBottomPillWidget extends StatelessWidget {
  const MapBottomPillWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Positioned(
        left: 0,
        right: 0,
        bottom: 10,
        child: Container(
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: Offset.zero
                )
              ]
          ),
          child: Row(
            children: [
              ClipOval(
                child: Image.asset(
                  'assets/images/horse_riding_icon.jpg',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('The Bears Palace ',
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                    ),),
                  Text('Emabheleni'),
                  Text('2km away',
                    style: TextStyle(
                        color: Colors.cyan
                    ),)
                ],
              )
            ],
          ),
        ));
  }
}
