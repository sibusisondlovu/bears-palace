import 'dart:async';

import 'package:bears_palace_app/colors.dart';
import 'package:bears_palace_app/root_layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PayfastCheckOutScreen extends StatefulWidget {
  @override
  _PayfastCheckOutScreenState createState() => _PayfastCheckOutScreenState();
}

class _PayfastCheckOutScreenState extends State<PayfastCheckOutScreen> {

  final Completer<WebViewController> _webViewController = Completer<WebViewController> ();
  bool showLoading = false;

  void updateLoading(bool ls) {
    setState(() {
      showLoading = ls;
    });
  }

  Future<bool> _onBackPressed() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => RootLayoutScreen(),
    ));
    return null;
  }

  @override
  Widget build(BuildContext context) {

   Map<String, dynamic> snap = ModalRoute.of(context).settings.arguments;

    return WillPopScope(
      onWillPop: (){
        _onBackPressed();
        return null;
      },
      child: Scaffold(
        backgroundColor: Color(int.parse(AppColors.primaryColor)),
        appBar: AppBar(
          backgroundColor: Color(int.parse(AppColors.primaryColor)),
          title: Text('The Bears Palace', style: TextStyle(
              fontFamily: 'bold'
          ),),
        ),
        body: Stack(
          children: <Widget>[
            WebView(
              initialUrl: "https://sandbox.payfast.co.za/eng/process?merchant_id=10016997&merchant_key=nu1lp792ph3wp&amount="+snap['totalAmount'].toString()+ "&item_name=" + snap['bookingReferenceNumber'].toString()+"&return_url=https://backend.bearspalace.co.za/payfast_integration/success.html&cancel_url=https://backend.bearspalace.co.za/payfast_integration/cancel.html&notify_url=https://backend.bearspalace.co.za/payfast_integration/notify.phpl&m_payment_id="+ snap['bookingReferenceNumber'].toString(),

              onPageFinished: (data){
                updateLoading(false);
              },
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (webViewController){
                _webViewController.complete(webViewController);
              },
            ),
            showLoading? Center(child: CircularProgressIndicator(),):Center()
          ],
        ),

      ),
    );
  }

}
