import 'package:flutter/cupertino.dart';
import 'package:silsiganmetro/components/expressicon.dart';
import 'package:silsiganmetro/components/item_single.dart';
import 'package:silsiganmetro/components/rail.dart';
import 'package:silsiganmetro/components/refreshbutton.dart';
import 'package:silsiganmetro/components/single_rail.dart';
import 'package:silsiganmetro/components/title_scaffold.dart';
import 'package:silsiganmetro/components/train.dart';
import 'package:silsiganmetro/components/trainview.dart';
import 'package:silsiganmetro/dto/stationdto.dart';
import 'package:silsiganmetro/dto/traindto.dart';
import 'package:silsiganmetro/foundations/global.dart';
import 'package:silsiganmetro/managers/line.dart';
import 'package:silsiganmetro/managers/real.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class LocateScreen extends StatefulWidget {

  final String line;

  LocateScreen(this.line);

  @override
  _LocateScreenState createState() => _LocateScreenState(line);
}

class _LocateScreenState extends State<LocateScreen> with TickerProviderStateMixin {

  String line;
  List<Station> stations;
  Map<String, List<TrainDTO>> trains = Map();

  AnimationController rotateController;

  _LocateScreenState(this.line);


  @override
  void initState() {
    rotateController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,

    );
    rotateController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        rotateController.repeat();
      }
    });
    stations = Line().getStationsByLineString(line);
    loadTrains();

    super.initState();
  }


  @override
  void dispose() {
    rotateController.dispose();

    super.dispose();
  }

  Future loadTrains() async {
    rotateController.forward(from: 0.0);
    TrainLocation real = TrainLocation();
    print('1');
    trains = await real.getTrains(line);
    print('4');

    rotateController.stop(canceled: true);
    rotateController.value = 0.0;

    if(trains == null || trains.length == 0) {
      return;
    }

    setState(() {
      for(Station station in stations) {
        if(station.list == null) station.list = [];
        else station.list.clear();

        if(trains[station.no] != null) {
          station.list = trains[station.no];
        }
      }
    });

  }

  @override
  Widget build(BuildContext context) {

    return TitleScaffold(
      color: Line.lines[line]['color'],
      title: Line.lines[line]['title'],
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(0),
                  scrollDirection: Axis.vertical,
                  itemCount: stations.length + 1,
                  itemBuilder: (BuildContext context, int index){
                    if(index == stations.length) {
                      return Container(
                        height: 150,
                      );
                    } else {
                      return GestureDetector(
                        onTap: (){

                        },
                        child: ItemSingle(
                          context: context,
                          metro: Metro.line2,
                          station: stations[index],
                        ),
                      );
                    }
                  }
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: EdgeInsets.only(right: 24, bottom: 36),
              child: RefreshButton(
                onTap: (){
                  loadTrains();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
