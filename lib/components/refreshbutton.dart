import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:silsiganmetro/foundations/global.dart';
import 'package:silsiganmetro/providers/metro_provider.dart';

class RefreshButton extends StatefulWidget {

  RefreshButton({
    this.onTap,
    this.icon,
    this.loading = false,
  });

  final Function onTap;

  final Widget icon;

  final bool loading;

  @override
  _RefreshButtonState createState() => _RefreshButtonState();
}

class _RefreshButtonState extends State<RefreshButton> {

  @override
  Widget build(BuildContext context) {

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Theme.of(context).dividerColor, width: Global.pixel),
            color: Theme.of(context).primaryColor,
          ),
        ),
        ClipOval(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Theme.of(context).dividerColor,
              highlightColor: Colors.transparent,
              onTap: widget.onTap,
              child: Container(
                width: 50,
                height: 50,
                color: Colors.transparent,
              ),
            ),
          ),
        ),
        IgnorePointer(
          child: widget.loading ? RotationIcon() : Icon(
            Icons.cached_sharp,
            size: 24,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class RotationIcon extends StatefulWidget {

  RotationIcon({
    this.onTap,
    this.loading = false,
  });

  final Function onTap;

  final bool loading;

  @override
  _RotationIconState createState() => _RotationIconState();
}

class _RotationIconState extends State<RotationIcon> with TickerProviderStateMixin {

  AnimationController rotateController;

  @override
  void initState() {
    super.initState();

    rotateController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    rotateController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        rotateController.repeat();
      }
    });

    rotateController.forward(from: 0.0);
  }

  @override
  void dispose() {
    rotateController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween<double>(begin: 1.0, end: 0.0).animate(rotateController),
      child: Icon(
        Icons.cached_sharp,
        size: 24,
        color: Colors.white,
      ),
    );
  }
}
