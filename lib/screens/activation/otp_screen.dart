import 'package:bears_palace_app/root_layout_screen.dart';
import 'package:bears_palace_app/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:http/http.dart' as http;

import '../../colors.dart';

class OtpScreen extends StatefulWidget {

  final String name;
  final String phoneNumber;

  OtpScreen(this.name, this.phoneNumber);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  String formattedPhoneNumber ='';
  bool isWaitingOtp = true;

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  String _verificationCode;

  final TextEditingController _pinPutController = TextEditingController();

  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );

  _verifyPhone() async {

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: formattedPhoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          isWaitingOtp = false;
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              // Navigator.pushAndRemoveUntil(
              //     context,
              //     MaterialPageRoute(builder: (context) => Home()),
              //         (route) => false);
              Navigator.pop(context);
              // make authstate lister to update variable so user can continue
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() {
            isWaitingOtp = false;
          });
          print(e.message);
          CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            title: e.code,
            text: e.message,
          );
        },
        codeSent: (String verficationID, int resendToken) {
          setState(() {
            isWaitingOtp = false;
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            isWaitingOtp = false;
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }

  @override
  void initState() {
    super.initState();

    if (widget.phoneNumber.length == 10) {
      formattedPhoneNumber = "+27" + widget.phoneNumber.substring(1);
    }else{
      formattedPhoneNumber = "+27" + widget.phoneNumber;
    }
    _verifyPhone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
        backgroundColor: Color(int.parse(AppColors.primaryColor)),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(

              children: [
                SizedBox(height: 20),
                Text('Please wait while we auto verify SMS sent \n' +
                    formattedPhoneNumber + '. If auto-verification fails, please \nenter the code sent below',
                  textAlign: TextAlign.center,),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: PinPut(
                    fieldsCount: 6,
                    textStyle: const TextStyle(fontSize: 25.0, color: Colors.white),
                    eachFieldWidth: 40.0,
                    eachFieldHeight: 55.0,
                    focusNode: _pinPutFocusNode,
                    controller: _pinPutController,
                    submittedFieldDecoration: pinPutDecoration,
                    selectedFieldDecoration: pinPutDecoration,
                    followingFieldDecoration: pinPutDecoration,
                    pinAnimationType: PinAnimationType.fade,
                    onSubmit: (pin) async {
                      print('on submit called.');
                      try {
                        await FirebaseAuth.instance
                            .signInWithCredential(PhoneAuthProvider.credential(
                            verificationId: _verificationCode, smsCode: pin))
                            .then((value) async {
                          if (value.user != null) {
                             Navigator.pushAndRemoveUntil(
                                 context,
                                 MaterialPageRoute(builder: (context) => RootLayoutScreen()),
                                     (route) => false);

                             //add user on database
                            addUserOnDatabase(widget.name, value.user.uid, value.user.phoneNumber);
                          }
                        });
                      } catch (e) {
                        CoolAlert.show(
                          context: context,
                          type: CoolAlertType.error,
                          title: "Oops...",
                          text: "Sorry, something went wrong \n" + e.toString(),
                        );
                        // FocusScope.of(context).unfocus();
                        // _scaffoldkey.currentState
                        //     .showSnackBar(SnackBar(content: Text('invalid OTP')));
                      }
                    },
                  ),
                ),
              ],
            ),
            isWaitingOtp? CircularProgressIndicator(): Container(),
            Column(
              children: [
                FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Colors.white,
                  textColor: Colors.red,
                  padding: EdgeInsets.all(10.0),
                  onPressed: () {
                    // check if form is valid
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => OtpScreen(_name,_phoneNumber)));
                  },
                  child: Text(
                    "VERIFY OTP CODE",
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ),
                SizedBox(height: 50,)
              ],
            ),
          ],

        ),

      ),
    );
  }

  void addUserOnDatabase(String displayName, String uid, String phoneNumber)  async{

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    users.add({
        'displayName': displayName,
        'uid': uid,
        'phoneNumber': phoneNumber,
        'points' : 100,
        'level': 'Basic',
        'avatar': '',
        'createdAt': DateTime.now().toString()
      })
          .then((value) => print("User Added"))
          .catchError((error) => {
              CoolAlert.show(
                   context: context,
                   type: CoolAlertType.error,
                   title: "Oops...",
                   text: "Sorry, something went wrong \n" + error.toString(),
                 )
          });

    // try {
    //
    // }catch (error) {
    //   print(error);
    //   CoolAlert.show(
    //     context: context,
    //     type: CoolAlertType.error,
    //     title: "Oops...",
    //     text: "Sorry, something went wrong \n" + error.toString(),
    //   );
    //}

    // final response = await http.post(
    //     "http://backend.bearspalace.co.za/api/v1/users/create_user.php",
    //     body: {
    //       "uid": uid,
    //       "name": displayName,
    //       "contactNumber": phoneNumber,
    //     });
    // print(response.body);

  }
}
