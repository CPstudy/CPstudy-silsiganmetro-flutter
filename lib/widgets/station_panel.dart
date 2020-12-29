import 'package:flutter/material.dart';
import 'package:silsiganmetro/dto/dto.dart';
import 'package:silsiganmetro/dto/stationdto.dart';
import 'package:silsiganmetro/foundations/global.dart';

class StationPanel extends StatelessWidget {

  StationPanel({
    @required this.metro,
    @required this.name,
  });

  final Metro metro;

  final String name;

  @override
  Widget build(BuildContext context) {
    LineData lineData = metros[metro];

    return Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: lineData.color,
          width: 3,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 22,
            constraints: BoxConstraints(
              minWidth: 22,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 4,
            ),
            decoration: BoxDecoration(
              color: lineData.color,
              borderRadius: BorderRadius.circular(22),
            ),
            alignment: Alignment.center,
            child: Text(
              lineData.name.replaceAll(RegExp(r'호선|선'), ''),
              style: TextStyle(
                height: 1,
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 4,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8
            ),
            child: Text(
              '$name ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
