import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:silsiganmetro/dto/dto.dart';
import 'package:silsiganmetro/foundations/global.dart';

class MetroScaffold extends StatefulWidget {

  MetroScaffold({
    this.title,
    this.body,
    this.actions,
    this.extendBodyBehindAppBar = false,
    this.backgroundColor,
    this.titleBarColor,
    this.floatingActionButton,
  });

  final Widget title;

  final Widget body;

  final List<Widget> actions;
  
  final bool extendBodyBehindAppBar;

  final Color backgroundColor;

  final Color titleBarColor;

  final Widget floatingActionButton;

  @override
  _MetroScaffoldState createState() => _MetroScaffoldState();
}

class _MetroScaffoldState extends State<MetroScaffold> {

  bool isDark = false;

  @override
  void initState() {
    super.initState();

    final window = WidgetsBinding.instance.window;
    window.onPlatformBrightnessChanged = () {
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: MediaQuery.of(context).platformBrightness == Brightness.light ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: widget.backgroundColor,
        body: Stack(
          children: <Widget>[
            Padding(
              padding: !widget.extendBodyBehindAppBar ? EdgeInsets.only(
                top: MetroTitle().height
              ) : EdgeInsets.all(0),
              child: widget.body ?? Container(),
            ),
            MetroTitle(
              title: widget.title,
              actions: widget.actions,
              titleBarColor: widget.titleBarColor,
            ),
          ],
        ),
        floatingActionButton: widget.floatingActionButton,
      ),
    );
  }
}

class MetroTitle extends StatelessWidget {

  MetroTitle({
    this.title,
    this.actions,
    this.titleBarColor,
  });

  final Widget title;

  final List<Widget> actions;

  final double height = 50.0 + (ui.window.padding.top / ui.window.devicePixelRatio);

  final double _blurAmount = 20.0;

  final Color titleBarColor;

  @override
  Widget build(BuildContext context) {
    final EdgeInsets _topPadding = EdgeInsets.only(top: ui.window.padding.top / ui.window.devicePixelRatio,);

    Widget actions;
    if(this.actions != null && this.actions.isNotEmpty) {
      actions = Material(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: this.actions,
        ),
      );
    }

    if (actions != null) {
      actions = IconTheme.merge(
        data: Theme.of(context).iconTheme,
        child: actions,
      );
    }

    return Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Container(
            color: titleBarColor ?? Theme.of(context).dialogBackgroundColor,
          ),
          Container(
            height: height,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: _topPadding,
                    child: DefaultTextStyle(
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1.color,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      child: title ?? Container(),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: _topPadding,
                    child: actions,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: Global.pixel,
                    color: Theme.of(context).dividerColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MetroChip extends StatelessWidget {

  MetroChip({
    this.metro,
    this.lineData,
  });

  final Metro metro;

  final LineData lineData;

  @override
  Widget build(BuildContext context) {
    double _size = 25;
    final LineData data = lineData ?? Global().getLineData(metro);
    final Color color = data.color;
    String name = data.name.replaceAll(RegExp(r'호선|선|·'), '');

    if(name.length > 3) {
      name = name.substring(0, 2) + '\n' + name.substring(2, 4);
    }

    return Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: data.color,
        border: Border.all(
          width: 1,
          color: Theme.of(context).dividerColor,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        name,
        style: TextStyle(
          height: 1,
          color: Colors.white,
          fontSize: RegExp(r'[\d]+').hasMatch(name) ? 16 : 8,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class MetroDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Global.pixel,
      color: Theme.of(context).dividerColor.withOpacity(0.07),
    );
  }
}
