import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:silsiganmetro/components/refreshbutton.dart';
import 'package:silsiganmetro/dto/dto.dart';
import 'package:silsiganmetro/foundations/config.dart';
import 'package:silsiganmetro/foundations/global.dart';
import 'package:silsiganmetro/pages/locate/locate_page.dart';
import 'package:silsiganmetro/pages/notice_page.dart';
import 'package:silsiganmetro/pages/setting_page.dart';
import 'package:silsiganmetro/pages/settings/lobby_edit_page.dart';
import 'package:silsiganmetro/pages/test_page.dart';
import 'package:silsiganmetro/providers/metro_provider.dart';
import 'package:silsiganmetro/providers/setting_provider.dart';
import 'package:silsiganmetro/values/colors.dart';
import 'package:silsiganmetro/values/constants.dart';
import 'package:silsiganmetro/values/dimens.dart';
import 'package:silsiganmetro/widgets/exit_dialog.dart';
import 'package:silsiganmetro/widgets/lobby_train.dart';
import 'package:silsiganmetro/widgets/metro.dart';
import 'package:silsiganmetro/widgets/metro_dialog.dart';
import 'package:silsiganmetro/widgets/small_notice.dart';
import 'package:silsiganmetro/widgets/station_panel.dart';

class LobbyPage extends StatefulWidget {
  @override
  _LobbyPageState createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  AdmobBannerSize bannerSize;

  @override
  void initState() {
    super.initState();

    Admob.requestTrackingAuthorization();
    bannerSize = AdmobBannerSize.BANNER;

    WidgetsBinding.instance.addPostFrameCallback(afterLayout);
  }

  afterLayout(_) {
    if(Config().start && Config().startPage != 0) {
      Config().start = false;
      Metro metro = Global().convertLineNumberToMetro(Config().startPage);
      Navigator.push(context, MaterialPageRoute(builder: (context) => LocatePage(metro: metro,)));
    }
  }

  Future<bool> _willPopScope(LobbyProvider provider) async {
    if(!provider.exitDialog) {
      provider.exitDialog = true;
    } else {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    print('build lobby');
    final provider = Provider.of<LobbyProvider>(context, listen: false);

    return WillPopScope(
      onWillPop: () => _willPopScope(provider),
      child: Stack(
        children: [
          Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              elevation: 0.0,
              centerTitle: true,
              title: Text(
                '실시간지하철',
              ),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SettingPage()));
                  },
                  icon: Icon(
                    CupertinoIcons.gear,
                  ),
                ),
              ],
              leading: IconButton(
                icon: Icon(
                  CupertinoIcons.bars,
                ),
                onPressed: () {
                  _scaffoldKey.currentState.openDrawer();
                },
              ),
            ),
            drawer: LobbyDrawer(),
            body: SafeArea(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: provider.getLobby(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData) {
                    if(snapshot.connectionState == ConnectionState.none || snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox.shrink();
                    } else {
                      return Center(
                        child: Text(
                          '로비를 불러오는데 오류가 발생했습니다.'
                        ),
                      );
                    }
                  } else {
                    print(snapshot.data);
                    List<Map<String, dynamic>> items = snapshot.data;

                    return Column(
                      children: [
                        Expanded(
                          child: Stack(
                            children: <Widget>[
                              ListView.separated(
                                padding: EdgeInsets.only(
                                  top: 0
                                ),
                                itemCount: items.length + 2,
                                itemBuilder: (context, index) {
                                  if(index == 0) {
                                    return SmallNotice();
                                  } else if(index == items.length + 1) {
                                    return Container(
                                      height: 150,
                                    );
                                  } else {
                                    Map<String, dynamic> data = snapshot.data[index - 1];
                                    LobbyItemType type = Global().convertLobbyNumberToType(data['type']);

                                    switch(type) {
                                      case LobbyItemType.line:
                                        LobbyData lobbyData = LobbyData(data: data);

                                        return LobbyLineItem(
                                          data: lobbyData,
                                        );

                                      case LobbyItemType.divider:
                                        String text = data['text'];
                                        List<String> texts = text.split(':');
                                        String name = texts[0];
                                        int height = int.parse(texts[1]);

                                        return LobbyDividerItem(
                                          name: name,
                                          height: height,
                                        );

                                      case LobbyItemType.real:
                                        LobbyStationData lobbyData = LobbyStationData(data: data);

                                        return LobbyRealStationItem(data: lobbyData,);

                                      case LobbyItemType.realUp:
                                        LobbyStationData lobbyData = LobbyStationData(data: data);

                                        return LobbyRealUpDownStationItem(data: lobbyData, updown: UP,);

                                      case LobbyItemType.realDown:
                                        LobbyStationData lobbyData = LobbyStationData(data: data);

                                        return LobbyRealUpDownStationItem(data: lobbyData, updown: DOWN,);

                                      default:
                                        LobbyStationData lobbyData = LobbyStationData(data: data);

                                        return LobbyStationItem(
                                          data: lobbyData,
                                        );
                                    }
                                  }
                                },
                                separatorBuilder: (context, index) {
                                  if(items.length == 0) {
                                    return SizedBox.shrink();
                                  } else {
                                    return Divider();
                                  }
                                  if(index == 0 || index > 0 && (index - 1 < items.length - 1 && items[index - 1]['type'] != items[index]['type'])) {
                                    return Container(
                                      height: 10,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                            width: Global.pixel,
                                            color: Theme.of(context).dividerColor
                                          ),
                                          bottom: BorderSide(
                                            width: Global.pixel,
                                            color: Theme.of(context).dividerColor
                                          ),
                                        )
                                      ),
                                    );
                                  } else {
                                    return Divider();
                                  }
                                },
                              ),
                              Positioned(
                                right: 24,
                                bottom: 36,
                                child: RefreshButton(
                                  onTap: () {
                                    DateTime now = DateTime.now();
                                    if(Global().datePressed != null) {
                                      Duration duration = now.difference(Global().datePressed);
                                      if(duration < Duration(seconds: 10)) {
                                        return;
                                      }
                                    }
                                    Global().datePressed = now;

                                    setState(() {
                                      Global().realStations.clear();
                                    });
                                  },
                                  loading: false,
                                ),
                              ),
                              Visibility(
                                visible: items.isEmpty,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        CupertinoIcons.exclamationmark_bubble,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        height: Dimens.marginDefault,
                                      ),
                                      Text(
                                        '로비가 비어있네요?'
                                      ),
                                      SizedBox(
                                        height: Dimens.marginDefault,
                                      ),
                                      OutlineButton(
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => LobbyEditPage()));
                                        },
                                        child: Text(
                                          '로비 편집하기'
                                        ),
                                      ),
                                      OutlineButton(
                                        onPressed: () {
                                          _scaffoldKey.currentState.openDrawer();
                                        },
                                        child: Text(
                                          '역 추가하기'
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: bannerSize.height.toDouble(),
                          child: AdmobBanner(
                            adUnitId: Global().getBannerAdUnitId(0),
                            adSize: bannerSize,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
          ExitDialog(),
        ],
      ),
    );
  }
}

class LobbyLineItem extends StatelessWidget {

  LobbyLineItem({
    @required this.data,
    this.clickable = true,
  }) : assert(data != null);

  final LobbyData data;

  final bool clickable;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => LocatePage(
              metro: data.metro,
            )));
          },
          child: Container(
            height: 65,
            padding: EdgeInsets.symmetric(
              horizontal: Dimens.marginMedium,
            ),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    data.lineData.name,
                    style: TextStyle(
                      color: data.lineData.color,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    data.lineData.subText,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.caption.color,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LobbyStationItem extends StatelessWidget {

  LobbyStationItem({
    @required this.data,
  }) : assert(data != null);

  final LobbyStationData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => LocatePage(
              metro: data.metro,
              stationCode: data.stationCode,
            )));
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: Dimens.marginMedium,
              horizontal: Dimens.marginMedium,
            ),
            child: Row(
              children: <Widget>[
                MetroChip(metro: data.metro),
                SizedBox(
                  width: Dimens.marginDefault,
                ),
                Text(
                  data.name,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LobbyDividerItem extends StatelessWidget {

  LobbyDividerItem({
    @required this.name,
    @required this.height,
  }) : assert(name != null),
       assert(height != null);

  final String name;

  final int height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: name == '' ? 8 * height.toDouble() : null,
      child: name != ''
        ? Padding(
            padding: EdgeInsets.only(
              top: 8 * height.toDouble(),
              left: 16,
              bottom: 8,
            ),
            child: Text(
              name,
              style: Theme.of(context).textTheme.caption,
            ),
          )
        : null,
    );
  }
}

class LobbyRealStationItem extends StatelessWidget {

  LobbyRealStationItem({
    @required this.data,
  }) : assert(data != null);

  final LobbyStationData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => LocatePage(
              metro: data.metro,
              stationCode: data.stationCode,
            )));
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: Dimens.marginMedium,
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: Dimens.marginMedium,
                    ),
                    MetroChip(metro: data.metro),
                    SizedBox(
                      width: Dimens.marginDefault,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          data.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimens.marginMedium,
                ),
                Container(
                  height: 45,
                  child: ChangeNotifierProvider(
                    create: (_) => LocateProvider(metro: data.metro),
                    child: Consumer<LocateProvider>(
                      builder: (context, provider, child) {
                        return FutureBuilder<Map<String, dynamic>>(
                          future: provider.getRealStation(data.metro, data.stationCode, data.name),
                          builder: (context, snapshot) {
                            switch(snapshot.connectionState) {
                              case ConnectionState.none:
                              case ConnectionState.waiting:
                                return Container(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    )
                                  ),
                                );
                              default:
                                if(!snapshot.hasData) {
                                  return Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '정보 없음',
                                      style: Theme.of(context).textTheme.caption,
                                    ),
                                  );
                                } else {
                                  final SettingProvider settingProvider = Provider.of<SettingProvider>(context);
                                  Map<String, dynamic> station = snapshot.data;

                                  List<Widget> upTrains = List();
                                  List<Widget> downTrains = List();

                                  if(station['up1'] == null && station['up2'] == null) {
                                    upTrains.add(
                                      Container(
                                        child: Text(
                                          '정보 없음',
                                          style: Theme.of(context).textTheme.caption,
                                        ),
                                      )
                                    );
                                  }

                                  if(station['up1'] != null) {
                                    RealStationData real = station['up1'];
                                    upTrains.add(
                                      LobbyTextTrain(
                                        metro: data.metro,
                                        number: real.trainNo,
                                        status: real.arrivalStatus,
                                        dst: real.dst,
                                        station: real.arrivalMessage2,
                                        message: real.arrivalMessage1,
                                        time: int.parse(real.arrivalTime),
                                      )
                                    );
                                  }

                                  if(station['up2'] != null) {
                                    RealStationData real = station['up2'];
                                    upTrains.add(
                                      SizedBox(
                                        height: Dimens.marginTiny,
                                      )
                                    );

                                    upTrains.add(
                                      LobbyTextTrain(
                                        metro: data.metro,
                                        number: real.trainNo,
                                        status: real.arrivalStatus,
                                        dst: real.dst,
                                        station: real.arrivalMessage2,
                                        message: real.arrivalMessage1,
                                        time: int.parse(real.arrivalTime),
                                      )
                                    );
                                  }

                                  if(station['down1'] == null && station['down2'] == null) {
                                    downTrains.add(
                                      Container(
                                        child: Text(
                                          '정보 없음',
                                          style: Theme.of(context).textTheme.caption,
                                        ),
                                      )
                                    );
                                  }

                                  if(station['down1'] != null) {
                                    RealStationData real = station['down1'];
                                    downTrains.add(
                                      LobbyTextTrain(
                                        metro: data.metro,
                                        number: real.trainNo,
                                        status: real.arrivalStatus,
                                        dst: real.dst,
                                        station: real.arrivalMessage2,
                                        message: real.arrivalMessage1,
                                        time: int.parse(real.arrivalTime),
                                      )
                                    );
                                  }

                                  if(station['down2'] != null) {
                                    RealStationData real = station['down2'];
                                    downTrains.add(
                                      SizedBox(
                                        height: Dimens.marginTiny,
                                      )
                                    );

                                    downTrains.add(
                                      LobbyTextTrain(
                                        metro: data.metro,
                                        number: real.trainNo,
                                        status: real.arrivalStatus,
                                        dst: real.dst,
                                        station: real.arrivalMessage2,
                                        message: real.arrivalMessage1,
                                        time: int.parse(real.arrivalTime),
                                      )
                                    );
                                  }

                                  return Container(
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              left: 12,
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: settingProvider.lobbyUpLeft ? upTrains : downTrains,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: Global.pixel,
                                          color: Theme.of(context).dividerColor,
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              left: 8,
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: settingProvider.lobbyUpLeft ? downTrains : upTrains,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LobbyRealUpDownStationItem extends StatelessWidget {

  LobbyRealUpDownStationItem({
    @required this.data,
    this.updown = UP,
  }) : assert(data != null);

  final LobbyStationData data;

  final String updown;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => LocatePage(
              metro: data.metro,
              stationCode: data.stationCode,
            )));
          },
          child: Container(
            height: 65,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        width: Dimens.marginMedium,
                      ),
                      MetroChip(metro: data.metro),
                      SizedBox(
                        width: Dimens.marginDefault,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4 - 45,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              data.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              updown == UP ? Global().getNextStation(data.metro, data.stationCode) : Global().getPrevStation(data.metro, data.stationCode),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                color: Theme.of(context).textTheme.caption.color.withOpacity(0.4),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: Dimens.marginLarge,
                ),
                ChangeNotifierProvider(
                  create: (_) => LocateProvider(metro: data.metro),
                  child: Consumer<LocateProvider>(
                     builder: (context, provider, child) {
                       return FutureBuilder<Map<String, dynamic>>(
                         future: provider.getRealStation(data.metro, data.stationCode, data.name),
                         builder: (context, snapshot) {
                           switch(snapshot.connectionState) {
                             case ConnectionState.none:
                             case ConnectionState.waiting:
                               return Container(
                                 width: MediaQuery.of(context).size.width * 0.5,
                                 alignment: Alignment.center,
                                 child: SizedBox(
                                   width: 20,
                                   height: 20,
                                   child: CircularProgressIndicator(
                                     strokeWidth: 2,
                                   )
                                 ),
                               );
                             default:
                               if(!snapshot.hasData) {
                                 return Container(
                                   child: Text(
                                     '정보 없음',
                                     style: Theme.of(context).textTheme.caption,
                                   ),
                                 );
                               } else {
                                 Map<String, dynamic> station = snapshot.data;
                                 
                                 List<Widget> trains = List();

                                 if(updown == UP) {
                                   if(station['up1'] == null && station['up2'] == null) {
                                     return Container(
                                       child: Text(
                                         '정보 없음',
                                         style: Theme.of(context).textTheme.caption,
                                       ),
                                     );
                                   }

                                   if(station['up1'] != null) {
                                     RealStationData real = station['up1'];
                                     trains.add(
                                       LobbyTextTrain(
                                         metro: data.metro,
                                         number: real.trainNo,
                                         status: real.arrivalStatus,
                                         dst: real.dst,
                                         station: real.arrivalMessage2,
                                         message: real.arrivalMessage1,
                                         time: int.parse(real.arrivalTime),
                                       )
                                     );
                                   }

                                   if(station['up2'] != null) {
                                     RealStationData real = station['up2'];
                                     trains.add(
                                       SizedBox(
                                         height: Dimens.marginTiny,
                                       )
                                     );

                                     trains.add(
                                       LobbyTextTrain(
                                         metro: data.metro,
                                         number: real.trainNo,
                                         status: real.arrivalStatus,
                                         dst: real.dst,
                                         station: real.arrivalMessage2,
                                         message: real.arrivalMessage1,
                                         time: int.parse(real.arrivalTime),
                                       )
                                     );
                                   }
                                 } else {
                                   if(station['down1'] == null && station['down2'] == null) {
                                     return Container(
                                       child: Text(
                                         '정보 없음',
                                         style: Theme.of(context).textTheme.caption,
                                       ),
                                     );
                                   }

                                   if(station['down1'] != null) {
                                     RealStationData real = station['down1'];
                                     trains.add(
                                       LobbyTextTrain(
                                         metro: data.metro,
                                         number: real.trainNo,
                                         status: real.arrivalStatus,
                                         dst: real.dst,
                                         station: real.arrivalMessage2,
                                         message: real.arrivalMessage1,
                                         time: int.parse(real.arrivalTime),
                                       )
                                     );
                                   }

                                   if(station['down2'] != null) {
                                     RealStationData real = station['down2'];
                                     trains.add(
                                       SizedBox(
                                         height: Dimens.marginTiny,
                                       )
                                     );

                                     trains.add(
                                       LobbyTextTrain(
                                         metro: data.metro,
                                         number: real.trainNo,
                                         status: real.arrivalStatus,
                                         dst: real.dst,
                                         station: real.arrivalMessage2,
                                         message: real.arrivalMessage1,
                                         time: int.parse(real.arrivalTime),
                                       )
                                     );
                                   }
                                 }
                                 
                                 return Container(
                                   width: MediaQuery.of(context).size.width * 0.55,
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     mainAxisSize: MainAxisSize.min,
                                     children: trains,
                                   ),
                                 );
                               }
                           }
                         },
                       );
                     },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LobbyDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    List<LineData> list = List();
    metros.forEach((key, value) => list.add(value));

    return Drawer(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).padding.top,
            color: Theme.of(context).primaryColor,
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom,
              ),
              itemCount: list.length,
              itemBuilder: (context, index) {
                LineData data = list[index];

                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LocatePage(metro: data.metro)));
                  },
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimens.marginDefault,
                    ),
                    child: Row(
                      children: [
                        MetroChip(
                          metro: data.metro,
                        ),
                        SizedBox(
                          width: Dimens.marginLarge,
                        ),
                        Text(
                          data.name,
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, builder) => Divider(),
            ),
          ),
        ],
      ),
    );
  }
}
