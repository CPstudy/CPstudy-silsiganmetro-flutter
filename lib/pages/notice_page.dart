import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:silsiganmetro/foundations/custom_theme.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class NoticePage extends StatefulWidget {
  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  Future<String> init() async {
    var response = await http.get('https://raw.githubusercontent.com/CPstudy/cpstudy.github.io/master/_posts/%EC%8B%A4%EC%8B%9C%EA%B0%84%EC%A7%80%ED%95%98%EC%B2%A0%20%EA%B0%9C%EB%B0%9C/2020-10-07-%EC%8B%A4%EC%8B%9C%EA%B0%84%EC%A7%80%ED%95%98%EC%B2%A0%206.0.0.md');
    String result = response.body.replaceAll(RegExp(r'---(.|\n)*---'), '');
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '공지사항',
        ),
      ),
      body: Theme(
        data: ThemeData.light(),
        child: FutureBuilder<String>(
          future: init(),
          builder: (context, snapshot) {
            switch(snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );

              default:
                if(!snapshot.hasData) {
                  return Center(
                    child: Text(
                      '내용을 불러오는데 실패했습니다.',
                    ),
                  );
                } else {
                  return Container(
                    child: Markdown(
                      data: snapshot.data,
                      styleSheet: MarkdownStyleSheet(
                        code: TextStyle(
                          backgroundColor: Colors.black.withOpacity(0.2),
                        ),
                      ),
                    ),
                  );
                }
            }
          },
        ),
      ),
    );
  }
}
