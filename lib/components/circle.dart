import 'package:flutter/material.dart';
import 'package:silsiganmetro/dto/dto.dart';
import 'package:silsiganmetro/foundations/global.dart';
import 'package:silsiganmetro/values/constants.dart';

class Circle extends StatelessWidget {

  Circle(
    this.metro,
    this.type,
  );

  final Metro metro;
  final int type;

  @override
  Widget build(BuildContext context) {
    LineData lineData = metros[metro];

    double circleSize = 8.0;

    Widget circleNorm = Container(
      width: circleSize,
      height: circleSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: lineData.color,
      ),
    );

    Widget circleTran = Container(
      width: circleSize,
      height: circleSize,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: lineData.color)
      ),
    );

    if(type == NORM) {
      return circleNorm;
    } else {
      return circleTran;
    }
  }
}
