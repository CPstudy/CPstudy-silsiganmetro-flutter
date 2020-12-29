import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:silsiganmetro/components/double_rail.dart';
import 'package:silsiganmetro/components/single_rail.dart';
import 'package:silsiganmetro/dto/stationdto.dart';
import 'package:silsiganmetro/foundations/global.dart';
import 'package:silsiganmetro/providers/setting_provider.dart';
import 'package:silsiganmetro/values/dimens.dart';
import 'package:silsiganmetro/widgets/metro.dart';

class ItemDouble extends StatelessWidget {

  ItemDouble({
    @required this.context,
    @required this.metro,
    @required this.station,
    this.right: false,
    this.onTap,
    this.onLongPress,
    this.isSelected = false,
  }) : assert(context != null),
       assert(metro != null),
       assert(station != null);

  final BuildContext context;

  /// 라인
  final bool right;

  /// 노선
  final Metro metro;

  /// 역
  final Station station;

  final GestureTapCallback onTap;

  final GestureLongPressCallback onLongPress;

  final bool isSelected;

  Widget drawStationText() {
    final SettingProvider provider = Provider.of<SettingProvider>(context);
    String text = station.text;
    bool hasText = (text == '') ? false : true;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Text(
              station.name,
              style: TextStyle(
                fontSize: provider.stationFontSize,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 3
                  ..strokeCap = StrokeCap.round
                  ..strokeJoin = StrokeJoin.round
                  ..color = Theme.of(context).cardColor,
              ),
            ),
            Text(
              station.name,
              maxLines: 1,
              style: TextStyle(
                fontSize: provider.stationFontSize,
              ),
            ),
          ],
        ),
        Visibility(
          visible: hasText,
          child: Stack(
            children: <Widget>[
              Text(
                text,
                style: TextStyle(
                  fontSize: provider.stationFontSize * 0.65,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 3
                    ..strokeCap = StrokeCap.round
                    ..strokeJoin = StrokeJoin.round
                    ..color = Theme.of(context).cardColor,
                ),
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: provider.stationFontSize * 0.65,
                  color: Theme.of(context).textTheme.caption.color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget drawSingleLeftLine() {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 252),
          child: drawStationText()
        ),
        DoubleRail(metro: metro, station: station),
      ],
    );
  }

  Widget drawSingleRightLine() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(left: 16),
              child: drawStationText(),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              child: DoubleRail(metro: metro, station: station),
            ),
          ),
        ],
      ),
    );
  }

  Widget drawDivider() {
    return Container(
      height: 25,
      padding: EdgeInsets.only(left: Dimens.marginDefault),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          station.name,
          style: TextStyle(
            color: Theme.of(context).textTheme.caption.color,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final SettingProvider provider = Provider.of<SettingProvider>(context);

    if(station.no == '1000000000') {
      return drawDivider();
    } else {
      return InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Container(
          height: provider.lineHeight,
          color: isSelected ? Theme.of(context).accentColor.withOpacity(0.1) : Theme.of(context).cardColor,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                child: MetroDivider(),
              ),
              right ? drawSingleRightLine() : drawSingleLeftLine(),
            ],
          )
        ),
      );
    }
  }
}