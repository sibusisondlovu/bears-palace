import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ConfirmPaymentScreen extends StatefulWidget {
  const ConfirmPaymentScreen({Key key}) : super(key: key);

  @override
  _ConfirmPaymentScreenState createState() => _ConfirmPaymentScreenState();
}

class _ConfirmPaymentScreenState extends State<ConfirmPaymentScreen> {
  final Completer<WebViewController> _webViewController = Completer<WebViewController> ();
  bool showLoading = false;

  void updateLoading(bool ls) {
    showLoading = ls;
  }

  @override
  Widget build(BuildContext context) {

    Map<String, dynamic> snap = ModalRoute.of(context).settings.arguments;


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Carolina Resort ', style: TextStyle(

        ),),
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            //initialUrl: "https://sandbox.payfast.co.za/eng/process?merchant_id=10016997&merchant_key=nu1lp792ph3wp&amount="+snap['totalAmount'].toString()+ "&item_name=" + snap['orderNumber'].toString()+"&return_url=https://kidi.co.za/payfast/success.php&cancel_url=https://kidi.co.za/payfast/cancel.php&notify_url=https://kidi.co.za/payfast/notify.php&m_payment_id="+ snap['orderNumber'].toString(),
            initialUrl: "https://jaspa.co.za",
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
