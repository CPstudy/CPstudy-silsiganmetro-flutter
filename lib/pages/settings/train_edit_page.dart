import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:silsiganmetro/components/item_double.dart';
import 'package:silsiganmetro/components/item_single.dart';
import 'package:silsiganmetro/dto/dto.dart';
import 'package:silsiganmetro/dto/stationdto.dart';
import 'package:silsiganmetro/dto/traindto.dart';
import 'package:silsiganmetro/foundations/global.dart';
import 'package:silsiganmetro/pages/setting_page.dart';
import 'package:silsiganmetro/providers/setting_provider.dart';
import 'package:silsiganmetro/values/constants.dart';
import 'package:silsiganmetro/values/dimens.dart';

class TrainEditPage extends StatelessWidget {

  List<Widget> trainIcons(BuildContext context) {
    final SettingProvider provider = Provider.of<SettingProvider>(context);
    List<TrainIconData> icons = Global().trainIcons;
    List<Widget> list = List();

    for(int i = 0; i < icons.length; i++) {
      TrainIconData data = icons[i];

      list.add(
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            provider.trainIconIndex = i;
          },
          child: Container(
            width: 40,
            height: 40,
            margin: EdgeInsets.symmetric(
              horizontal: Dimens.marginTiny,
            ),
            padding: EdgeInsets.all(Dimens.marginTiny),
            decoration: BoxDecoration(
              border: Border.all(
                width: provider.trainIconIndex == i ? 2 : Global.pixel,
                color: provider.trainIconIndex == i ? CupertinoColors.systemGreen : Theme.of(context).dividerColor,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Image.asset(data.getIcon(UP, Theme.of(context).brightness, provider.invertOutline)),
          ),
        )
      );
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    final SettingProvider provider = Provider.of<SettingProvider>(context);
    int lineHeight = provider.lineHeight.toInt();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '열차 리스트 설정',
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 160,
            child: TrainPreview(),
          ),
          Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    SettingSection(
                      header: Text(
                        '리스트 높이',
                      ),
                      footer: Text(
                        '기본값 60'
                      ),
                      items: <Widget>[
                        SettingItem(
                          cover: Row(
                            children: <Widget>[
                              SizedBox(
                                width: Dimens.marginDefault,
                              ),
                              Container(
                                width: 40,
                                alignment: Alignment.center,
                                child: Text(
                                  '${provider.lineHeight.toInt()}',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  constraints: BoxConstraints.expand(),
                                  child: CupertinoSlider(
                                    value: provider.lineHeight,
                                    onChanged: (value) {
                                      provider.lineHeight = value;
                                    },
                                    min: 50.0,
                                    max: 80.0,
                                    divisions: 30,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Dimens.marginDefault,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SettingSection(
                      header: Text('아이콘'),
                      items: <Widget>[
                        SettingItem(
                          title: Text('오른쪽에 표시'),
                          child: CupertinoSwitch(
                            value: provider.right,
                            onChanged: (value) => provider.right = value,
                          ),
                        ),
                        SettingItem(
                          title: Text('상태 정보 표시'),
                          child: CupertinoSwitch(
                            value: provider.showStatus,
                            onChanged: (value) => provider.showStatus = value,
                          ),
                        ),
                        SettingItem(
                          title: Text('테두리 색 반전'),
                          child: CupertinoSwitch(
                            value: provider.invertOutline,
                            onChanged: (value) => provider.invertOutline = value,
                          ),
                        ),
                        SettingItem(
                          height: 60,
                          cover: Container(
                            width: double.infinity,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Dimens.marginLarge,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: trainIcons(context),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SettingSection(
                      header: Text(
                        '열차 정보 글자 크기',
                      ),
                      footer: Text(
                        '기본값 11'
                      ),
                      items: <Widget>[
                        SettingItem(
                          cover: Row(
                            children: <Widget>[
                              SizedBox(
                                width: Dimens.marginDefault,
                              ),
                              Container(
                                width: 40,
                                alignment: Alignment.center,
                                child: Text(
                                  '${provider.trainFontSize.toInt()}',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  constraints: BoxConstraints.expand(),
                                  child: CupertinoSlider(
                                    value: provider.trainFontSize,
                                    onChanged: (value) {
                                      provider.trainFontSize = value;
                                    },
                                    min: 8,
                                    max: 20,
                                    divisions: 13,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Dimens.marginDefault,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SettingSection(
                      header: Text(
                        '역 이름 글자 크기',
                      ),
                      footer: Text(
                        '기본값 16'
                      ),
                      items: <Widget>[
                        SettingItem(
                          cover: Row(
                            children: <Widget>[
                              SizedBox(
                                width: Dimens.marginDefault,
                              ),
                              Container(
                                width: 40,
                                alignment: Alignment.center,
                                child: Text(
                                  '${provider.stationFontSize.toInt()}',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  constraints: BoxConstraints.expand(),
                                  child: CupertinoSlider(
                                    value: provider.stationFontSize,
                                    onChanged: (value) {
                                      provider.stationFontSize = value;
                                    },
                                    min: 10,
                                    max: 24,
                                    divisions: 15,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Dimens.marginDefault,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TrainPreview extends StatelessWidget {

  final String _dst = '열차행선지';
  final String _trainNo = 'S1234';

  @override
  Widget build(BuildContext context) {
    final SettingProvider provider = Provider.of<SettingProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ItemSingle(
          context: context,
          metro: Metro.line2,
          right: provider.right,
          station: Station(
            name: '역 이름',
            text: '추가 정보가 여기에 표시됩니다.',
            list: [
              TrainDTO(
                dst: _dst,
                no: _trainNo,
              ),
              TrainDTO(
                dst: _dst,
                no: _trainNo,
                head: DOWN,
              ),
            ],
          ),
        ),
        ItemDouble(
          context: context,
          metro: Metro.line2,
          right: provider.right,
          station: Station(
            name: '역 이름',
            text: '추가 정보가 여기에 표시됩니다.',
            list: [
              TrainDTO(
                dst: _dst,
                no: _trainNo,
              ),
              TrainDTO(
                dst: _dst,
                no: _trainNo,
                express: '1',
              ),
              TrainDTO(
                dst: _dst,
                no: _trainNo,
                head: DOWN,
              ),
              TrainDTO(
                dst: _dst,
                no: _trainNo,
                head: DOWN,
                express: '1',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
