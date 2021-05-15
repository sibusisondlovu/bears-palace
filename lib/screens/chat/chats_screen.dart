import 'dart:async';

import 'package:bears_palace_app/models/chat_users_model.dart';
import 'package:bears_palace_app/screens/activation/activate_profile.dart';
import 'package:bears_palace_app/screens/chat/chat_detail_screen.dart';
import 'package:bears_palace_app/widgets/conversation_list_widget.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatsScreen extends StatefulWidget {
  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {

  bool isProfileActivated = false;
  String _uid;

  void checkIfUserIsLoggedIn() {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User user) {
      if (user != null) {
        setState(() {
          isProfileActivated = true;
          _uid = user.uid;
        });
      }else{
        setState(() {
          isProfileActivated = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    checkIfUserIsLoggedIn();
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
             _buildConversationList(context)
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

  Widget _buildConversationList(BuildContext context) {
    final CollectionReference lastChatsReference = FirebaseFirestore.instance.collection('chats');
       // .where('users', arrayContains: 'sibusiso');
    bool isRead = false;

    return StreamBuilder<QuerySnapshot>(
      stream: lastChatsReference.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if (snapshot.hasError) {
          return Text('something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting){
          return Text('loading...');
        }

        if (snapshot.data.size != 0) {
          return new ListView(
            shrinkWrap: true,
            children: snapshot.data.docs.map((DocumentSnapshot document){
             // String t = document.data()['time'];
              //DateTime d = t.toDate();
              return GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatDetailPage(
                      avatar: 'https://avatars0.githubusercontent.com/u/8264639?s=460&v=4',
                      displayName: document.data()['display_name'],
                         status: 'Online'),));
                },
                child: new ListTile(
                  leading: CircularProfileAvatar(
                    'https://avatars0.githubusercontent.com/u/8264639?s=460&v=4', //sets image path, it should be a URL string. default value is empty string, if path is empty it will display only initials
                    radius: 25, // sets radius, default 50.0
                    backgroundColor: Colors.transparent, // sets background color, default Colors.white
                    borderWidth: 1,  // sets border, default 0.0
                    borderColor: Colors.brown, // sets border color, default Colors.white
                    elevation: 2.0, // sets elevation (shadow of the profile picture), default value is 0.0
                    foregroundColor: Colors.brown.withOpacity(0.5), //sets foreground colour, it works if showInitialTextAbovePicture = true , default Colors.transparent
                    cacheImage: true, // allow widget to cache image against provided url// sets on tap
                    showInitialTextAbovePicture: true, // setting it true will show initials text above profile picture, default false
                ),
                  title: new Text(document.data()['display_name']),
                  subtitle: isRead? new Text(document.data()['last_message']): new Text(document.data()['last_message'],
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold),),
                  trailing: new Text(""),
                ),
              );
            }).toList(),
          );
        }else{
          return new Text('No users');
        }
      },
    );
  }
}
