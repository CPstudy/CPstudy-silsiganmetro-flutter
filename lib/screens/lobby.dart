import 'package:flutter/material.dart';
import 'package:silsiganmetro/components/title_button.dart';
import 'package:silsiganmetro/components/title_scaffold.dart';
import 'package:silsiganmetro/managers/line.dart';
import 'package:silsiganmetro/managers/theme.dart';
import 'package:silsiganmetro/screens/locate.dart';
import 'package:silsiganmetro/screens/setting.dart';
import 'package:silsiganmetro/values/dimens.dart';

import '../MetroPageRoute.dart';
import '../config.dart';

class LobbyPage extends StatefulWidget {

  @override
  _LobbyPageState createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {

  List<dynamic> list = List();

  @override
  void initState() {
    super.initState();

    ArchiveConfig().init().then((value){
      setState(() {
        list = ArchiveConfig().getLobby();
      });
    });
  }

  Widget listItem(int index) {
    if(list[index]['type'] == 0) {
      return itemLine(index);
    } else {
      return itemStation(index);
    }
  }

  Widget itemLine(int index) {
    String line = list[index]['line'];
    double h = 95;

    return Container(
      height: h,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: Dimens.marginDefault, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(color: ThemeManager().getListBoxBorderColor(), width: 1 / MediaQuery.of(context).devicePixelRatio),
              color: ThemeManager().getListBoxBackgroundColor(),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: Dimens.marginDefault + 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimens.marginLarge + 4),
                    child: Text(getText(Line.lines[line]['title']), style: TextStyle(color: ThemeManager().getTextColor(), fontSize: 28),),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimens.marginLarge + 4),
                    child: Text(list[index]['text'], style: TextStyle(color: ThemeManager().getSubTextColor(), fontSize: Dimens.textDefault),),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - (Dimens.marginDefault * 4),
                  height: 3.5,
                  color: Line.lines[line]['color'],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getText(String s) {
    print('getText');
    return '$s';
  }

  Widget itemStation(int index) {
    double h = 52;

    return Container(
      height: h,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: Dimens.marginDefault, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(color: ThemeManager().getListBoxBorderColor(), width: 1 / MediaQuery.of(context).devicePixelRatio),
              color: ThemeManager().getListBoxBackgroundColor(),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: Dimens.marginDefault + 4),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: Dimens.marginDefault * 2),
                  child: Container(
                    constraints: BoxConstraints(
                      minWidth: 26
                    ),
                    height: 26,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimens.marginDefault),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.red,
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("공항", style: TextStyle(color: Colors.white, fontSize: 14),),
                        ),
                      ),
                  ),
                ),
                Container(
                  width: Dimens.marginDefault,
                ),
                Text(list[index]['station'], style: TextStyle(color: ThemeManager().getTextColor(), fontSize: Dimens.textDefault),),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return TitleScaffold(
      visibilityBack: false,
      doBack: false,
      title: '실시간지하철',
      titleRightChild: TitleButton(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => SettingPage()));
        },
        padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
        width: Dimens.titleBarHeight - 16,
        height: Dimens.titleBarHeight - 16,
        child: Icon(
          Icons.settings,
          size: 28,
          color: Colors.white,
        ),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(0),
                  scrollDirection: Axis.vertical,
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) => GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MetroPageRoute(builder: (context) => LocateScreen(list[index]['line'])));
                        //Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeftWithFade, child: LocateScreen(list[index]['line'])));
                      },
                      child: listItem(index)
                  ),
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
}
