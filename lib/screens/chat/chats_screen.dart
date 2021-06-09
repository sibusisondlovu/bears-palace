
import 'package:bears_palace_app/screens/activation/activate_profile.dart';

import 'package:flutter/material.dart';

class ChatsScreen extends StatefulWidget {
  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {

  bool isProfileActivated = false;
  String _uid;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return isProfileActivated? Scaffold(
      appBar: AppBar(
        title: Text('Bears Chat'),
      ),
      drawer: null,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHeaderUi(context),
            _buildSearchBar(context),
          ],
        ),
      ),
    ): ActivateProfile();
  }

  Widget _buildHeaderUi (BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 16,right: 16,top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Conversations"
              ,style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),),
            Container(
              padding: EdgeInsets.only(left: 8,right: 8,top: 2,bottom: 2),
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.pink[50],
              ),
              child: Row(
                children: <Widget>[
                  Icon(Icons.add,color: Colors.pink,size: 20,),
                  SizedBox(width: 2,),
                  Text("Add New",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16,left: 16,right: 16),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search...",
          hintStyle: TextStyle(color: Colors.grey.shade600),
          prefixIcon: Icon(Icons.search,color: Colors.grey.shade600, size: 20,),
          filled: true,
          fillColor: Colors.grey.shade100,
          contentPadding: EdgeInsets.all(8),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                  color: Colors.grey.shade100
              )
          ),
        ),
      ),
    );
  }

}
