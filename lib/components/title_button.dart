import 'package:flutter/material.dart';
import 'package:silsiganmetro/values/dimens.dart';

class TitleButton extends StatefulWidget {

  Widget child;
  double width;
  double height;
  EdgeInsets padding;
  GestureTapCallback onTap;

  TitleButton({
    this.child,
    this.width: Dimens.titleBarHeight,
    this.height: Dimens.titleBarHeight,
    this.padding,
    this.onTap,
  });

  @override
  _TitleButtonState createState() => _TitleButtonState();
}

class _TitleButtonState extends State<TitleButton> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          highlightColor: Colors.black12,
          splashColor: Colors.black12,
          borderRadius: BorderRadius.circular(4),
          onTap: (widget.onTap != null) ? widget.onTap : (){
            Navigator.pop(context);
          },
          child: Container(
            width: widget.width,
            height: widget.height,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
