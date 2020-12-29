import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:provider/provider.dart';
import 'package:silsiganmetro/dto/dto.dart';
import 'package:silsiganmetro/foundations/global.dart';
import 'package:silsiganmetro/managers/databasehelper.dart';
import 'package:silsiganmetro/providers/setting_provider.dart';
import 'package:silsiganmetro/values/dimens.dart';
import 'package:silsiganmetro/widgets/metro.dart';
import 'package:silsiganmetro/widgets/metro_dialog.dart';

import '../lobby_page.dart';

class LobbyEditPage extends StatelessWidget {
  
  void editDivider(BuildContext context, SettingProvider provider, Map<String, dynamic> data) {
    TextEditingController controller = TextEditingController();
    String text = data['text'];
    List<String> texts = text.split(':');
    if(provider.dividerName == null) provider.dividerName = texts[0];
    if(provider.dividerHeight == null) provider.dividerHeight = int.parse(texts[1]);
    controller.text = provider.dividerName;

    showDialog(
      context: context,
      builder: (context) => MetroDialog(
        title: '구분 편집',
        negative: () {
          Future.delayed(Duration(milliseconds: 200)).then((value) {
            provider.dividerHeight = null;
            provider.dividerName = null;
          });
          Navigator.pop(context);
        },
        positive: () async {
          await DatabaseHelper().updateDividerInfo(
            id: data['_id'],
            name: controller.text,
            height: provider.dividerHeight,
          );
          Future.delayed(Duration(milliseconds: 200)).then((value) {
            provider.dividerHeight = null;
            provider.dividerName = null;
            provider.reload();
          });
          Navigator.pop(context);
        },
        content: Container(
          height: 130,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(Dimens.marginLarge),
                child: Row(
                  children: <Widget>[
                    Text(
                      '구분 이름'
                    ),
                    SizedBox(
                      width: Dimens.marginDefault,
                    ),
                    Expanded(
                      child: CupertinoTextField(
                        controller: controller,
                        maxLines: 1,
                        maxLength: 50,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: Dimens.marginLarge,
                  right: Dimens.marginDefault,
                ),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 46,
                      child: Text(
                        '높이(${provider.dividerHeight})'
                      ),
                    ),
                    SizedBox(
                      width: Dimens.marginDefault,
                    ),
                    Expanded(
                      child: CupertinoSlider(
                        value: provider.dividerHeight.toDouble(),
                        onChanged: (value) {
                          provider.dividerHeight = value.toInt();
                        },
                        min: 1,
                        max: 8,
                        divisions: 8,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _items(BuildContext context, SettingProvider provider) {
    double _size = 35.0;
    List<Widget> widgets = List();

    metros.forEach((metro, value) {
      LineData data = value;
      String name = data.name.replaceAll(RegExp(r'호선|선|·'), '');

      if(name.length > 3) {
        name = name.substring(0, 2) + '\n' + name.substring(2, 4);
      }

      widgets.add(InkWell(
        onTap: () async {
          provider.addLineLobby(type: LobbyItemType.line, data: data);
        },
        child: Container(
          width: _size,
          height: _size,
          margin: EdgeInsets.all(4),
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
              color: Colors.white,
              fontSize: RegExp(r'[\d]+').hasMatch(name) ? 16 : 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ));
    });

    widgets.add(InkWell(
      onTap: () async {
        provider.addDividerLobby();
      },
      child: Container(
        width: _size,
        height: _size,
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).dividerColor,
          border: Border.all(
            width: 1,
            color: Theme.of(context).dividerColor,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          '구분',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ));

    return widgets;

  }

  Widget _buildBox(BuildContext context, Map<String, dynamic> item, double t) {
    final SettingProvider settingProvider = Provider.of<SettingProvider>(context);
    LobbyItemType type = Global().convertLobbyNumberToType(item['type']);

    if(type == LobbyItemType.line) {
      LobbyData lobbyData = LobbyData(data: item);

      return Container(
        height: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          border: Border(
            bottom: BorderSide(
              width: Global.pixel,
              color: Theme.of(context).dividerColor,
            ),
          ),
        ),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: Handle(
                vibrate: true,
                child: Container(
                  padding: EdgeInsets.only(
                    right: 12,
                  ),
                  height: double.infinity,
                  color: Colors.transparent,
                  child: Icon(
                    CupertinoIcons.equal,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      settingProvider.deleteLobby(item['_id']);
                    },
                    icon: Icon(
                      CupertinoIcons.minus_circle,
                      color: CupertinoColors.systemRed,
                    ),
                  ),
                  Text(
                    lobbyData.text,
                    style: TextStyle(
                      color: lobbyData.lineData.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else if(type == LobbyItemType.divider) {
      String text = item['text'];
      List<String> texts = text.split(':');
      String name = texts[0];

      return InkWell(
        onTap: () => editDivider(context, settingProvider, item),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            border: Border(
              bottom: BorderSide(
                width: Global.pixel,
                color: Theme.of(context).dividerColor,
              ),
            ),
          ),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: Handle(
                  vibrate: true,
                  child: Container(
                    padding: EdgeInsets.only(
                      right: 12,
                    ),
                    height: double.infinity,
                    color: Colors.transparent,
                    child: Icon(
                      CupertinoIcons.equal,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        settingProvider.deleteLobby(item['_id']);
                      },
                      icon: Icon(
                        CupertinoIcons.minus_circle,
                        color: Colors.red,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).dividerColor,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          width: Global.pixel,
                          color: Theme.of(context).dividerColor,
                        )
                      ),
                      child: Text(
                        '구분 │ ${int.parse(texts[1])}',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.caption.color,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Dimens.marginDefault,
                    ),
                    Text(
                      '$name',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else if(type == LobbyItemType.real || type == LobbyItemType.realUp || type == LobbyItemType.realDown) {
      LobbyStationData lobbyData = LobbyStationData(data: item);
      String name;

      switch(type) {
        case LobbyItemType.realUp:
          name = '${lobbyData.text} 상행';
          break;

        case LobbyItemType.realDown:
          name = '${lobbyData.text} 하행';
          break;

        default:
          name = '${lobbyData.text} 전체';
          break;
      }

      return Container(
        height: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          border: Border(
            bottom: BorderSide(
              width: Global.pixel,
              color: Theme.of(context).dividerColor,
            ),
          ),
        ),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: Handle(
                vibrate: true,
                child: Container(
                  padding: EdgeInsets.only(
                    right: 12,
                  ),
                  height: double.infinity,
                  color: Colors.transparent,
                  child: Icon(
                    CupertinoIcons.equal,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      settingProvider.deleteLobby(item['_id']);
                    },
                    icon: Icon(
                      CupertinoIcons.minus_circle,
                      color: Colors.red,
                    ),
                  ),
                  MetroChip(lineData: lobbyData.lineData,),
                  SizedBox(
                    width: Dimens.marginDefault,
                  ),
                  Text(
                    name,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      LobbyStationData lobbyData = LobbyStationData(data: item);

      return Container(
        height: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          border: Border(
            bottom: BorderSide(
              width: Global.pixel,
              color: Theme.of(context).dividerColor,
            ),
          ),
        ),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: Handle(
                vibrate: true,
                child: Container(
                  padding: EdgeInsets.only(
                    right: 12,
                  ),
                  height: double.infinity,
                  color: Colors.transparent,
                  child: Icon(
                    Icons.drag_handle,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      settingProvider.deleteLobby(item['_id']);
                    },
                    icon: Icon(
                      CupertinoIcons.minus_circle,
                      color: Colors.red,
                    ),
                  ),
                  MetroChip(lineData: lobbyData.lineData,),
                  SizedBox(
                    width: Dimens.marginDefault,
                  ),
                  Text(
                    lobbyData.text,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    final SettingProvider settingProvider = Provider.of<SettingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '로비 편집',
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<bool>(
          future: settingProvider.getSettingLobby(),
          builder: (context, snapshot) {
            if(!snapshot.hasData) {
              return Container();
            } else {
              return Column(
                children: <Widget>[
                  Expanded(
                    child: ImplicitlyAnimatedReorderableList<Map<String, dynamic>>(
                      items: settingProvider.lobbyItems,
                      areItemsTheSame: (oldItem, newItem) => oldItem['_id'] == newItem['_id'],
                      onReorderFinished: (item, from, to, newItem) {
                        settingProvider.swapLobby(from: from, to: to);
                      },
                      itemBuilder: (context, itemAnimation, item, index) {
                        return Reorderable(
                          key: ValueKey(item.toString()),
                          builder: (context, dragAnimation, inDrag) {
                            final t = dragAnimation.value;
                            Widget box = _buildBox(context, item, t);

                            if (t > 0) return box;

                            return SizeFadeTransition(
                              animation: itemAnimation,
                              axisAlignment: 1.0,
                              curve: Curves.ease,
                              child: box,
                            );
                          },
                        );
                      },
                      updateItemBuilder: (context, itemAnimation, item) {
                        return Reorderable(
                          key: ValueKey(item.toString()),
                          child: FadeTransition(
                            opacity: itemAnimation,
                            child: _buildBox(context, item, 0),
                          ),
                        );
                      },
                    ),
                  ),
                  Divider(),
                  Container(
                    height: 50,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimens.marginSmall,
                        ),
                        child: Row(
                          children: _items(context, settingProvider),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
