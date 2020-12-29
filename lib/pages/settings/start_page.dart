import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:silsiganmetro/dto/dto.dart';
import 'package:silsiganmetro/foundations/config.dart';
import 'package:silsiganmetro/foundations/global.dart';
import 'package:silsiganmetro/providers/setting_provider.dart';
import 'package:silsiganmetro/values/dimens.dart';
import 'package:silsiganmetro/widgets/metro.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SettingProvider provider = Provider.of<SettingProvider>(context);

    List<LineData> list = List();

    metros.forEach((key, value) {
      list.add(value);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('첫 화면 설정'),
      ),
      body: ListView.separated(
        itemCount: list.length + 1,
        itemBuilder: (context, index) {
          if(index == 0) {
            return InkWell(
              onTap: () {
                provider.startPage = 0;
              },
              child: Container(
                height: 50,
                color: Theme.of(context).cardColor,
                padding: EdgeInsets.symmetric(
                  horizontal: Dimens.marginLarge
                ),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '로비',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Visibility(
                        visible: provider.startPage == 0,
                        child: Icon(
                          CupertinoIcons.check_mark_circled,
                          size: 20,
                          color: CupertinoColors.systemGreen,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            LineData data = list[index - 1];

            return InkWell(
              onTap: () {
                provider.startPage = data.number;
              },
              child: Container(
                height: 50,
                padding: EdgeInsets.symmetric(
                  horizontal: Dimens.marginLarge
                ),
                color: Theme.of(context).cardColor,
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        data.name,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Visibility(
                        visible: provider.startPage == data.number,
                        child: Icon(
                          CupertinoIcons.check_mark_circled,
                          size: 20,
                          color: CupertinoColors.systemGreen,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
        separatorBuilder: (context, index) => MetroDivider(),
      ),
    );
  }
}
