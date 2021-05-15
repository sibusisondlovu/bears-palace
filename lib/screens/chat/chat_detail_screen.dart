import 'package:bears_palace_app/models/chat_message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatDetailPage extends StatefulWidget{
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
  final String displayName;
  final String avatar;
  final String status;

  ChatDetailPage({this.avatar, this.displayName, this.status});
}

class _ChatDetailPageState extends State<ChatDetailPage> {

  String _currentTypedMessage;
  final _chatMessageController  = TextEditingController();

  final CollectionReference conversationsRef  = FirebaseFirestore.instance
      .collection('conversations')
      .doc('sxa7qsmtcHobPVEM37nr')
      .collection('messages');

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _chatMessageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Container(
              padding: EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back,color: Colors.black,),
                  ),
                  SizedBox(width: 2,),
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.avatar),
                    maxRadius: 20,
                  ),
                  SizedBox(width: 12,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(widget.displayName,style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),
                       // SizedBox(height: 6,),
                        Text(widget.status,style: TextStyle(color: Colors.grey.shade600, fontSize: 13),),
                      ],
                    ),
                  ),
                  Icon(Icons.settings,color: Colors.black54,),
                ],
              ),
            ),
          ),
        ),
      body: _buildChatBox(context)
    );
  }

  Widget _buildChatBox(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
            height: 60,
            width: double.infinity,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(Icons.add, color: Colors.white, size: 20, ),
                  ),
                ),
                SizedBox(width: 15,),
                Expanded(
                  child: TextFormField(
                    controller: _chatMessageController,
                    onChanged: (value){
                      _currentTypedMessage = value;
                    },
                    decoration: InputDecoration(
                        hintText: "Write message...",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none
                    ),
                  ),
                ),
                SizedBox(width: 15,),
                FloatingActionButton(
                  onPressed: (){
                    sendMessage();
                  },
                  child: Icon(Icons.send,color: Colors.white,size: 18,),
                  backgroundColor: Colors.blue,
                  elevation: 0,
                ),
              ],

            ),
          ),
        ),
        _buildMessageList(context)
      ],
    );
  }

  Widget _buildMessageList(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
      stream: conversationsRef.snapshots(),
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
              return Container(
                padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                child: Align(
                  alignment: (document.data()['send_by'] == "username1"?Alignment.topLeft:Alignment.topRight),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (document.data()['send_by']  == "username1"?Colors.grey.shade200:Colors.blue[200]),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Text(document.data()['text'], style: TextStyle(fontSize: 15),),
                  ),
                ),
              );
            }).toList(),
          );
        }else{
          return new Text('No messages');
        }
      },
    );
  }

  sendMessage() {
    _chatMessageController.clear();

    return conversationsRef
        .add({
      'time': DateTime.now().millisecondsSinceEpoch.toString(),
      'send_by': 'username2',
      'text': _currentTypedMessage
    })
        .then((value) {
      updateLastMessage();
    })
        .catchError((error) => print("Failed to send message user: $error"));
  }


  updateLastMessage() {

    CollectionReference lastMessage = FirebaseFirestore.instance.collection('chats');

    return lastMessage.doc('xxm9JvekAfs5ELMrlgbG')
        .update({
      'time': DateTime.now().millisecondsSinceEpoch.toString(), // John Doe
      'last_message': _currentTypedMessage, // Stokes and Sons// 42
    })
        .then((value) {

      // update delivery tick in future
      // update last messages
      // set status to unread
    })
        .catchError((error) => print("Failed to send message user: $error"));
  }
}