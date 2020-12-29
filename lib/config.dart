
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:silsiganmetro/values/constants.dart';

class ArchiveConfig {

  static ArchiveConfig _manager = ArchiveConfig._internal();

  static ArchiveConfig get manager => _manager;

  factory ArchiveConfig() {
    return _manager;
  }

  ArchiveConfig._internal();

  SharedPreferences _prefs;

  /// 설정 초기화
  ///
  /// SharedPreferences 객체를 불러오고
  /// 데이터 베이스 초기화 후 앱 구동에 필요한 정보들을 불러옴
  ///
  /// [SharedPreferences] 객체 반환
  Future<SharedPreferences> init() async {
    _prefs = await SharedPreferences.getInstance();
    getLobby();

    return _prefs;
  }

  List<Map<String, dynamic>> getLobby() {
    List<Map<String, dynamic>> list = List();

    list.add({'type': 1, 'line': LINE_2, 'station': '선릉', 'index': 6});
    list.add({"type": 0, 'line': LINE_1, 'text': '1호선'});
    list.add({"type": 0, 'line': LINE_2, 'text': '2호선'});
    list.add({"type": 0, 'line': LINE_3, 'text': '3호선'});
    list.add({"type": 0, 'line': LINE_4, 'text': '4호선'});
    list.add({"type": 0, 'line': LINE_5, 'text': '5호선'});
    list.add({"type": 0, 'line': LINE_6, 'text': '6호선'});
    list.add({"type": 0, 'line': LINE_7, 'text': '7호선'});
    list.add({"type": 0, 'line': LINE_8, 'text': '8호선'});
    list.add({"type": 0, 'line': LINE_9, 'text': '9호선'});
    list.add({"type": 0, 'line': GYEONGUIJUNGANG, 'text': '경의중앙선'});
    list.add({"type": 0, 'line': BUNDANG, 'text': '분당선'});
    list.add({"type": 0, 'line': SHINBUNDANG, 'text': '신분당선'});
    list.add({"type": 0, 'line': GYEONGCHOON, 'text': '경춘선'});
    list.add({"type": 0, 'line': AIRPORT, 'text': '공항철도'});
    list.add({"type": 0, 'line': UISINSEOL, 'text': '우이신설선'});
    list.add({'type': 1, 'line': LINE_2, 'station': '선릉', 'index': 6});
    list.add({'type': 1, 'line': LINE_2, 'station': '선릉', 'index': 6});
    list.add({'type': 1, 'line': LINE_2, 'station': '선릉', 'index': 6});

    return list;
  }

  void setLobby() async {
    List<dynamic> list = List();

    list.add({'type': 1, 'line': LINE_2, 'station': '선릉', 'index': 6});
    list.add({'type': 0, 'line': LINE_1});
    list.add({'type': 0, 'line': LINE_2});
    list.add({'type': 0, 'line': LINE_3});

    print(jsonEncode(list));
  }

}