import 'package:flutter/material.dart';
import 'package:silsiganmetro/dto/dto.dart';
import 'package:silsiganmetro/dto/stationdto.dart';
import 'package:silsiganmetro/foundations/config.dart';
import 'package:silsiganmetro/foundations/custom_theme.dart';
import 'package:silsiganmetro/foundations/global.dart';
import 'package:silsiganmetro/managers/databasehelper.dart';

class SettingProvider with ChangeNotifier {

  List<Map<String, dynamic>> lobbyItems = List();

  void reload() {
    notifyListeners();
  }

  Future<bool> initConfig() async {
    await Config().init();
    return true;
  }

  ThemeData getTheme() {
    ThemeType type = Config().theme;
    return Global().convertThemeTypeToData(type);
  }

  void setTheme(ThemeType type) {
    Config().theme = type;
    notifyListeners();
  }

  Future<bool> getSettingLobby() async {
    List<Map<String, dynamic>> list = await DatabaseHelper().getLobby();
    lobbyItems = List.from(list);

    return true;
  }

  void swapLobby({@required int from, @required int to}) {
    assert(from != null);
    assert(to != null);

    Map<String, dynamic> lobby = lobbyItems.removeAt(from);
    lobbyItems.insert(to, lobby);

    reorderLobby();
  }

  Future addLineLobby({
    @required LobbyItemType type,
    @required LineData data,
  }) async {
    assert(type != null);
    assert(data != null);

    Metro metro = Global().convertLineNumberToMetro(data.number);
    await DatabaseHelper().addLobby(type: LobbyItemType.line, metro: metro, text: data.name,);
    await getSettingLobby();

    notifyListeners();
  }

  Future addStationLobby({
    @required LineData data,
    @required Station station,
    @required int index,
  }) async {
    assert(data != null);
    assert(station != null);
    assert(index != null);

    Metro metro = Global().convertLineNumberToMetro(data.number);
    await DatabaseHelper().addLobby(
      type: LobbyItemType.station,
      metro: metro,
      text: station.name,
      stationCode: '${station.no}:${station.subNo}',
      index: index,
    );
    await getSettingLobby();

    notifyListeners();
  }

  Future addRealStationLobby({
    @required LobbyItemType type,
    @required LineData data,
    @required Station station,
    @required int index,
  }) async {
    assert(type != null);
    assert(data != null);
    assert(station != null);
    assert(index != null);

    Metro metro = Global().convertLineNumberToMetro(data.number);
    await DatabaseHelper().addLobby(
      type: type,
      metro: metro,
      text: station.name,
      stationCode: '${station.no}:${station.subNo}',
      index: index,
    );
    await getSettingLobby();

    notifyListeners();
  }

  Future addDividerLobby({String text = '', int height = 1}) async {
    await DatabaseHelper().addLobby(
      type: LobbyItemType.divider,
      text: '$text:$height',
    );
    await getSettingLobby();
    notifyListeners();
  }

  Future<int> deleteLobby(int id) async {
    for(int i = 0; i < lobbyItems.length; i++) {
      if(lobbyItems[i]['_id'] == id) {
        lobbyItems.removeAt(i);
      }
    }
    int result = await DatabaseHelper().deleteLobby(id);

    notifyListeners();
    return result;
  }

  Future reorderLobby() async {
    await DatabaseHelper().reorderRobby(lobbyItems);
    notifyListeners();
  }

  bool get themeSystem => Config().themeSystem;
  set themeSystem(bool b) {
    Config().themeSystem = b;
    notifyListeners();
  }

  double get lineHeight => Config().lineHeight;
  set lineHeight(double height) {
    Config().lineHeight = height;
    notifyListeners();
  }

  bool get right => Config().right;
  set right(bool b) {
    Config().right = b;
    notifyListeners();
  }

  bool get invertOutline => Config().invertOutline;
  set invertOutline(bool b) {
    Config().invertOutline = b;
    notifyListeners();
  }

  int get trainIconIndex => Config().trainIconIndex;
  TrainIconData get trainIconData => Global().trainIcons[trainIconIndex];
  set trainIconIndex(int index) {
    Config().trainIconIndex = index;
    notifyListeners();
  }

  double get trainFontSize => Config().trainFontSize;
  set trainFontSize(double size) {
    Config().trainFontSize = size;
    notifyListeners();
  }

  double get stationFontSize => Config().stationFontSize;
  set stationFontSize(double size) {
    Config().stationFontSize = size;
    notifyListeners();
  }

  int get startPage => Config().startPage;
  String getStartPageName() {
    int page = startPage;

    if(page == 0) {
      return '로비';
    } else {
      Metro metro = Global().convertLineNumberToMetro(page);
      LineData data = metros[metro];

      return data.name;
    }
  }
  set startPage(int lineNumber) {
    Config().startPage = lineNumber;
    notifyListeners();
  }

  int get autoRefresh => Config().autoRefresh;
  set autoRefresh(int second) {
    Config().autoRefresh = second;
    notifyListeners();
  }

  int _dividerHeight;
  int get dividerHeight => _dividerHeight;
  set dividerHeight(int height) {
    _dividerHeight = height;
    notifyListeners();
  }

  String _dividerName;
  String get dividerName => _dividerName;
  set dividerName(String name) {
    _dividerName = name;
    notifyListeners();
  }

  Future<Map<String, dynamic>> getDividerInfo(int id) async {
    Map<String, dynamic> map = await DatabaseHelper().getDividerInfo(id);
    String text = map['text'];
    List<String> texts = text.split(':');

    if(_dividerHeight == null) _dividerHeight = int.parse(texts[1]);

    return map;
  }

  bool get line1StartGyeongbu => Config().line1StartGyeongbu;
  set line1StartGyeongbu(bool b) {
    Config().line1StartGyeongbu = b;
    notifyListeners();
  }

  bool get line5Branch => Config().line5Branch;
  set line5Branch(bool b) {
    Config().line5Branch = b;
    notifyListeners();
  }

  bool get showStatus => Config().showStatus;
  set showStatus(bool b) {
    Config().showStatus = b;
    notifyListeners();
  }

  bool get lobbyUpLeft => Config().lobbyUpLeft;
  set lobbyUpLeft(bool b) {
    Config().lobbyUpLeft = b;
    notifyListeners();
  }

  String getPinStation(Metro metro) {
    String stationCode = Config().getPinStation(metro);
    return stationCode;
  }

  void setPinStation(Metro metro, String no, String subNo) {
    String stationCode = '$no:$subNo';
    Config().setPinStation(metro, stationCode);

    notifyListeners();
  }

}