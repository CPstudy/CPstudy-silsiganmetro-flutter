import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:silsiganmetro/dto/dto.dart';
import 'package:silsiganmetro/dto/traindto.dart';
import 'package:silsiganmetro/foundations/global.dart';
import 'package:silsiganmetro/pages/web_page.dart';
import 'package:silsiganmetro/providers/setting_provider.dart';
import 'package:silsiganmetro/values/constants.dart';
import 'package:sprintf/sprintf.dart';
import 'package:url_launcher/url_launcher.dart';

class Train extends StatelessWidget {

  Train({
    @required this.metro,
    @required this.dto,
  }) : assert(dto != null);

  final Metro metro;

  final TrainDTO dto;

  String getImage(BuildContext context) {
    final SettingProvider settingProvider = Provider.of<SettingProvider>(context);
    TrainIconData icon = settingProvider.trainIconData;

    return icon.getIcon(dto.head, Theme.of(context).brightness, settingProvider.invertOutline);
  }

  String getExpressIcon(BuildContext context) {
    final SettingProvider settingProvider = Provider.of<SettingProvider>(context);

    Brightness brightness = Theme.of(context).brightness;
    bool invert = settingProvider.invertOutline;

    if(brightness == Brightness.light) {
      if(!invert) {
        return 'assets/images/icon_express_light.png';
      } else {
        return 'assets/images/icon_express_dark.png';
      }
    } else {
      if(!invert) {
        return 'assets/images/icon_express_dark.png';
      } else {
        return 'assets/images/icon_express_light.png';
      }
    }
  }

  void clickTrain(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: Column(
          children: [
            Text(
              '#${dto.no}'
            ),
            CupertinoTextField(),
          ],
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () => inputTrainPrimary(context),
            child: Text(
              '편성번호 입력',
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: openRailBlue,
            child: Text(
              '레일.블루 열차 정보',
            ),
          ),
        ],
      )
    );
  }

  inputTrainPrimary(BuildContext context)  {
    String url = sprintf(urlTrain, [metros[metro].number, dto.no]);
    Navigator.push(context, MaterialPageRoute(builder: (context) => WebPage(title: '#${dto.no}', url: url)));
  }

  Future openRailBlue() async {
    String date = Global().getTimetableDate();
    String railBlue = 'https://rail.blue/railroad/logis/Default.aspx?train=%s&date=%s#!';
    String url = 'https://rail.blue';

    switch(metro) {
      case Metro.line1:
      case Metro.line3:
      case Metro.line4:
        url = sprintf(railBlue, [dto.no, date]);
        break;

      case Metro.line2:
        url = sprintf(railBlue, ['S${dto.no}', date]);
        break;

      case Metro.line5:
      case Metro.line6:
      case Metro.line7:
      case Metro.line8:
        url = sprintf(railBlue, ['SMRT${dto.no}', date]);
        break;

      case Metro.line9:
        if(dto.express == '0') {
          url = sprintf(railBlue, ['SNC${dto.no}', date]);
        } else {
          url = sprintf(railBlue, ['SNE${dto.no}', date]);
        }
        break;

      case Metro.gyeonguijungang:
      case Metro.suinbundang:
      case Metro.gyeongchun:
        url = sprintf(railBlue, ['K${dto.no}', date]);
        break;

      case Metro.dxline:
        url = sprintf(railBlue, ['DX${dto.no}', date]);
        break;

      case Metro.airport:
        url = sprintf(railBlue, ['${dto.no}', date]);
        break;

      case Metro.uisinseol:
        url = sprintf(railBlue, ['UI${dto.no}', date]);
        break;

      default:
        break;
    }

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final SettingProvider settingProvider = Provider.of<SettingProvider>(context);
    final double _iconSize = 25;

    String status;

    switch(dto.status) {
      case ARRIVAL:
        status = '도착';
        break;

      case DEPARTURE:
        status = '출발';
        break;

      case APPROACHING:
        status = '진입';
        break;

      default:
        status = '운행';
        break;
    }

    return Container(
      width: 90,
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          InkWell(
            onTap: () => clickTrain(context),
            child: Container(
              width: 60,
              padding: EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Theme.of(context).dividerColor.withOpacity(0.3),
                  width: Global.pixel
                ),
                color: Theme.of(context).backgroundColor,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    '${dto.dst}',
                    style: TextStyle(
                      fontSize: settingProvider.trainFontSize,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                  Text(
                    '${dto.no}',
                    style: TextStyle(
                      fontSize: settingProvider.trainFontSize,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                  Visibility(
                    visible: settingProvider.showStatus,
                    child: Text(
                      status,
                      style: TextStyle(
                        fontSize: settingProvider.trainFontSize,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: (dto.head == UP) ? true : false,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Stack(
                children: [
                  Container(
                    width: _iconSize,
                    height: _iconSize,
                    child: Image.asset(getImage(context)),
                  ),
                  Visibility(
                    visible: dto.express != '0',
                    child: Container(
                      width: _iconSize,
                      height: _iconSize,
                      child: Image.asset(getExpressIcon(context)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: (dto.head == DOWN) ? true : false,
            child: Align(
              alignment: Alignment.centerRight,
              child: Stack(
                children: [
                  Container(
                    width: _iconSize,
                    height: _iconSize,
                    child: Image.asset(getImage(context)),
                  ),
                  Visibility(
                    visible: dto.express != '0',
                    child: Container(
                      width: _iconSize,
                      height: _iconSize,
                      child: Image.asset(getExpressIcon(context)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
