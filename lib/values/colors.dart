import 'dart:ui' show Color;
import 'package:flutter/material.dart';
import 'package:silsiganmetro/managers/line.dart';

class MColors {

  static const MaterialColor lime = MaterialColor(
    _lime,
    <int, Color>{
      50: Color(0xFFF2F7E6),
      100: Color(0xFFDEECC0),
      200: Color(0xFFC8DF97),
      300: Color(0xFFB2D26D),
      400: Color(0xffA2C84D),
      500: Color(_lime),
      600: Color(0xFF89B829),
      700: Color(0xFF7EAF23),
      800: Color(0xFF74A71D),
      900: Color(0xFF629912),
    },
  );
  static const int _lime = 0xFF91be2e;

  static const MaterialColor navy = MaterialColor(
    _navy,
    <int, Color>{
      50: Color(0xFFE7EBF3),
      100: Color(0xFFC2CEE1),
      200: Color(0xFF9AADCD),
      300: Color(0xFF718CB8),
      400: Color(0xFF5274A9),
      500: Color(_navy),
      600: Color(0xFF2F5392),
      700: Color(0xFF274988),
      800: Color(0xFF21407E),
      900: Color(0xFF152F6C),
    },
  );
  static const int _navy = 0xFF345b9a;

  static const Color colorUp = Color(0xff2ab119);
  static const Color colorDown = Color(0xffd35a24);

  // Line Color
  static const Color LINE_1 = Color(0xff0d3692);
  static const Color LINE_2 = Color(0xff33a23d);
  static const Color LINE_3 = Color(0xffff7300);
  static const Color LINE_4 = Color(0xff2c9ede);
  static const Color LINE_5 = Color(0xff603295);
  static const Color LINE_6 = Color(0xffcc5d0c);
  static const Color LINE_7 = Color(0xff4d5613);
  static const Color LINE_8 = Color(0xfff63763);
  static const Color LINE_9 = Color(0xffcea43a);
  static const Color GYEONGUIJUNGANG = Color(0xff26b28f);
  static const Color AIRPORT = Color(0xff008cd6);
  static const Color GYEONGCHOON = Color(0xff0a8e72);
  static const Color BUNDANGSUIN = Color(0xfffcb726);
  static const Color SHINBUNDANG = Color(0xffdb0029);
  static const Color UISINSEOL = Color(0xFFB0CE18);

  static const Color colorPrimary = Color(0xff91be2e);
  static const Color colorPrimaryDark = Color(0xff7fa727);

  // Light Theme
  static const Color backgroundLight = Color(0xffe6e8eb);
  static const Color listBackgroundLight = Color(0xfff9f9f9);
  static const Color listBoxBackgroundLight = Color(0xfff9f9f9);
  static const Color listBoxBorderLight = Color(0xffababab);
  static const Color dividerLight = Color(0x19000000);
  static const Color textLight = Color(0xff282828);
  static const Color subTextLight = Color(0xff5b5b5b);

  // Dark Theme
  static const Color colorDarkPrimary = Color(0xff2b2b2b);
  static const Color backgroundDark = Color(0xff222222);
  static const Color listBackgroundDark = Color(0xff1b1b1b);
  static const Color listBoxBackgroundDark = Color(0xff1b1b1b);
  static const Color listBoxBorderDark = Color(0x901b1b1b);
  static const Color dividerDark = Color(0x19ffffff);
  static const Color textDark = Color(0xffeeeeee);
  static const Color subTextDark = Color(0xff8a8a8a);

}