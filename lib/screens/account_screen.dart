
import 'dart:convert';
import 'dart:io';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'activation/profile_activation_screen.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isProfileActivated = true;
  File imageFile;
  String fileName;
  File tmpFile;
  String base64Image;
  String errorMessage = 'Error Uploading';


  var _userDetails;
  bool isLoading = false;
  String avatarBaseUrl = 'https://backend.bearspalace.co.za/images/'  ;

  getCurrentUserDetails() async {
    setState(() {
      isLoading = true;
    });

    var endpointUrl = 'http://backend.bearspalace.co.za/api/v1/users/get_user_details.php';
  //  Map<String, String> queryParams = {
  //    'uid': 'NovY3ZJ384dRBRUbTgpP6HyDXLq2',
  //  };
  //  String queryString = Uri(queryParameters: queryParams).query;

  //  var requestUrl = endpointUrl + '?' + queryString;
    var response = await http.get(endpointUrl);
    _userDetails = json.decode(response.body);

    print(_userDetails[0]['name']);

    setState(() {
      isLoading = false;
    });

  }


  void _openGallery() async {

    print('Open Image Gallery');

    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _setImageFileName(picture);
    });
  }


  void _setImageFileName(var picture){

    imageFile = picture;
    fileName = "pictureOne.jpg";
    String base64Image = base64Encode(imageFile.readAsBytesSync());

    //itemPhotos.addAll({"mainPhoto": fileName});

    _uploadFileToServer(fileName,base64Image);

  }

  void _uploadFileToServer(String filename, String base64) {
    try {
      http.post(avatarBaseUrl+ 'upload_image.php', body:{
        "image": base64,
        "name": filename,
      }).then((result){
        print('SERVER RESPONSE ' + result.body);

        if (result.body == 'success') {
          print('im going to the next page');
        }else{
          print('failed');
        }
      }).catchError((onError){
        print('SERVER RESPONSE with error $onError');

      });
    }catch (error) {
      print("SERVER ERROR $error");

    }
  }


  void checkIfUserIsLoggedIn() {
    FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser != null) {
      setState(() {
        isProfileActivated = true;
        getCurrentUserDetails();
      });
    }else{
      setState(() {
        isProfileActivated = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkIfUserIsLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Account'),
      ),
      drawer: sideDrawer(context),
      body: SafeArea(
          child: isProfileActivated
              ? _profileActivated(context)
              : _profileNotActivated(context)),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircularProfileAvatar(
        _userDetails[0]['avatar'] !=null? avatarBaseUrl +  _userDetails[0]['avatar'] : 'Guest', //sets image path, it should be a URL string. default value is empty string, if path is empty it will display only initials
        radius: 100, // sets radius, default 50.0
        backgroundColor:
            Colors.transparent, // sets background color, default Colors.white
        borderWidth: 10, // sets border, default 0.0
  // sets initials text, set your own style, default Text('')
        borderColor: Colors.brown, // sets border color, default Colors.white
        elevation:
            5.0, // sets elevation (shadow of the profile picture), default value is 0.0
        foregroundColor: Colors.brown.withOpacity(
            0.5), //sets foreground colour, it works if showInitialTextAbovePicture = true , default Colors.transparent
        cacheImage: true, // allow widget to cache image against provided url
        onTap: () {
          print('adil');
          _openGallery();
        }, // sets on tap
        showInitialTextAbovePicture:
            true, // setting it true will show initials text above profile picture, default false
      ),
    );
  }

  Widget _profileActivated(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildProfileHeader(context),
          Text(
            _userDetails[0]['name'] !=null? _userDetails[0]['name'] : 'Guest',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            _userDetails[0]['level'] !=null? _userDetails[0]['level'] : 'BLUEBEAR',
            style: TextStyle(fontSize: 12),
          ),
          Text(
            _userDetails[0]['points'] !=null? _userDetails[0]['points'] : '0 bp',
            style: TextStyle(fontSize: 12),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          _userDetails[0]['photos'] !=null? _userDetails[0]['photos'] : '0',
                          style: TextStyle(fontSize: 38),
                        ),
                        Text('PHOTOS')
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          _userDetails[0]['followers'] !=null? _userDetails[0]['followers'] : '0',
                          style: TextStyle(fontSize: 38),
                        ),
                        Text('FOLLOWERS')
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          _userDetails[0]['following'] !=null? _userDetails[0]['following'] : '0',
                          style: TextStyle(fontSize: 38),
                        ),
                        Text('FOLLOWING')
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _profileNotActivated(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            'assets/images/activate.png',
            width: MediaQuery.of(context).size.width * 0.6,
          ),
          Text(
            'Profile Not Activated',
            style: TextStyle(fontSize: 22, fontFamily: 'Bold'),
          ),
          Text(
            'Thank you for using our app! At the moment you only \n have access to limited functionality. Please activate \nyour profile to enjoy the best experience on the go.',
            textAlign: TextAlign.center,
          ),
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            color: Colors.white,
            textColor: Colors.red,
            padding: EdgeInsets.all(10.0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfileActivationScreen()),
              );
            },
            child: Text(
              "Start Profile Activation".toUpperCase(),
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sideDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                'assets/images/app_logo.png',
              ),
              fit: BoxFit.cover,
            )),
            child: Text("Header"),
          ),
          ListTile(
            title: Text("Home"),
          ),
          ListTile(
            title: Text("Home"),
          ),
          ListTile(
            title: Text("Home"),
          ),
          Divider(),
          ListTile(
            title: Text('App version 1.0.0'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
