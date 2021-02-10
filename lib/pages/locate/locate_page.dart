import 'dart:async';
import 'dart:ui';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:silsiganmetro/components/item_double.dart';
import 'package:silsiganmetro/components/item_single.dart';
import 'package:silsiganmetro/components/refreshbutton.dart';
import 'package:silsiganmetro/dto/dto.dart';
import 'package:silsiganmetro/dto/stationdto.dart';
import 'package:silsiganmetro/foundations/config.dart';
import 'package:silsiganmetro/foundations/global.dart';
import 'package:silsiganmetro/managers/line.dart';
import 'package:silsiganmetro/pages/lobby_page.dart';
import 'package:silsiganmetro/pages/locate/locate_tablet_page.dart';
import 'package:silsiganmetro/pages/locate/station_sheet.dart';
import 'package:silsiganmetro/providers/metro_provider.dart';
import 'package:silsiganmetro/providers/setting_provider.dart';
import 'package:silsiganmetro/values/dimens.dart';
import 'package:silsiganmetro/widgets/metro.dart';
import 'package:sprintf/sprintf.dart';
import 'package:url_launcher/url_launcher.dart';

class LocatePage extends StatefulWidget {

  LocatePage({
    @required this.metro,
    this.stationCode,
  }) : assert(metro != null);

  final Metro metro;

  final String stationCode;

  @override
  _LocatePageState createState() => _LocatePageState();
}

class _LocatePageState extends State<LocatePage> with TickerProviderStateMixin {

  AnimationController rotateController;
  AdmobBannerSize bannerSize;
  Timer timer;
  int time = 0;

  @override
  void initState() {
    Admob.requestTrackingAuthorization();
    bannerSize = AdmobBannerSize.BANNER;

    rotateController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,

    );
    rotateController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        rotateController.repeat();
      }
    });

    autoRefresh();

    super.initState();
  }

  @override
  void dispose() {
    rotateController.dispose();
    if(timer != null) {
      timer.cancel();
    }

    super.dispose();
  }

  void autoRefresh() {
    if(Config().autoRefresh == 0) return;

    int interval = Config().autoRefresh;

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      print('timer = $time');
      if(mounted) {
        time++;
        if(time == interval) {
          time = 0;
          setState(() {

          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    int initialIndex = -1;

    return ChangeNotifierProvider<LocateProvider>(
      create: (_) => LocateProvider(metro: widget.metro),
      child: Consumer<LocateProvider>(
        builder: (context, provider, child) {
          LineData lineData = Global().getLineData(widget.metro);

          double _initialAxisY = 0.0;
          double _dividerHeight = 25.0;
          double _listHeight = 60.0;

          List<String> numbers;

          if(widget.stationCode != null) {
            numbers = widget.stationCode.split(':');
          } else if(Config().getPinStation(lineData.metro) != '0:0') {
            numbers = Config().getPinStation(lineData.metro).split(':');
          }

          if(numbers != null && numbers.length == 2) {
            String stationNo = numbers[0];
            String stationSubNo = numbers.length == 2 ? numbers[1] : '0';

            for(int i = 0; i < provider.stations.length; i++) {
              if(provider.stations[i].no == stationNo && provider.stations[i].subNo == stationSubNo) {
                initialIndex = i;
                break;
              }

              if(provider.stations[i].no == '1000000000') {
                _initialAxisY += _dividerHeight;
              } else {
                _initialAxisY += _listHeight;
              }
            }
          }

          _initialAxisY -= (MediaQuery.of(context).size.height / 2) - AppBar().preferredSize.height - MediaQuery.of(context).padding.top;
          if(_initialAxisY < 0) _initialAxisY = 0;

          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Theme.of(context).brightness == Brightness.light ? lineData.color : null,
              title: Text(
                lineData.name,
              ),
              // actions: [
              //   IconButton(
              //     onPressed: () {
              //       Navigator.push(context, MaterialPageRoute(builder: (context) => LocateTabletPage()));
              //     },
              //     icon: Icon(
              //       Icons.linear_scale
              //     ),
              //   ),
              // ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: FutureBuilder<List<Station>>(
                    future: provider.getTrains(),
                    builder: (context, snapshot) {
                      Widget loadingWidget = StationList(
                        provider: provider,
                        stations: provider.stations,
                        lineData: lineData,
                        initialAxisY: _initialAxisY,
                        initialIndex: initialIndex,
                        loading: true,
                      );

                      switch(snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return loadingWidget;

                        default:
                          if(!snapshot.hasData) {
                            return loadingWidget;
                          } else {
                            List<Station> stations = snapshot.data;
                            return StationList(
                              provider: provider,
                              stations: stations,
                              lineData: lineData,
                              initialAxisY: _initialAxisY,
                              initialIndex: initialIndex,
                              onTapRefresh: () {
                                time = 0;
                              },
                            );
                          }
                      }
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: bannerSize.height.toDouble(),
                  margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom,
                  ),
                  child: AdmobBanner(
                    adUnitId: Global().getBannerAdUnitId(1),
                    adSize: bannerSize,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class StationList extends StatefulWidget {

  StationList({
    @required this.stations,
    @required this.lineData,
    @required this.provider,
    this.loading = false,
    this.initialAxisY = 0.0,
    this.initialIndex,
    this.onTapRefresh,
  }) : assert(stations != null),
       assert(lineData != null),
       assert(provider != null);

  final List<Station> stations;

  final LineData lineData;

  final LocateProvider provider;

  final bool loading;

  final double initialAxisY;

  final int initialIndex;

  final VoidCallback onTapRefresh;

  @override
  _StationListState createState() => _StationListState();
}

class _StationListState extends State<StationList> {

  ScrollController controller;
  AdmobBannerSize bannerSize;

  @override
  void initState() {
    super.initState();

    Admob.requestTrackingAuthorization();
    bannerSize = AdmobBannerSize.MEDIUM_RECTANGLE;

    controller = ScrollController(
      initialScrollOffset: widget.initialAxisY,
    );
  }

  void openStation({@required Station station, @required SettingProvider provider, @required int index}) {

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      enableDrag: false,
      builder: (context) => StationSheet(index: index, station: station, lineData: widget.lineData),
    );
  }

  @override
  Widget build(BuildContext context) {
    final SettingProvider settingProvider = Provider.of<SettingProvider>(context);

    return Stack(
      children: <Widget>[
        ListView.builder(
          controller: controller,
          padding: EdgeInsets.all(0),
          itemCount: widget.stations.length + 1,
          itemBuilder: (context, index) {
            if(index == widget.stations.length) {
              // footer
              return Container(
                height: 180,
              );
            } else {
              Metro metro = widget.lineData.metro;

              if(metro == Metro.line1 || metro == Metro.line9 || metro == Metro.airport) {
                return ItemDouble(
                  context: context,
                  metro: metro,
                  station: widget.stations[index],
                  right: settingProvider.right,
                  isSelected: widget.initialIndex != null && widget.initialIndex == index,
                  onTap: () => openStation(station: widget.stations[index], provider: settingProvider, index: index),
                );
              } else {
                return ItemSingle(
                  context: context,
                  metro: metro,
                  station: widget.stations[index],
                  right: settingProvider.right,
                  isSelected: widget.initialIndex != null && widget.initialIndex == index,
                  onTap: () => openStation(station: widget.stations[index], provider: settingProvider, index: index),
                );
              }
            }
          },
        ),
        Positioned(
          right: 24,
          bottom: 36 + MediaQuery.of(context).padding.bottom,
          child: widget.loading
            ? RefreshButton(
                onTap: null,
                loading: true,
              )
            : RefreshButton(
                onTap: () {
                  if(!widget.loading) {
                    widget.onTapRefresh();
                    widget.provider.refresh();
                  }
                },
                loading: false,
              ),
        ),
      ],
    );
  }
}
