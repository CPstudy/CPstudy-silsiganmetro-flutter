import 'package:shared_preferences/shared_preferences.dart';
import 'package:silsiganmetro/dto/dto.dart';
import 'package:silsiganmetro/foundations/custom_theme.dart';
import 'package:silsiganmetro/foundations/global.dart';

enum ThemeType {
  light,
  dark,
  navy,
  purple,
  red,
  blue,
  green,
  orange,
  indigo,
}

class Config {
  static Config _manager = Config._internal();

  static Config get manager => _manager;

  factory Config() {
    return _manager;
  }

  Config._internal();

  SharedPreferences _prefs;

  bool start = true;

  Future<SharedPreferences> init() async {
    _prefs = await SharedPreferences.getInstance();

    return _prefs;
  }

  set theme(ThemeType type) {
    int index = 0;

    for(ThemeIndexData data in themes) {
      if(data.type == type) {
        index = data.index;
      }
    }

    _prefs.setInt('theme', index);
  }

  ThemeType get theme {
    int index = _prefs.getInt('theme') ?? 0;
    return Global().convertThemeIndexToType(index);
  }

  /// 시스템 테마 설정
  bool get themeSystem => _prefs.getBool('themeSystem') ?? true;
  set themeSystem(bool b) => _prefs.setBool('themeSystem', b);

  /// 리스트 높이
  double get lineHeight => _prefs.getDouble('lineHeight') ?? 60.0;
  set lineHeight(double height) => _prefs.setDouble('lineHeight', height);

  /// 오른쪽 정렬
  bool get right => _prefs.getBool('right') ?? false;
  set right(bool b) => _prefs.setBool('right', b);

  /// 아이콘 테두리 색상 반전
  bool get invertOutline => _prefs.getBool('invertOutline') ?? false;
  set invertOutline(bool b) => _prefs.setBool('invertOutline', b);

  /// 아이콘 설정
  int get trainIconIndex {
    int index = _prefs.getInt('trainIcon') ?? 0;

    if(index >= Global().trainIcons.length) {
      index = 0;
    }

    return index;
  }
  set trainIconIndex(int index) => _prefs.setInt('trainIcon', index);

  /// 열차 정보 글씨 크기
  double get trainFontSize => _prefs.getDouble('trainFontSize') ?? 11;
  set trainFontSize(double size) => _prefs.setDouble('trainFontSize', size);

  /// 역 이름 글씨 크기
  double get stationFontSize => _prefs.getDouble('stationFontSize') ?? 16;
  set stationFontSize(double size) => _prefs.setDouble('stationFontSize', size);

  /// 시작 페이지
  ///
  /// [lineNumber] 노선 번호, 0: 사용 안 함
  int get startPage => _prefs.getInt('startPage') ?? 0;
  set startPage(int lineNumber) => _prefs.setInt('startPage', lineNumber);

  int get autoRefresh => _prefs.getInt('autoRefresh') ?? 0;
  set autoRefresh(int second) => _prefs.setInt('autoRefresh', second);

  bool get line1StartGyeongbu => _prefs.getBool('line1StartGyeongbu') ?? false;
  set line1StartGyeongbu(bool b) => _prefs.setBool('line1StartGyeongbu', b);

  bool get line5Branch => _prefs.getBool('line5Branch') ?? false;
  set line5Branch(bool b) => _prefs.setBool('line5Branch', b);

  bool get showStatus => _prefs.getBool('showStatus') ?? false;
  set showStatus(bool b) => _prefs.setBool('showStatus', b);

  bool get lobbyUpLeft => _prefs.getBool('lobbyUpLeft') ?? false;
  set lobbyUpLeft(bool b) => _prefs.setBool('lobbyUpLeft', b);

  String getPinStation(Metro metro) {
    LineData lineData = metros[metro];
    String stationCode = _prefs.getString('${lineData.number}_pin') ?? '0:0';
    return stationCode;
  }

  void setPinStation(Metro metro, String stationCode) {
    LineData lineData = metros[metro];
    _prefs.setString('${lineData.number}_pin', stationCode);
  }

}