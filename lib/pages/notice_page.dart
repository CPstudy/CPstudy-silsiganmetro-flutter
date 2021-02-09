import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:silsiganmetro/foundations/custom_theme.dart';
import 'package:silsiganmetro/foundations/global.dart';
import 'package:silsiganmetro/values/constants.dart';
import 'package:silsiganmetro/values/dimens.dart';
import 'package:silsiganmetro/widgets/metro.dart';
import 'package:silsiganmetro/widgets/small_notice.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class NoticePage extends StatefulWidget {

  NoticePage(this.id);

  final int id;

  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  Future<Map<String, dynamic>> init() async {
    var response = await http.get(urlNotice + '?page=${widget.id}');
    Map<String, dynamic> body = json.decode(response.body);
    return body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        title: Text(
          '공지사항',
        ),
      ),
      body: WebView(
        initialUrl: 'https://guk2zzada.com/silsiganmetro/cs/notice-view.php?notice_id=${widget.id}',
      ),
      // body: FutureBuilder<Map<String, dynamic>>(
      //   future: init(),
      //   builder: (context, snapshot) {
      //     switch(snapshot.connectionState) {
      //       case ConnectionState.none:
      //       case ConnectionState.waiting:
      //         return Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       default:
      //         if(!snapshot.hasData) {
      //           return Center(
      //             child: Text(
      //               '내용을 불러오는데 실패했습니다.',
      //             ),
      //           );
      //         } else {
      //           return SingleChildScrollView(
      //             padding: EdgeInsets.all(Dimens.marginMedium),
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Container(
      //                   padding: EdgeInsets.all(Dimens.marginDefault),
      //                   decoration: BoxDecoration(
      //                     border: Border.all(
      //                       color: Theme.of(context).dividerColor,
      //                       width: Global.pixel,
      //                     ),
      //                     borderRadius: BorderRadius.circular(5.0),
      //                     color: Theme.of(context).cardColor,
      //                   ),
      //                   child: Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       Text(
      //                         snapshot.data['result']['notice_type'],
      //                         style: TextStyle(
      //                           color: HexColor(snapshot.data['result']['color']),
      //                           fontWeight: FontWeight.bold,
      //                         ),
      //                       ),
      //                       Container(
      //                         margin: EdgeInsets.only(
      //                           bottom: 4,
      //                         ),
      //                         child: Text(
      //                           snapshot.data['result']['title'],
      //                           style: TextStyle(
      //                             fontSize: 20,
      //                           ),
      //                         ),
      //                       ),
      //                       Align(
      //                         alignment: Alignment.centerRight,
      //                         child: Text(
      //                           snapshot.data['result']['create_date'],
      //                           style: Theme.of(context).textTheme.caption,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //                 Html(
      //                   data: snapshot.data['result']['content'],
      //                 ),
      //               ],
      //             ),
      //           );
      //         }
      //     }
      //   },
      // ),
    );
  }
}
