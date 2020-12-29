import 'package:flutter/material.dart';
import 'package:silsiganmetro/components/title_scaffold.dart';

/// 설정 페이지
class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return TitleScaffold(
      title: '설정',
      body: Column(

      ),
    );
  }
}

/// 설정 리스트 아이템 위젯
class SettingItem extends StatelessWidget {

  /// SettingItem 생성
  ///
  /// [text]는 필수값으로 각 항목의 기본 텍스트
  /// [subText]가 없는 경우 보이지 않음
  SettingItem({
    @required this.text,
    this.subText
  });

  /// 기본 텍스트
  ///
  /// 왼쪽에 표시되며 각 항목의 이름을 표시할 텍스트
  final String text;

  /// 서브 텍스트
  ///
  /// 오른쪽에 표시되며 각 항목의 설정된 값을 표시할 텍스트
  final String subText;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
