
import 'package:flutter/material.dart';

class LineMapPage extends StatefulWidget {
  @override
  _LineMapPageState createState() => _LineMapPageState();
}

class _LineMapPageState extends State<LineMapPage> {

  double x;
  double y;
  double _zoom;

  void displayOffset(Offset position) {
    x = position.dx;
    y = position.dy;

    print(x);
  }

  void displayScaleUpdate(double scale, double zoom) {
    setState(() {
      _zoom = zoom;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Container(),
        )
      ),
    );
  }
}
