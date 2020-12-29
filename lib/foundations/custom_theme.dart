import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:silsiganmetro/foundations/global.dart';
import 'package:silsiganmetro/values/colors.dart';

import 'config.dart';

List<ThemeIndexData> themes = [
  ThemeIndexData(index: 0, type: ThemeType.light, data: lightTheme),
  ThemeIndexData(index: 1, type: ThemeType.dark, data: darkTheme),
  ThemeIndexData(index: 2, type: ThemeType.navy, data: navyTheme),
  ThemeIndexData(index: 3, type: ThemeType.purple, data: purpleTheme),
];

ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: MColors.lime,
  appBarTheme: AppBarTheme().copyWith(
    elevation: 0.0,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData().copyWith(
    foregroundColor: Colors.white,
  ),
  dialogBackgroundColor: Color(0xFFF2F2F2),
  dividerTheme: DividerThemeData().copyWith(
    thickness: Global.pixel,
    space: 0.0,
  ),
  scaffoldBackgroundColor: Color(0xfff2f1f7),
  cardColor: Color(0xffffffff),
  backgroundColor: Colors.white,
);

ThemeData navyTheme = lightTheme.copyWith(
  primaryColor: MColors.navy,
);

ThemeData purpleTheme = lightTheme.copyWith(
  primaryColor: Colors.deepPurple,
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  appBarTheme: AppBarTheme().copyWith(
    elevation: 0.0,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData().copyWith(
    backgroundColor: Color(0xff2d2d2d),
    foregroundColor: Colors.white,
  ),
  dialogBackgroundColor: Color(0xFF1E1E1E),
  dividerTheme: DividerThemeData().copyWith(
    thickness: Global.pixel,
    space: 0.0,
  ),
  scaffoldBackgroundColor: Color(0xff000000),
  cardColor: Color(0xff1c1c1e),
  backgroundColor: Color(0xff282828),
);

class ThemeIndexData {

  ThemeIndexData({
    @required this.index,
    @required this.data,
    @required this.type,
  }) : assert(index != null),
       assert(data != null),
       assert(type != null);

  final int index;

  final ThemeData data;

  final ThemeType type;
}