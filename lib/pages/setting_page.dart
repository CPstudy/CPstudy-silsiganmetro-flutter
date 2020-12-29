import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:silsiganmetro/dto/dto.dart';
import 'package:silsiganmetro/foundations/config.dart';
import 'package:silsiganmetro/foundations/custom_theme.dart';
import 'package:silsiganmetro/foundations/global.dart';
import 'package:silsiganmetro/pages/settings/lobby_edit_page.dart';
import 'package:silsiganmetro/pages/settings/start_page.dart';
import 'package:silsiganmetro/pages/settings/train_edit_page.dart';
import 'package:silsiganmetro/providers/setting_provider.dart';
import 'package:silsiganmetro/values/constants.dart';
import 'package:silsiganmetro/values/dimens.dart';
import 'package:silsiganmetro/widgets/metro.dart';
import 'package:silsiganmetro/widgets/metro_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final SettingProvider provider = Provider.of<SettingProvider>(context);
    int autoRefresh = provider.autoRefresh.toInt();

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          '설정',
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SettingSection(
                header: Text(
                  '일반'
                ),
                footer: Text(
                  '자동 새로고침은 열차 위치 화면에서만 지원합니다.'
                ),
                items: [
                  SettingItem(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => StartPage())),
                    title: Text(
                      '첫 화면 설정',
                    ),
                    child: Text(
                      provider.getStartPageName(),
                    ),
                  ),
                  SettingItem(
                    title: Text(
                      autoRefresh == 0 ? '자동 새로고침 해제' : '자동 새로고침 $autoRefresh초',
                    ),
                    child: SizedBox(
                      width: 220,
                      child: CupertinoSlider(
                        value: provider.autoRefresh.toDouble(),
                        onChanged: (value) {
                          provider.autoRefresh = value.toInt();
                        },
                        min: 0.0,
                        max: 60.0,
                        divisions: 6,
                      ),
                    ),
                  ),
                ],
              ),
              SettingSection(
                header: Text(
                  '로비',
                ),
                footer: Text(
                  '왼쪽 표시는 양방향 도착 정보에만 적용됩니다.',
                ),
                items: [
                  SettingItem(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LobbyEditPage()));
                    },
                    title: Text(
                      '로비 편집',
                    ),
                    child: Icon(
                      Icons.chevron_right,
                      color: Theme.of(context).textTheme.caption.color,
                    ),
                  ),
                  SettingItem(
                    onTap: () {

                    },
                    title: Text(
                      '상행(외선) 왼쪽에 표시',
                    ),
                    child: CupertinoSwitch(
                      value: provider.lobbyUpLeft,
                      onChanged: (value) => provider.lobbyUpLeft = value,
                    ),
                  ),
                ],
              ),
              SettingSection(
                header: Text(
                  '1호선 순서',
                ),
                footer: Text(
                  provider.line1StartGyeongbu ? '경부선(가산디지털단지 - 신창) 우선으로 표시합니다.' : '경인선(구일 - 인천) 우선으로 표시합니다.',
                ),
                items: [
                  SettingItem(
                    title: Text(
                      '경부선 우선'
                    ),
                    child: CupertinoSwitch(
                      value: provider.line1StartGyeongbu,
                      onChanged: (value) => provider.line1StartGyeongbu = value,
                    ),
                  ),
                ],
              ),
              SettingSection(
                header: Text(
                  '5호선 순서',
                ),
                footer: Text(
                  provider.line5Branch ? '마천 지선(마천 방면)을 우선으로 표시합니다.' : '본선(하남풍산 방면)을 우선으로 표시합니다.',
                ),
                items: [
                  SettingItem(
                    title: Text(
                      '마천 지선 우선'
                    ),
                    child: CupertinoSwitch(
                      value: provider.line5Branch,
                      onChanged: (value) => provider.line5Branch = value,
                    ),
                  ),
                ],
              ),
              SettingSection(
                header: Text(
                  '화면'
                ),
                items: [
                  SettingItem(
                    height: 140,
                    cover: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: Dimens.marginDefault,
                      ),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimens.marginDefault,
                        ),
                        itemCount: themes.length,
                        itemBuilder: (context, index) {
                          ThemeType type;
                          if(index == 0) {
                            type = ThemeType.light;
                          } else if(index == themes.length - 1) {
                            type = ThemeType.dark;
                          } else {
                            type = themes[index + 1].type;
                          }
                          return ThemePreview(type: type);
                        },
                        separatorBuilder: (context, builder) => SizedBox(width: Dimens.marginDefault),
                      ),
                    ),
                  ),
                  SettingItem(
                    title: Text('시스템 테마'),
                    child: CupertinoSwitch(
                      value: provider.themeSystem,
                      onChanged: (value) => provider.themeSystem = value,
                    ),
                  ),
                  SettingItem(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TrainEditPage()));
                    },
                    title: Text(
                      '열차 리스트',
                    ),
                    child: Icon(
                      CupertinoIcons.chevron_forward,
                      size: 20,
                      color: Theme.of(context).textTheme.caption.color,
                    ),
                  ),
                ],
              ),
              SettingSection(
                header: Text(
                  '정보'
                ),
                items: [
                  SettingItem(
                    title: Text(
                      '버전',
                    ),
                    child: Text(
                      appVersion,
                    ),
                  ),
                  SettingItem(
                    onTap: () {
                      showLicensePage(
                        context: context,
                        applicationVersion: appVersion,
                        applicationLegalese: 'Guk2Zzada',
                      );
                    },
                    title: Text(
                      '오픈소스 정보',
                    ),
                    child: Icon(
                      CupertinoIcons.chevron_forward,
                      size: 20,
                      color: Theme.of(context).textTheme.caption.color,
                    ),
                  ),
                ],
              ),
              SettingSection(
                header: Text(
                  '출처'
                ),
                items: [
                  SettingItem(
                    title: Text(
                      '열차 위치',
                    ),
                    child: Text(
                      '서울 열린데이터 광장',
                    ),
                  ),
                  SettingItem(
                    title: Text(
                      '열차 상세 정보',
                    ),
                    child: Text(
                      '레일.블루',
                    ),
                  ),
                ],
              ),
              SettingSection(
                header: Text(
                  '문의'
                ),
                footer: Text(
                  '''추가 기능 건의나 문의 사항은 '실시간지하철 카카오톡 채널'을 통해 알려주시기 바랍니다.
                  '''
                ),
                items: [
                  SettingItem(
                    onTap: () async {
                      const url = 'http://pf.kakao.com/_bsSTK/chat';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    color: Color(0xffffdf2c),
                    title: Text(
                      '실시간지하철 카카오톡',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    child: Icon(
                      CupertinoIcons.chevron_forward,
                      size: 20,
                      color: ThemeData.light().textTheme.caption.color,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingItem extends StatelessWidget {

  SettingItem({
    this.height = 50.0,
    this.title,
    this.child,
    this.cover,
    this.divider = true,
    this.topDivider = false,
    this.onTap,
    this.color,
  });

  final double height;

  final Widget title;

  final Widget child;

  final Widget cover;

  final bool divider;

  final bool topDivider;

  final VoidCallback onTap;

  final Color color;

  @override
  Widget build(BuildContext context) {

    bool isCover = title == null && child == null;

    return Container(
      height: height,
      color: color ?? Theme.of(context).cardColor,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Container(
            child: Stack(
              children: <Widget>[
                Visibility(
                  visible: !isCover,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 16.0,
                      ),
                      child: title != null ? DefaultTextStyle(
                        child: title,
                        style: Theme.of(context).textTheme.headline6.copyWith(
                          fontSize: 16,
                        ),
                      ) : null,
                    ),
                  ),
                ),
                Visibility(
                  visible: !isCover,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: 16.0,
                      ),
                      child: child != null ? DefaultTextStyle(
                        style: Theme.of(context).textTheme.caption.copyWith(
                          fontSize: 14,
                        ),
                        child: child,
                      ) : null,
                    ),
                  ),
                ),
                Visibility(
                  visible: isCover,
                  child: Container(
                    height: height,
                    alignment: Alignment.center,
                    child: cover,
                  ),
                ),
                Visibility(
                  visible: topDivider,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Divider(),
                  ),
                ),
                Visibility(
                  visible: divider,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Divider(),
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

class SettingSection extends StatelessWidget {

  SettingSection({
    @required this.items,
    this.header,
    this.footer,
  }) : assert(items.length > 0);

  final List<Widget> items;

  final Widget header;

  final Widget footer;

  @override
  Widget build(BuildContext context) {

    Widget mHeader = header != null
      ? Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 8,
          ),
          child: DefaultTextStyle(
            child: header,
            style: Theme.of(context).textTheme.caption,
          ),
        )
      : Container();

    Widget mFooter = footer != null
      ? Padding(
          padding: EdgeInsets.only(
            top: 8,
            left: 16,
            right: 16,
          ),
          child: DefaultTextStyle(
            child: footer,
            style: Theme.of(context).textTheme.caption,
          ),
        )
      : Container();
    
    return Container(
      margin: EdgeInsets.only(
        top: 16,
        bottom: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          mHeader,
          Divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items,
          ),
          mFooter,
        ],
      ),
    );
  }
}

class ThemePreview extends StatelessWidget {

  ThemePreview({
    @required this.type,
  });

  final ThemeType type;

  @override
  Widget build(BuildContext context) {

    ThemeData themeData = Global().convertThemeTypeToData(type);
    final provider = Provider.of<SettingProvider>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: () {
          provider.setTheme(type);
        },
        child: Container(
          width: 80,
          height: 80 / 2 * 3,
          color: themeData.scaffoldBackgroundColor,
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: 15,
                    color: themeData.primaryColor,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    width: double.infinity,
                    height: 20,
                    margin: EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 4,
                    ),
                    color: themeData.cardColor,
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 4,
                        left: 4,
                      ),
                      child: Text(
                        '텍스트',
                        style: TextStyle(
                          color: themeData.textTheme.bodyText1.color,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 8,
                bottom: 8,
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: themeData.primaryColor,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: Global.pixel,
                    color: Theme.of(context).dividerColor,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Visibility(
                visible: Config().theme == type,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: CupertinoColors.systemGreen,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(
                    Icons.check_circle,
                    color: CupertinoColors.systemGreen,
                    size: 25,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}