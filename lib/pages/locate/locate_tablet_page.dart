import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LocateTabletPage extends StatefulWidget {
  @override
  _LocateTabletPageState createState() => _LocateTabletPageState();
}

class _LocateTabletPageState extends State<LocateTabletPage> {

  double size = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: InteractiveViewer(
          onInteractionUpdate: (detail) {
            setState(() {
              size = 20.0 * detail.scale;
            });
          },
          minScale: 1.0,
          maxScale: 3.0,
          child: Container(
            width: 1024,
            height: 768,
            child: Stack(
              children: [
                SvgPicture.asset(
                  'assets/maps/map_2.svg',
                ),
                Positioned(
                  left: 300,
                  top: 500,
                  child: Container(
                    width: size,
                    height: size,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
