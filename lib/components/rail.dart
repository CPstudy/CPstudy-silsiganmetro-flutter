import 'package:flutter/material.dart';
import 'package:silsiganmetro/components/circle.dart';
import 'package:silsiganmetro/components/train.dart';
import 'package:silsiganmetro/dto/dto.dart';
import 'package:silsiganmetro/dto/stationdto.dart';
import 'package:silsiganmetro/dto/traindto.dart';
import 'package:silsiganmetro/foundations/global.dart';

class Rail extends StatelessWidget {

  Rail(
    this.metro,
    this.station,
    this.head,
  );

  final Metro metro;
  final Station station;
  final String head;

  @override
  Widget build(BuildContext context) {
    LineData lineData = metros[metro];

    Widget rail = Container(
      width: 2,
      height: double.infinity,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Visibility(
                visible: station.up,
                child: Container(
                  color: lineData.color,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Visibility(
                visible: station.down,
                child: Container(
                  color: lineData.color,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          rail,
          Circle(metro, station.type),
        ],
      ),
    );
  }
}
