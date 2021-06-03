import 'package:flutter/material.dart';

class MapUserBadgeWidget extends StatelessWidget {
  const MapUserBadgeWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 20,
            right: 20
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
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
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                      image: AssetImage('assets/images/default_profile_avatar.jpg'),
                      fit: BoxFit.cover
                  ),
                  border: Border.all(
                      color: Colors.cyan,
                      width: 1
                  )
              ),
            ),
            SizedBox (
                width: 10
            ),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sibusiso Ndlovu',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                      ),),
                    Text('My Location',
                      style: TextStyle(
                          color: Colors.cyan
                      ),)
                  ],
                )),
            Icon(
              Icons.location_pin,
              color: Colors.cyan,
            )
          ],
        ),
      ),
    );
  }
}
