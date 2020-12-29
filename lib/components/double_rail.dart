import 'package:flutter/material.dart';
import 'package:silsiganmetro/components/train.dart';
import 'package:silsiganmetro/dto/stationdto.dart';
import 'package:silsiganmetro/dto/traindto.dart';
import 'package:silsiganmetro/foundations/global.dart';
import 'package:silsiganmetro/values/constants.dart';
import 'rail.dart';

class DoubleRail extends StatelessWidget {

  DoubleRail({
    @required this.metro,
    @required this.station,
  }) : assert(metro != null),
       assert(station != null);

  final Metro metro;
  final Station station;

  final Map<String, Alignment> upAligns = {
    APPROACHING: Alignment.bottomCenter,
    ARRIVAL: Alignment.center,
    DEPARTURE: Alignment.topCenter
  };

  final Map<String, Alignment> downAligns = {
    APPROACHING: Alignment.topLeft,
    ARRIVAL: Alignment.centerLeft,
    DEPARTURE: Alignment.bottomLeft
  };

  Widget trains(BuildContext context, List<Widget> widgets) {
    if(widgets.length > 0) {
      return Container(
        height: double.infinity,
        padding: EdgeInsets.only(bottom: 1 / MediaQuery.of(context).devicePixelRatio),
        child: Stack(
          children: widgets,
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    for(TrainDTO dto in station.list) {
      Widget widget;

      if(dto.head == UP) {
        double x = dto.express == '0' ? 43.5 : 115.5;

        widget = Align(
          alignment: upAligns[dto.status],
          child: Container(
            transform: Matrix4.translationValues(x, 0, 0),
            child: Train(
              metro: metro,
              dto: dto
            ),
          ),
        );
      } else {
        double x = dto.express == '0' ? 62.5 : -9.5;

        widget = Align(
          alignment: downAligns[dto.status],
          child: Container(
            transform: Matrix4.translationValues(x, 0, 0),
            child: Train(
              metro: metro,
              dto: dto
            ),
          ),
        );
      }

      widgets.add(widget);
    }

    return Container(
      width: 300,
      child: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 64),
                child: Rail(metro, station, DOWN),
              ),
              Container(
                margin: EdgeInsets.only(left: 64),
                child: Rail(metro, station, DOWN),
              ),
              Container(
                margin: EdgeInsets.only(left: 13),
                child: Rail(metro, station, UP),
              ),
              Container(
                margin: EdgeInsets.only(left: 64),
                child: Rail(metro, station, UP),
              ),
            ],
          ),
          trains(context, widgets),
        ],
      ),
    );
  }
}
