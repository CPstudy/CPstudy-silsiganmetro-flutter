import 'package:silsiganmetro/dto/traindto.dart';

class Station {
  String name;
  String text;
  String no;
  String subNo;
  int type;
  int express;
  bool divider;
  bool up;
  bool down;
  List<TrainDTO> list = List();
  int get lineNumber => int.parse(no.substring(0, 4));
  String nextStation;
  String prevStation;

  Station({
    this.name: '',
    this.text: '',
    this.no: '',
    this.subNo: '0',
    this.type: 0,
    this.express: 0,
    this.divider: false,
    this.up: true,
    this.down: true,
    this.list,
    this.nextStation,
    this.prevStation,
  }) {
    if(list == null) list = [];
  }
}