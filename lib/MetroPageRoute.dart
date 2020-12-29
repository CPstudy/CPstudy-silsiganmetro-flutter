import 'package:flutter/material.dart';
import 'dart:io';

class MetroPageRoute<T> extends MaterialPageRoute<T> {
  MetroPageRoute({
    WidgetBuilder builder,
    RouteSettings settings
  }) : super(builder: builder, settings: settings);

  @override
  Duration get transitionDuration {
    if(Platform.isIOS) {
      return Duration(milliseconds: 500);
    } else {
      return Duration(milliseconds: 300);
    }
  }

}