import 'dart:convert';

import 'package:aqar_bazar/constants.dart';
import 'package:aqar_bazar/providers/payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PayPalScreen extends StatefulWidget {
  @override
  _PayPalScreenState createState() => _PayPalScreenState();
}

class _PayPalScreenState extends State<PayPalScreen> {
  WebViewController webViewController;

  loadLocalHTML() async {
    String h = '';
    print('test7 '+Provider.of<PaymentProvider>(context,listen: false).html.toString());

    webViewController.loadUrl(Uri.dataFromString(
            Provider.of<PaymentProvider>(context,listen: false).html,
            mimeType: 'text/html',
            encoding: Encoding.getByName('utf-8'))
        .toString());


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Payment screen')),
      body: Provider.of<PaymentProvider>(context).isLoading()
          ? Center(
              child: CircularProgressIndicator(
              backgroundColor: fBlue,
            ))
          : WebView(
              initialUrl: '',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController tmp) {
                webViewController = tmp;
                loadLocalHTML();
                print('webviewcontrol :' + webViewController.toString());
                print('test778 '+ Provider.of<PaymentProvider>(context,listen: false).html.toString());
              },
            ),
    );
  }
}

// body:Provider.of<PaymentProvider>(context).isLoading()?Center(child: CircularProgressIndicator(backgroundColor: fBlue,)):
// WebView(
// initialUrl: '',
// javascriptMode: JavascriptMode.unrestricted,
// onWebViewCreated: (WebViewController tmp) {
// webViewController = tmp;
// loadLocalHTML();
// print('webviewcontrol :'+webViewController.toString());
// },
// ),
