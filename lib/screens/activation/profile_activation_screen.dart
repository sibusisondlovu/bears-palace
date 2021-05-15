import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../colors.dart';
import 'otp_screen.dart';

class ProfileActivationScreen extends StatefulWidget {
  @override
  _ProfileActivationScreenState createState() => _ProfileActivationScreenState();
}

class _ProfileActivationScreenState extends State<ProfileActivationScreen> {

  String _name;
  String _phoneNumber;
  bool isBusyCreatingAccount = false;

  void createUserAccount() async {
    print('creating user account....');

    setState(() {
      isBusyCreatingAccount = true;
    });
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _phoneNumber + '@bearspalace.co.za',
          password: "SuperSecretPassword!@123"
      );

      CollectionReference users = FirebaseFirestore.instance.collection('users');

      users.doc(userCredential.user.uid).set({
        'displayName': _name,
        'uid': userCredential.user.uid,
        'phoneNumber': _phoneNumber,
        'points' : 100,
        'level': 'Basic',
        'avatar': 'https://i.pravatar.cc/300',
        'photos': 0,
        'following': 0,
        'followers': 0,
        'status': 'ACTIVATED',
        'createdAt': DateTime.now().toString()
      })
          .then((value) {
                  CoolAlert.show(
                    context: context,
                    type: CoolAlertType.success,
                    title: "Account Activated",
                    text: "Congratulations, your account has been activated, and you have receive 100BB",
                  );

                  Navigator.pop(context);
      })
          .catchError((error){
              setState(() {
                isBusyCreatingAccount = false;
              });
              CoolAlert.show(
                context: context,
                type: CoolAlertType.error,
                title: "Oops...",
                text: "Sorry, something went wrong \n" + error.toString(),
              );
      });

    } on FirebaseAuthException catch (e) {
      setState(() {
        isBusyCreatingAccount = false;
      });
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that cellphone number.');
      }
    } catch (e) {
      setState(() {
        isBusyCreatingAccount = false;
      });
      print(e);
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: "Oops...",
        text: "Sorry, something went wrong \n" + e.toString(),
      );
    }

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(int.parse(AppColors.primaryColor)),
          title: Text('Profile Activation'),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SizedBox(height: 10,),
                Image.asset('assets/images/activate.png',
                  width: MediaQuery.of(context).size.width * 0.3,),
                SizedBox(height: 20,),
                Text('Activate profile!',
                  style: TextStyle(
                      fontSize: 18,
                  ),
                ),
                SizedBox(height: 10,),
                Text('Thank you for using our app! At the moment you only \n have access to limited functionality. Please give us your \nname and your cellphone number. We will send an OTP \nfor verification to the provided number', textAlign: TextAlign.center,),
                SizedBox(height: 20,),
                _buildForm(context),

                isBusyCreatingAccount? CircularProgressIndicator(): ElevatedButton(
                  onPressed: () {
                    createUserAccount();
                    // check if form is valid
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => OtpScreen(_name,_phoneNumber)));
                  },
                  child: Text(
                    "Activate Profile".toUpperCase(),
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ),
                SizedBox(height: 20,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        child: Column(
          children: [
            TextFormField(
              onChanged: (value){
                _name = value.trim().toUpperCase();
              },
              decoration: new InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30.0),
                    ),
                  ),
                  filled: true,
                  prefixIcon: Icon(Icons.person),
                  labelText: 'First name',
                  ),
            ),
            SizedBox(height: 15,),
            TextFormField(
              keyboardType: TextInputType.phone,
              onChanged: (value){
                _phoneNumber = value.trim();
              },
              decoration: new InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30.0),
                    ),
                  ),
                  prefixIcon: Icon(Icons.phone),
                  prefix: Padding(
                    child: Text('27'),
                    padding: EdgeInsets.only(left: 0, top: 0,right: 10, bottom: 0),
                  ),
                  labelText: 'Cellphone number',
                  filled: true,),
            ),
            SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }
 }
