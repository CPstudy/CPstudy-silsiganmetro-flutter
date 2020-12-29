
import 'package:silsiganmetro/values/constants.dart';

class TrainDTO {
  String no;
  String station;
  String dst;
  String status;
  String head;
  String express;
  String time;

  TrainDTO({
    this.no = '',
    this.station = '',
    this.dst = '',
    this.status = ARRIVAL,
    this.head = UP,
    this.express = '0',
    this.time = '',
  });

  TrainDTO.fromJSON(Map<String, dynamic> json) {
    this.no = json['trainNo'];
    this.station = json['statnId'];
    this.dst = json['statnTnm'];
    this.status = json['trainSttus'];
    this.head = json['updnLine'];
    this.express = json['directAt'];
    this.time = json['recptnDt'];
  }

}