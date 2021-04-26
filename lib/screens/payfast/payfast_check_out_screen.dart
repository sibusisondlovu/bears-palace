import 'dart:async';

import 'package:bears_palace_app/colors.dart';
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
    showLoading = ls;
  }

  @override
  Widget build(BuildContext context) {

   Map<String, dynamic> snap = ModalRoute.of(context).settings.arguments;


    return Scaffold(
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
            initialUrl: "https://sandbox.payfast.co.za/eng/process?merchant_id=10016997&merchant_key=nu1lp792ph3wp&amount="+snap['totalAmount'].toString()+ "&item_name=" + snap['bookingReferenceNumber'].toString()+"&return_url=https://kidi.co.za/payfast/success.php&cancel_url=https://kidi.co.za/payfast/cancel.php&notify_url=https://kidi.co.za/payfast/notify.php&m_payment_id="+ snap['bookingReferenceNumber'].toString(),

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

    );
  }

}
