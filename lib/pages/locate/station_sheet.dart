import 'package:admob_flutter/admob_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:silsiganmetro/dto/dto.dart';
import 'package:silsiganmetro/dto/stationdto.dart';
import 'package:silsiganmetro/foundations/global.dart';
import 'package:silsiganmetro/managers/line.dart';
import 'package:silsiganmetro/providers/setting_provider.dart';
import 'package:silsiganmetro/values/dimens.dart';
import 'package:sprintf/sprintf.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;

class StationSheet extends StatefulWidget {

  StationSheet({
    @required this.index,
    @required this.station,
    @required this.lineData,
  }) : assert(index != null),
       assert(station != null),
       assert(lineData != null);

  final int index;

  final Station station;

  final LineData lineData;

  @override
  _StationSheetState createState() => _StationSheetState();
}

class _StationSheetState extends State<StationSheet> {

  AdmobBannerSize bannerSize;

  @override
  void initState() {
    super.initState();

    Admob.requestTrackingAuthorization();
    bannerSize = AdmobBannerSize.MEDIUM_RECTANGLE;
  }

  @override
  Widget build(BuildContext context) {

    final SettingProvider provider = Provider.of<SettingProvider>(context);

    Metro metro = widget.lineData.metro;
    LineData lineData = metros[metro];
    double _sheetHeight = 352 + bannerSize.height.toDouble() + 64;
    double _radius = 10.0;
    double _buttonHeight = 50.0;

    String prevStation = Global().getPrevStation(metro, widget.station.no);
    String nextStation = Global().getNextStation(metro, widget.station.no);

    bool hasPrev = prevStation != '종착역 방면' && prevStation != '없음 방면';
    bool hasNext = nextStation != '종착역 방면' && nextStation != '없음 방면';

    String stationCode = provider.getPinStation(metro);
    List<Station> list = Line().getStations(metro);

    bool pin = false;

    String s = '${list[widget.index].no}:${list[widget.index].subNo}';
    print('s = $s ::: stationCode = $stationCode');
    if(s == stationCode) {
      pin = true;
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.symmetric(
          horizontal: Dimens.marginDefault,
        ),
        alignment: Alignment.bottomCenter,
        child: Container(
          height: MediaQuery.of(context).size.height - (ui.window.padding.top / ui.window.devicePixelRatio) - Dimens.marginDefault,
          decoration: BoxDecoration(
            color: Theme.of(context).dialogBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(_radius),
              topRight: Radius.circular(_radius),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: AdmobBanner(
                    adUnitId: Global().getBannerAdUnitId(2),
                    adSize: bannerSize,
                  ),
                ),
              ),
              Container(
                height: 60,
                margin: EdgeInsets.symmetric(
                  horizontal: Dimens.marginDefault,
                ),
                decoration: BoxDecoration(
                  color: lineData.color,
                  borderRadius: BorderRadius.circular(_radius),
                ),
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        '${widget.station.name}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(_radius),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: InkWell(
                              onTap: () {
                                if(pin) {
                                  provider.setPinStation(metro, '0', '0');
                                  pin = false;
                                } else {
                                  provider.setPinStation(metro, widget.station.no, widget.station.subNo);
                                }
                              },
                              child: Icon(
                                pin ? CupertinoIcons.pin : CupertinoIcons.pin_slash,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(_radius),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                CupertinoIcons.clear,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: Dimens.marginLarge,
                color: Theme.of(context).dialogBackgroundColor,
              ),
              Container(
                height: 280,
                padding: EdgeInsets.symmetric(
                  horizontal: Dimens.marginLarge,
                ),
                color: Theme.of(context).dialogBackgroundColor,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: SizedBox(
                              height: _buttonHeight,
                              child: OutlineButton(
                                onPressed: () async {
                                  String railBlueLine = lineData.railBlueLine;
                                  String railBlue = 'https://rail.blue/railroad/logis/metrotimetable.aspx?q=%s&c=%s#!';
                                  String url = sprintf(railBlue, [widget.station.name, railBlueLine]);
                                  url = Uri.encodeFull(url);

                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      CupertinoIcons.time,
                                      color: Theme.of(context).iconTheme.color.withOpacity(0.6),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            '시간표 보기',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(
                                            width: Dimens.marginDefault,
                                          ),
                                          Icon(
                                            CupertinoIcons.square_arrow_up,
                                            size: 10,
                                            color: Theme.of(context).iconTheme.color.withOpacity(0.6),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: Dimens.marginLarge,
                          bottom: Dimens.marginDefault,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '로비에 추가',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: SizedBox(
                              height: _buttonHeight,
                              child: OutlineButton(
                                onPressed: () async {
                                  await provider.addStationLobby(data: lineData, station: widget.station, index: widget.index);
                                  Fluttertoast.showToast(msg: '로비에 추가했어요!');
                                },
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      CupertinoIcons.star,
                                      color: Theme.of(context).iconTheme.color.withOpacity(0.6),
                                    ),
                                    Expanded(
                                      child: Text(
                                        '즐겨찾기',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Dimens.marginDefault,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: _buttonHeight,
                              child: OutlineButton(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Dimens.marginMedium
                                ),
                                onPressed: () async {
                                  await provider.addRealStationLobby(type: LobbyItemType.real, data: lineData, station: widget.station, index: widget.index);
                                  Fluttertoast.showToast(msg: '로비에 추가했어요!');
                                },
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      CupertinoIcons.train_style_one,
                                      color: Theme.of(context).iconTheme.color.withOpacity(0.6),
                                    ),
                                    Expanded(
                                      child: AutoSizeText(
                                        '양방향 도착 정보',
                                        textAlign: TextAlign.center,
                                        maxFontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Dimens.marginDefault,
                      ),
                      SizedBox(
                        height: _buttonHeight,
                        child: OutlineButton(
                          onPressed: hasNext ? () async {
                            await provider.addRealStationLobby(type: LobbyItemType.realUp, data: lineData, station: widget.station, index: widget.index);
                            Fluttertoast.showToast(msg: '로비에 추가했어요!');
                          } : null,
                          child: Row(
                            children: <Widget>[
                              Icon(
                                CupertinoIcons.arrow_up,
                                color: Theme.of(context).iconTheme.color.withOpacity(0.6),
                              ),
                              Expanded(
                                child: hasNext
                                  ? Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '$nextStation ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '도착 정보',
                                      ),
                                    ]
                                  ),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                  strutStyle: StrutStyle(
                                    height: 1,
                                  ),
                                )
                                  : Text(
                                  '역 없음',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimens.marginDefault,
                      ),
                      SizedBox(
                        height: _buttonHeight,
                        child: OutlineButton(
                          onPressed: hasPrev ? () async {
                            await provider.addRealStationLobby(type: LobbyItemType.realDown, data: lineData, station: widget.station, index: widget.index);
                            Fluttertoast.showToast(msg: '로비에 추가했어요!');
                          } : null,
                          child: Row(
                            children: <Widget>[
                              Icon(
                                CupertinoIcons.arrow_down,
                                color: Theme.of(context).iconTheme.color.withOpacity(0.6),
                              ),
                              Expanded(
                                child: hasPrev
                                  ? Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '$prevStation ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '도착 정보',
                                      ),
                                    ]
                                  ),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                  strutStyle: StrutStyle(
                                    height: 1,
                                  ),
                                )
                                  : Text(
                                  '역 없음',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
