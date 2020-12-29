
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silsiganmetro/values/colors.dart';

class ThemeManager {

  static const String THEME_LIGHT = 'light';
  static const String THEME_DARK = 'dark';

  static ThemeManager _manager = ThemeManager._internal();

  static ThemeManager get manager => _manager;

  BuildContext context;

  factory ThemeManager() {
    return _manager;
  }

  ThemeManager._internal();

  String type = 'light';

  Map<String, dynamic> themes = {
    'title_bar': {
      THEME_LIGHT: MColors.colorPrimary,
      THEME_DARK: MColors.colorDarkPrimary,
    },
    'background': {
      THEME_LIGHT: MColors.backgroundLight,
      THEME_DARK: MColors.backgroundDark,
    },
    'divider': {
      THEME_LIGHT: MColors.dividerLight,
      THEME_DARK: MColors.dividerDark
    },
    'plain_text': {
      THEME_LIGHT: MColors.textLight,
      THEME_DARK: MColors.textDark,
    },
    'sub_text': {
      THEME_LIGHT: MColors.subTextLight,
      THEME_DARK: MColors.subTextDark,
    },
    'list_background' : {
      THEME_LIGHT: MColors.listBackgroundLight,
      THEME_DARK: MColors.listBackgroundDark,
    },
    'list_box_background' : {
      THEME_LIGHT: MColors.listBoxBackgroundLight,
      THEME_DARK: MColors.listBoxBackgroundDark,
    },
    'list_box_border' : {
      THEME_LIGHT: MColors.listBoxBorderLight,
      THEME_DARK: MColors.listBoxBorderDark,
    }
  };

  Future getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    type = prefs.getString('theme');
    print('type = $type');
    if(type == null) type = THEME_LIGHT;
  }

  Future setTheme(String theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme', 'light');
  }

  Color getTitleBarColor() {
    return themes['title_bar'][type];
  }

  Color getBackgroundColor() {
    return themes['background'][type];
  }

  Color getDividerColor() {
    return themes['divider'][type];
  }

  Color getTextColor() {
    return themes['plain_text'][type];
  }

  Color getSubTextColor() {
    return themes['sub_text'][type];
  }

  Color getListBackgroundColor() {
    return themes['list_background'][type];
  }

  Color getListBoxBackgroundColor() {
    return themes['list_box_background'][type];
  }

  Color getListBoxBorderColor() {
    return themes['list_box_border'][type];
  }
}