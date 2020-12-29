import 'dart:ui';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:silsiganmetro/foundations/global.dart';
import 'package:silsiganmetro/providers/metro_provider.dart';

class ExitDialog extends StatefulWidget {
  @override
  _ExitDialogState createState() => _ExitDialogState();
}

class _ExitDialogState extends State<ExitDialog> {

  AdmobBannerSize bannerSize;

  @override
  void initState() {
    super.initState();

    Admob.requestTrackingAuthorization();
    bannerSize = AdmobBannerSize.MEDIUM_RECTANGLE;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LobbyProvider>(context);

    return IgnorePointer(
      ignoring: !provider.exitDialog,
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 200),
        opacity: provider.exitDialog ? 1.0 : 0.0,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 20.0,
                  sigmaY: 20.0,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
              child: Material(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Container(
                  width: bannerSize.width.toDouble(),
                  height: bannerSize.height.toDouble() + 50,
                  child: Column(
                    children: [
                      AdmobBanner(
                        adUnitId: Global().getBannerAdUnitId(2),
                        adSize: bannerSize,
                      ),
                      Expanded(
                        child: Container(
                          color: Theme.of(context).dialogBackgroundColor,
                          alignment: Alignment.center,
                          child: Text(
                            '한 번 더 눌러서 종료하기',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
