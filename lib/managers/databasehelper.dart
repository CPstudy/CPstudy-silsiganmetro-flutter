import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:silsiganmetro/dto/dto.dart';
import 'package:silsiganmetro/foundations/global.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';

class DatabaseHelper {

  /// 데이터베이스 파일 이름
  static final String dbName = 'silsiganmetro.db';
  static final String dbTrain = 'train_20201027.db';

  /// 로비 화면 테이블 이름
  static final String lobbyTable = 'lobby_data';

  static final DatabaseHelper _instance = DatabaseHelper._internal();

  /// 클래스 초기화 부분
  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  /// 데이터베이스 객체가 없을 경우 객체 생성
  Database _metroDB;
  Future<Database> get metroDB async {

    if(_metroDB != null) return _metroDB;

    _metroDB = await _initDatabase(dbName);
    
    return _metroDB;
  }

  Database _trainDB;
  Future<Database> get trainDB async {
    if(_trainDB != null) return _trainDB;

    checkDatabaseVersion(_trainDB, dbTrain);
    _trainDB = await _initDatabase(dbTrain);

    return _trainDB;
  }

  Future<void> checkDatabaseVersion(Database database, String databaseName) async {
    String header = RegExp(r'(.*?)_?([\d]+)?.db').firstMatch(databaseName).group(1);
    String dir = await getDatabasesPath();
    RegExp reg = RegExp(r'(.*)(' + header + r'(_[\d]+)?.db)');

    List<FileSystemEntity> list = Directory(dir).listSync();
    for(FileSystemEntity file in list) {
      String path = file.path;
      if(reg.hasMatch(path)) {
        Match match = reg.firstMatch(path);
        String fileName = match.group(2);
        RegExp regDate = RegExp(r'' + header + r'_?([\d]+)?.db');

        String lastVersion = regDate.firstMatch(databaseName).group(1);     // 최신 DB 버전
        String currentVersion = regDate.firstMatch(fileName).group(1) ?? '20200101';

        if(int.parse(lastVersion) > int.parse(currentVersion)) {
          print('has new version database :: $databaseName');
          database = null;
          await Directory(path).delete(recursive: true);
        }

      }
    }
  }

  /// 데이스베이스 복사
  _initDatabase(String name) async {
    String dir = await getDatabasesPath();
    String path = join(dir, name);

    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      print('Not Found Database $name');

      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch(_) {}

      ByteData data = await rootBundle.load('assets/data/$name');
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes);

    } else {
      print('Found Database $name');
    }

    return await openDatabase(path);
  }

  Future<List<Map<String, dynamic>>> getLobby() async {
    Database db = await metroDB;
    
    List<Map<String, dynamic>> list = await db.rawQuery("SELECT * FROM lobby_data ORDER BY sort, _id");

    return list;
  }

  Future<int> addLobby({
    @required LobbyItemType type,
    Metro metro,
    int group = 0,
    String text = '',
    String stationCode,
    int index = 0,
  }) async {
    Database db = await metroDB;
    int typeIndex = Global().convertLobbyTypeToNumber(type);
    int line = Global().convertMetroToLineNumber(metro);

    int result = await db.rawInsert('INSERT INTO $lobbyTable (group_id, type, text, line, stationcode, list_index, sort) VALUES (?, ?, ?, ?, ?, ?, ?)',
      [group, typeIndex, text, line, stationCode, index, 999999999]);

    return result;

  }

  Future<int> deleteLobby(int id) async {
    Database db = await metroDB;

    int result = await db.rawDelete('DELETE FROM $lobbyTable WHERE _id = ?', [id]);

    return result;
  }

  Future<int> reorderRobby(List<Map<String, dynamic>> list) async {
    Database db = await metroDB;
    int result;

    for(int i = 0; i < list.length; i++) {
      int id = list[i]['_id'];
      result = await db.rawUpdate('UPDATE $lobbyTable SET sort = ? WHERE _id = ?', [i, id]);
    }

    return result;
  }

  Future<Map<String, dynamic>> getDividerInfo(int id) async {
    Database db = await metroDB;

    List<Map<String, dynamic>> list = await db.rawQuery('SELECT * FROM $lobbyTable WHERE _id = ?', [id]);

    if(list != null && list.length == 1) {
      return list[0];
    } else {
      return null;
    }
  }

  Future<int> updateDividerInfo({@required int id, String name, int height}) async {
    Database db = await metroDB;

    int result = await db.rawUpdate('UPDATE $lobbyTable SET text = ? WHERE _id = ?', ['$name:$height', id]);

    return result;
  }

  Future<Map<String, dynamic>> getTrainData(Metro metro) async {
    Database db = await trainDB;
    List<Map<String, dynamic>> list;
    Map<String, dynamic> result = HashMap();

    int weekday = DateTime.now().weekday;
    String table;

    try {
      if(metro == Metro.line2) {

        if(weekday == DateTime.saturday || weekday == DateTime.sunday) {
          table = 'line2_weekend';
        } else {
          table = 'line2_norm';
        }

      } else if(metro == Metro.line1) {
        if(weekday == DateTime.saturday || weekday == DateTime.sunday) {
          table = 'line1_weekend';
        } else {
          table = 'line1_norm';
        }
      } else if(metro == Metro.line3) {
        if(weekday == DateTime.saturday || weekday == DateTime.sunday) {
          table = 'line3_weekend';
        } else {
          table = 'line3_norm';
        }
      } else if(metro == Metro.line4) {
        if(weekday == DateTime.saturday || weekday == DateTime.sunday) {
          table = 'line4_weekend';
        } else {
          table = 'line4_norm';
        }
      }

      list = await db.rawQuery('SELECT * FROM $table');

      for(Map<String, dynamic> map in list) {
        String trainNo = map['trainNo'];

        result[trainNo] = map;
      }
    } catch (e) {
      print(e);
    }

    return result;
  }

}