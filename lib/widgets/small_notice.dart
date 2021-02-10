import 'package:flutter/material.dart';
import 'package:silsiganmetro/pages/notice_page.dart';
import 'package:silsiganmetro/values/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:silsiganmetro/values/dimens.dart';

class SmallNotice extends StatelessWidget {

  Future<Map<String, dynamic>> init() async {
    var response = await http.get(urlNotice);

    Map<String, dynamic> body = json.decode(response.body);
    return body;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      padding: EdgeInsets.symmetric(
        horizontal: Dimens.marginLarge,
      ),
      child: FutureBuilder<Map<String, dynamic>>(
        future: init(),
        builder: (context, snapshot) {
          if(!snapshot.hasData) {
            return Container();
          } else {
            int id = int.parse(snapshot.data['result']['id']);
            String title = snapshot.data['result']['title'];
            String type = snapshot.data['result']['notice_type'];
            String color = snapshot.data['result']['color'] ?? '#000000';

            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NoticePage(id)));
              },
              child: Container(
                child: Row(
                  children: [
                    Text(
                      type,
                      style: TextStyle(
                        color: HexColor(color),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: Dimens.marginLarge,
                    ),
                    Text(
                      title,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}