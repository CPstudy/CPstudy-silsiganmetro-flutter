import 'package:flutter/material.dart';
import 'package:silsiganmetro/values/dimens.dart';

class ExpressIcon extends StatelessWidget {

  int express;

  bool isRed;
  bool isGreen;

  ExpressIcon(this.express) {
    switch(express) {
      case 0:
        isRed = false;
        isGreen = false;
        break;

      case 1:
        isRed = true;
        isGreen = false;
        break;

      case 2:
        isRed = true;
        isGreen = true;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Visibility(
          visible: isRed,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: Color(0xffB70000),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Text(
                '급',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: Dimens.marginTiny,
        ),
        Visibility(
          visible: isGreen,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: Color(0xff53C14B),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Text(
                '급',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
