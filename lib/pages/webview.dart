import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatefulWidget {
  final String? title;
  final String? selectedUrl;

  MyWebView({
    @required this.title,
    @required this.selectedUrl,
  });

  @override
  _MyWebViewState createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  bool isLoading = true;
  late final WebViewController webViewController;

  /* final Completer<WebViewController> _controller =
      Completer<WebViewController>();*/

  @override
  void initState() {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.selectedUrl!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 10), () {
      setState(() {
        isLoading = false;
      });
    });
    return Container(
        margin: const EdgeInsets.only(top: 0.0),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
              widget.title ?? '',
              style: TextStyle(fontFamily: 'Futura', color: Colors.white),
            ),
          ),
          body: SafeArea(
            top: true,
            child: Stack(
              children: [
                WebViewWidget(controller: webViewController),
                Center(
                  child: isLoading ? CircularProgressIndicator() : Container(),
                ),
              ],
            ),
          ),
        ));
  }
}
