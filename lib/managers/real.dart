import 'dart:convert';

import 'package:silsiganmetro/dto/traindto.dart';
import 'package:http/http.dart' as http;
import 'package:silsiganmetro/values/constants.dart';

import 'line.dart';

class TrainLocation {

  Future<Map<String, List<TrainDTO>>> getTrains(String line) async {
    print('2');
    String l = Line.lines[line]['title'];
    List<TrainDTO> list = List();
    Map<String, TrainDTO> trains = Map();
    Map<String, List<TrainDTO>> locTrains = Map();

    var response = await http.get('$urlMain$l');

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

        if(line == LINE_2) {
          String first = no.substring(0, 1);

          if(first == '1' && station == '1002000211') {     // 성수지선
            station = '1102000211';
          }

          if(first == '5' && station == '1002000234') {
            station = '1102000234';
          }

          head == UP ? head = DOWN : head = UP;
        }

        print('express = $express');

        TrainDTO dto = TrainDTO(
          no: no,
          station: station,
          dst: dst + 'ddd',
          status: status,
          head: head,
          express: express,
          time: time,
        );

        trains[no] = dto;

//        if (trains[no] != null) {
//          var before = DateTime.parse(trains[no].time);
//          var after = DateTime.parse(time);
//
//          if (after.isAfter(before)) {
//            trains[no] = dto;
//          }
//        } else {
//          trains[no] = dto;
//        }
      }

      trains.forEach((key, value) {
        print('$key, $value');
        if (locTrains[value.station] == null) locTrains[value.station] = [];
        locTrains[value.station].add(value);
      });

      return locTrains;
    } catch (e) {
      print(e);
      return null;
    }

  }
}