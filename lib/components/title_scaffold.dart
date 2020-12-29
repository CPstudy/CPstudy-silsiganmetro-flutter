import 'package:flutter/material.dart';
import 'package:silsiganmetro/components/title_button.dart';
import 'package:silsiganmetro/managers/theme.dart';
import 'package:silsiganmetro/values/dimens.dart';
import 'package:swipedetector/swipedetector.dart';

class TitleScaffold extends StatefulWidget {

  Widget body;
  Widget titleLeftChild;
  Widget titleRightChild;
  String title;
  bool visibilityBack;
  bool visibilityTitle = true;
  bool doBack = true;
  Color color;

  TitleScaffold({
    this.body,
    this.title: '',
    this.visibilityBack: true,
    this.titleLeftChild,
    this.titleRightChild,
    this.doBack: true,
    this.color,
  }) {
    if(title == null || title == '') {
      visibilityTitle = false;
    }
  }

  @override
  _TitleScaffoldState createState() => _TitleScaffoldState();
}

class _TitleScaffoldState extends State<TitleScaffold> {

  Widget titleBar() {

    List<Widget> leftWidgets = List();
    List<Widget> rightWidgets = List();

    leftWidgets.add(
      Visibility(
        visible: widget.visibilityBack,
        child: TitleButton(
          padding: EdgeInsets.only(left: 8, right: 2, top: 8, bottom: 8),
          width: Dimens.titleBarHeight - 16,
          height: Dimens.titleBarHeight - 16,
          child: Icon(
            Icons.arrow_back,
            size: 28,
            color: Colors.white,
          ),
        ),
      )
    );

    if(widget.titleLeftChild != null) {
      leftWidgets.add(widget.titleLeftChild);
    }

    if(widget.titleRightChild != null) {
      rightWidgets.add(widget.titleRightChild);
    }

    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).padding.top,
          color: (widget.color == null) ? ThemeManager().getTitleBarColor() : widget.color,
        ),
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: Dimens.titleBarHeight,
              color: (widget.color == null) ? ThemeManager().getTitleBarColor() : widget.color,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: leftWidgets,
            ),
            Visibility(
              visible: widget.visibilityTitle,
              child: Align(
                alignment: Alignment.center,
                child: Stack(
                  children: <Widget>[
                    // Stroked text as border.
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 18,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 2
                          ..color = Colors.black38,
                      ),
                    ),
                    // Solid text as fill.
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: rightWidgets,
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeManager().getBackgroundColor(),
      body: SwipeDetector(
        onSwipeRight: (){
          if(widget.doBack) {
            Navigator.pop(context);
          }
        },
        swipeConfiguration: SwipeConfiguration(
            horizontalSwipeMaxHeightThreshold: 50.0,
            horizontalSwipeMinDisplacement:20.0,
        ),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                titleBar(),
                Expanded(
                  child: Container(
                    child: widget.body,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
