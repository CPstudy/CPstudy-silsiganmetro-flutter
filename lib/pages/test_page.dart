import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '테스트 페이지',
        ),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return Container(
            height: 100,
            margin: EdgeInsets.all(100),
            color: Colors.red,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  color: Colors.blue,
                  child: Image.asset('assets/images/train2_down_dark.png'),
                ),
                Text(
                  '$index',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
