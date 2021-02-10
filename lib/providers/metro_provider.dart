import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:silsiganmetro/config.dart';
import 'package:silsiganmetro/dto/dto.dart';
import 'package:silsiganmetro/dto/stationdto.dart';
import 'package:silsiganmetro/dto/traindto.dart';
import 'package:silsiganmetro/foundations/config.dart';
import 'package:silsiganmetro/foundations/global.dart';
import 'package:silsiganmetro/managers/databasehelper.dart';
import 'package:silsiganmetro/managers/line.dart';
import 'package:silsiganmetro/values/constants.dart';

import 'package:http/http.dart' as http;

class LobbyProvider with ChangeNotifier {
  List<Map<String, dynamic>> lobbyItems = List();

  bool _exitDialog = false;
  get exitDialog => _exitDialog;
  set exitDialog(bool b) {
    _exitDialog = b;
    notifyListeners();
  }

  void reload() {
    notifyListeners();
  }

  void reloadData() {
    Global().realStations.clear();
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>> getLobby() async {
    //return Config().getLobby();
    return await DatabaseHelper().getLobby();
  }

}

class LocateProvider with ChangeNotifier {

  LocateProvider({
    @required this.metro,
  }) : assert(metro != null);

  final Metro metro;

  bool loading = false;

  List<Station> _stations;

  Timer timer;
  int time = 0;

  List<Station> get stations {
    print('get Station');
    if(_stations == null) _stations = Line().getStations(metro);
    return _stations;
  }

  Future<List<Station>> getTrains({bool refresh = true}) async {
    Map<String, List<TrainDTO>> trains = await getReal();

    if(trains == null || trains.length == 0) {
      return stations;
    }

    for(Station station in stations) {
      if(station.list == null) station.list = [];
      else station.list.clear();

      if(trains[station.no] != null) {
        station.list = trains[station.no];
      }
    }

    loading = false;

    return stations;
  }

  Future<Map<String, List<TrainDTO>>> getReal() async {
    loading = true;

    LineData lineData = Global().getLineData(metro);
    String rawLine = lineData.name.replaceAll('·', '');
    Map<String, TrainDTO> trains = Map();
    Map<String, List<TrainDTO>> stations = Map();
    Map<String, dynamic> trainData;
    List<String> lines = List();

    if(metro == Metro.suinbundang) {
      lines.add('분당선');
      lines.add('수인선');
    } else {
      lines.add(rawLine);
    }

    if(metro == Metro.line2) {
      trainData = await DatabaseHelper().getTrainData(metro);
    } else if(metro == Metro.line1 || metro == Metro.line3 || metro == Metro.line4) {
      trainData = await DatabaseHelper().getTrainData(metro);
    }

    for(String line in lines) {
      var response = await http.get('$urlMain$line');

      try {
        Map<String, dynamic> body = json.decode(response.body);
        var results = body['realtimePositionList'] as List;

        for (var object in results) {
          String no = object['trainNo'];
          String station = object['statnId'];
          String dst = object['statnTnm'];
          String status = object['trainSttus'];
          String head = object['updnLine'];
          String express = object['directAt'];
          String time = object['recptnDt'];

          if(line == '2호선') {
            String first = no.substring(0, 1);

            // 성수역 성수지선 열차
            if(first == '1' && station == '1002000211') {
              station = '1102000211';
            }

            // 신도림역 신정지선 열차
            if(first == '5' && station == '1002000234') {
              station = '1102000234';
            }

            // 성수지선 방향
            if(first != '1') {
              head == UP ? head = DOWN : head = UP;
            }

            // 열차 번호
            RegExp reg = RegExp(r'[02346789]([\d]{3})');
            if(reg.hasMatch(no)) {
              Match match = reg.firstMatch(no);
              no = '2${match.group(1)}';
              print('trainNo = $no');
            }

            // 행선지
            Map<String, dynamic> map = trainData[no];
            if(map != null) {
              dst = map['dstStation'];
            }
          } else if(line == '1호선' || line == '3호선' || line == '4호선') {
            Map<String, dynamic> map = trainData[no];
            if(map != null) {
              no = '${map['trainType']}$no';
            } else {
              if(express != '0') {
                no = 'K$no';
              }
            }

            if(line == '1호선' && express != '0' && head == UP) {
              switch(dst) {
                case '서울':
                  dst = '용산';
                  break;

                case '동대문':
                  dst = '구로';
                  break;
              }
            }
          } else if(line == '우이신설선') {
            if(head == UP) {
              head = DOWN;
            } else {
              head = UP;
            }
            try {
              if(int.parse(no) % 2 == 1 && dst == '신설동') {
                dst = '북한산우이';
              } else if(int.parse(no) % 2 == 0 && dst == '북한산우이') {
                dst = '신설동';
              }
            } catch(e) {
              print(e);
            }
          }

          TrainDTO dto = TrainDTO(
            no: no,
            station: station,
            dst: destinations[dst] ?? dst,
            status: status,
            head: head,
            express: express,
            time: time,
          );

          trains[no] = dto;

        }

        trains.forEach((key, value) {
          if (stations[value.station] == null) stations[value.station] = [];
          stations[value.station].add(value);
        });

      } catch (e) {
        print(e);
      }
    }

    return stations;
  }

  Future<Map<String, dynamic>> getRealStation(Metro metro, String stationCode, String station) async {
    Map<String, dynamic> realStations = Global().realStations;

    if(realStations.containsKey(stationCode)) {
      return realStations[stationCode];
    }

    Random random = Random();
    await Future.delayed(Duration(milliseconds: random.nextInt(1000)));

    Map<String, dynamic> result = Map();

    try {
      realStations[stationCode] = result = {
        'status': 'No Data',
      };

      var response = await http.get('$urlStation${convertStations[station] ?? station}');
      print('$station ::: ${response.body}');

      Map<String, dynamic> body = json.decode(response.body);
      Map<String, dynamic> errorMessage = body['errorMessage'];
      int status = errorMessage['status'];
      String code = errorMessage['code'];
      String message = errorMessage['message'];
      int total = errorMessage['total'];

      if(status != 200 || code != 'INFO-000') {
        result = {
          'status': status,
          'code': code,
          'message': message,
        };
      } else {
        List<dynamic> list = body['realtimeArrivalList'];
        List<RealStationData> realList = List();

        for(int i = 0; i < list.length; i++) {
          String code = stationCode.split(':')[0];
          if(code == list[i]['statnId']) {

            String updown;
            if(list[i]['updnLine'] == '상행' || list[i]['updnLine'] == '내선') {
              updown = UP;
            } else {
              updown = DOWN;
            }

            String trainNo = list[i]['btrainNo'];
            String dst = list[i]['bstatnNm'];

            if(metro == Metro.line2) {
              RegExp reg = RegExp(r'[02346789]([\d]{3})');
              if(reg.hasMatch(trainNo)) {
                Match match = reg.firstMatch(trainNo);
                trainNo = '2${match.group(1)}';
                print('trainNo = $trainNo');

                if(list[i]['updnLine'] == '상행' || list[i]['updnLine'] == '내선') {
                  updown = DOWN;
                } else {
                  updown = UP;
                }
              }

              Map<String, dynamic> trainData = await DatabaseHelper().getTrainData(metro);
              if(trainData[trainNo] != null) {
                dst = trainData[trainNo]['dstStation'];
              }
            }

            realList.add(RealStationData(
              trainNo: trainNo,
              trainType: list[i]['btrainSttus'],
              dst: dst,
              updown: updown,
              arrivalMessage1: list[i]['arvlMsg2'],
              arrivalMessage2: list[i]['arvlMsg3'],
              arrivalTime: list[i]['barvlDt'] ?? 60000,
              arrivalStatus: list[i]['arvlCd'],
              order: list[i]['ordkey'],
            ));
          }
        }

        realList.sort((a, b) => a.order.compareTo(b.order));

        RealStationData up1;
        RealStationData up2;
        RealStationData down1;
        RealStationData down2;

        for(int i = 0; i < realList.length; i++) {
          switch(realList[i].dst) {
            case '0':
            case '900':
              continue;
              break;
          }

          if(realList[i].updown == UP) {
            if(up1 == null) {
              up1 = realList[i];
            } else if(up2 == null) {
              up2 = realList[i];
            }
          } else {
            if(down1 == null) {
              down1 = realList[i];
            } else if(down2 == null) {
              down2 = realList[i];
            }
          }
        }

        result = {
          'status': status,
          'code': code,
          'message': message,
          'total': total,
          'up1': up1,
          'up2': up2,
          'down1': down1,
          'down2': down2,
        };

        print(result);

        realStations[stationCode] = result;

      }

    } catch (e) {
      print(e);
    }

    return realStations[stationCode];
  }

  void refresh() {
    notifyListeners();
  }
}