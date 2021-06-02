import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ConfirmPaymentScreen extends StatefulWidget {

  final String totalAmount;
  final String itemName;
  final String paymentId;
  const ConfirmPaymentScreen({Key key, this.itemName, this.paymentId, this.totalAmount}) : super(key: key);

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

    print('Reference number for this booking is ' + widget.paymentId);
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
