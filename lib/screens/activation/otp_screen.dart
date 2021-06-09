import 'package:bears_palace_app/helpers/colors.dart';
import 'package:bears_palace_app/root_layout_screen.dart';
import 'package:cool_alert/cool_alert.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;


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



  @override
  void initState() {
    super.initState();

    if (widget.phoneNumber.length == 10) {
      formattedPhoneNumber = "+27" + widget.phoneNumber.substring(1);
    }else{
      formattedPhoneNumber = "+27" + widget.phoneNumber;
    }

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
}
