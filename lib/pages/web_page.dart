import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatefulWidget {

  WebPage({
    @required this.title,
    @required this.url,
  }) : assert(title != null),
       assert(url != null);

  final String title;

  final String url;

  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
      ),
      body: WebView(
        initialUrl: widget.url,
      ),
    );
  }
}
