import 'package:flutter/material.dart';
import 'package:silsiganmetro/dto/stationdto.dart';
import 'package:silsiganmetro/foundations/global.dart';
import 'package:silsiganmetro/values/constants.dart';

class LineData {

  LineData({
    @required this.number,
    @required this.name,
    @required this.stations,
    this.subText,
    this.color,
    this.railBlueLine,
  }) : assert(number != null),
       assert(name != null),
       assert(stations != null);

  final int number;

  final String name;

  final String subText;

  final Color color;

  final List<Station> stations;

  final String railBlueLine;

  Metro get metro => Global().convertLineNumberToMetro(number);
}

class LobbyData {
  LobbyData({
    @required this.data,
  }) : assert(data != null);

  final Map<String, dynamic> data;

  int get id => data['_id'];

  LobbyItemType get type => Global().convertLobbyNumberToType(data['type']);

  Metro get metro => Global().convertLineNumberToMetro(data['line']);

  LineData get lineData => Global().getLineData(metro);

  String get text => data['text'];

  String get stationCode => data['stationcode'];

  int get sort => data['sort'];

}

class LobbyStationData extends LobbyData {

  LobbyStationData({
    @required this.data,
  }) : assert(data != null),
       super(data: data);

  final Map<String, dynamic> data;

  String get name => data['text'];

  int get listIndex => data['list_index'];

}

class TrainIconData {

  TrainIconData({
    @required this.iconName,
  }) : assert(iconName != null);

  final String iconName;

  String getIcon(String updown, Brightness brightness, bool invert) {
    String outline;
    String head;

    if(brightness == Brightness.light) {
      if(!invert) {
        outline = 'light';
      } else {
        outline = 'dark';
      }
    } else {
      if(!invert) {
        outline = 'dark';
      } else {
        outline = 'light';
      }
    }

    if(updown == UP) {
      head = 'up';
    } else {
      head = 'down';
    }

    return 'assets/images/${iconName}_${head}_$outline.png';

  }
}

class RealStationData {
  RealStationData({
    this.updown,
    this.order,
    this.arrivalMessage1,
    this.arrivalMessage2,
    this.arrivalStatus,
    this.arrivalTime,
    this.trainNo,
    this.trainType,
    this.dst,
  });

  String updown;
  String order;
  String arrivalMessage1;
  String arrivalMessage2;
  String arrivalStatus;
  String arrivalTime;
  String trainNo;
  String trainType;
  String dst;

  @override
  String toString() {
    return '[[[updown: $updown, arrivalMessage1: $arrivalMessage1, dst: $dst]]]';
  }
}