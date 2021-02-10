import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:silsiganmetro/foundations/config.dart';
import 'package:silsiganmetro/foundations/global.dart';
import 'package:silsiganmetro/providers/setting_provider.dart';
import 'package:silsiganmetro/values/constants.dart';
import 'package:silsiganmetro/values/dimens.dart';

class LobbyTrain extends StatelessWidget {

  LobbyTrain({
    @required this.updown,
    @required this.number,
    @required this.dst,
    @required this.status,
  }) : assert(updown != null),
       assert(number != null),
       assert(dst != null),
       assert(status != null);

  final String updown;

  final String number;

  final String dst;

  final String status;

  @override
  Widget build(BuildContext context) {
    final SettingProvider provider = Provider.of<SettingProvider>(context);
    bool invert = provider.invertOutline;
    String head = updown == UP ? 'up' : 'down';
    String image;

    if(Theme.of(context).brightness == Brightness.light) {
      if(!invert) {
        image = 'train_${head}_light.png';
      } else {
        image = 'train_${head}_dark.png';
      }
    } else {
      if(!invert) {
        image = 'train_${head}_dark.png';
      } else {
        image = 'train_${head}_light.png';
      }
    }

    return Container(
      margin: EdgeInsets.only(
        right: Dimens.margin2x,
      ),
      child: Stack(
        children: <Widget>[
          RotatedBox(
            quarterTurns: 3,
            child: Container(
              width: 20,
              height: 35,
              transform: Matrix4.translationValues(-2, 6.5, 0),
              child: Image.asset('assets/images/$image', fit: BoxFit.cover,),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 19,
              left: 8
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  dst,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  status,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    height: 1,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LobbyTextTrain extends StatelessWidget {

  LobbyTextTrain({
    @required this.metro,
    this.station,
    this.dst,
    this.status,
    this.number,
    this.time = 60000,
    this.message = '',
  }) : assert(metro != null);

  final Metro metro;

  final String station;

  final String dst;

  final String status;

  final String number;

  final int time;

  final String message;

  @override
  Widget build(BuildContext context) {

    String arrivalStatus;
    switch(status) {
      case '0':
        arrivalStatus = '진입';
        break;

      case '1':
        arrivalStatus = '도착';
        break;

      case '2':
        arrivalStatus = '출발';
        break;

      case '3':
        arrivalStatus = '전 역 출발';
        break;

      case '4':
        arrivalStatus = '전 역 진입';
        break;

      case '5':
        arrivalStatus = '전 역 도착';
        break;

      case '99':
        arrivalStatus = '도착';
        break;

      default:
        arrivalStatus = '정보 없음';
        break;
    }

    Widget box;
    EdgeInsets boxPadding = EdgeInsets.symmetric(
      vertical: 2,
      horizontal: 2,
    );

    switch(status) {
      case '0':   // 진입
      case '1':   // 도착
      box = Container(
        padding: boxPadding,
        decoration: BoxDecoration(
          color: Theme.of(context).dividerColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(3),
          border: Border.all(
            width: Global.pixel,
            color: Theme.of(context).dividerColor,
          ),
        ),
        child: Text(
          ' $arrivalStatus ',
          style: TextStyle(
            height: 1,
            color: Colors.lightBlue,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
      break;

      case '3':   // 전 역 진입
      case '4':   // 전 역 도착
      case '5':   // 전 역 출발
        box = Container(
          padding: boxPadding,
          decoration: BoxDecoration(
            color: Theme.of(context).dividerColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(3),
            border: Border.all(
              width: Global.pixel,
              color: Theme.of(context).dividerColor,
            ),
          ),
          child: Text(
            ' $arrivalStatus ',
            style: TextStyle(
              height: 1,
              color: Colors.deepOrangeAccent,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
        break;


      case '2':   // 출발
        box = Container(
          padding: boxPadding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            border: Border.all(
              width: Global.pixel,
              color: Theme.of(context).dividerColor,
            ),
          ),
          child: Text(
            ' $arrivalStatus ',
            style: TextStyle(
              height: 1,
              color: Theme.of(context).textTheme.caption.color,
              fontSize: 12,
            ),
          ),
        );
        break;

      case '99':
        String text = '';
        String subText = station;

        if(time > 0) {
          int min = time ~/ 60;
          int sec = time % 60;

          text = '$min분';

          if(min == 0) {
            text = '$sec초';
          }
        } else {
          RegExp reg = RegExp(r'\[(\d+)\].*');
          if(reg.hasMatch(message)) {
            Match match = reg.firstMatch(message);
            text = '${match.group(1)}전 역';
          }
        }

        RegExp regStation = RegExp(r'(.*)\(.*\)');
        if(regStation.hasMatch(subText)) {
          Match match = regStation.firstMatch(subText);
          subText = match.group(1);
        }

        box = Container(
          decoration: BoxDecoration(
            color: Theme.of(context).dividerColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(3),
            border: Border.all(
              width: Global.pixel,
              color: Theme.of(context).dividerColor,
            ),
          ),
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 2,
                  horizontal: 2,
                ),
                alignment: Alignment.center,
                child: Text(
                  ' $text ',
                  style: TextStyle(
                    height: 1,
                    color: Theme.of(context).textTheme.caption.color,
                    fontSize: 12,
                  ),
                ),
              ),
              Container(
                width: Global.pixel,
                color: Theme.of(context).dividerColor,
              ),
              Container(
                height: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: 2,
                  horizontal: 2,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(3),
                    bottomRight: Radius.circular(3),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  ' $subText ',
                  style: TextStyle(
                    height: 1,
                    color: Theme.of(context).textTheme.caption.color,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        );
        break;

      default:
        box = Container();
        break;
    }

    String trainDst;
    bool last = false;

    switch(dst) {
      case '성수종착':
      case '내선순환':
      case '외선순환':
      case '응암순환':
        trainDst = dst;
        break;

      default:
        RegExp regExp = RegExp(r'(.*) \(막차\)');

        if(regExp.hasMatch(dst)) {
          last = true;
          Match match = regExp.firstMatch(dst);
          trainDst = match.group(1);
        } else {
          trainDst = dst;
        }

        if(trainDst == '응암순환(상선)') {
          trainDst = '응암순환';
        } else {
          trainDst = destinations[trainDst] ?? trainDst;
          trainDst = '$trainDst행';
        }
        break;
    }

    return Container(
      height: 20,
      child: Row(
        children: <Widget>[
          Text(
            trainDst,
          ),
          SizedBox(
            width: Dimens.marginSmall,
          ),
          Visibility(
            visible: last,
            child: Container(
              height: double.infinity,
              margin: EdgeInsets.only(
                right: 8,
              ),
              padding: EdgeInsets.symmetric(
                vertical: 2,
                horizontal: 2,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                border: Border.all(
                  width: Global.pixel,
                  color: Colors.red,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                ' 막차 ',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          box,
        ],
      ),
    );
  }
}
