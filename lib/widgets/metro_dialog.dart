import 'package:flutter/material.dart';

/// 다이얼로그 템플릿
class MetroDialog extends StatefulWidget {

  MetroDialog({
    this.title,
    this.message,
    this.messageStyle,
    this.content,
    this.positiveText,
    this.negativeText,
    this.positive,
    this.negative,
  });

  /// 제목
  final String title;

  /// 본문 메시지
  final String message;

  /// 메시지 텍스트 스타일
  final TextStyle messageStyle;

  /// 본문
  final Widget content;

  /// 긍정 버튼 텍스트
  ///
  /// [positiveText]가 null일 경우 기본값 '확인'
  final String positiveText;

  /// 부정 버튼 텍스트
  ///
  /// [negativeText]가 null일 경우 기본값 '닫기'
  final String negativeText;

  /// 긍정 버튼
  ///
  /// [positive]가 null일 경우 버튼이 생성되지 않음
  final Function positive;

  /// 부정 버튼
  ///
  /// [negative]가 null일 경우 버튼이 생성되지 않음
  final Function negative;

  @override
  _MetroDialogState createState() => _MetroDialogState();
}

class _MetroDialogState extends State<MetroDialog> {

  /// 버튼 높이
  final double buttonHeight = 50.0;

  @override
  Widget build(BuildContext context) {
    // 각 위젯들에 값이 할당되어있지 않는 경우
    // 빈 위젯을 생성하거나 그에 맞는 위젯 생성

    /// 다이얼로그 제목
    ///
    /// 값이 있을 경우 제목 생성
    Widget widgetTitle = Container();

    if(widget.title != null) {
      widgetTitle = Container(
        padding: EdgeInsets.only(
          top: 16,
          bottom: 8,
        ),
        child: Text(
          widget.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        ),
      );
    }

    /// 다이얼로그 메시지
    ///
    /// 간단한 설명을 적을 수 있는 부분
    /// 값이 있는 경우에만 생성
    Widget widgetMessage = Container();

    if(widget.message != null) {

      TextStyle style = TextStyle(
        color: Color(0xff6c6c6c),
        fontSize: 14,
        fontWeight: FontWeight.w500
      );

      if(widget.messageStyle != null) style = widget.messageStyle;

      widgetMessage = Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          vertical: 8,
        ),
        constraints: BoxConstraints(
          minHeight: 90,
        ),
        child: Text(
          widget.message,
          textAlign: TextAlign.center,
          style: style,
        ),
      );
    }

    /// 다이얼로그 본문 위젯
    ///
    /// [widget.content]에 값이 있으면 생성하며
    /// Flexible 위젯으로 감싸 자동으로 크기 조절
    Widget current = Container();

    if(widget.content != null) {
      current = Flexible(
        child: widget.content,
      );
    }

    /// 하단 버튼
    ///
    /// positive버튼과 negative 버튼이 없는 경우
    /// 다이얼로그에는 버튼이 없는 상태가 되며
    /// positive 버튼과 negative 버튼의 유무에 따라
    /// 다이얼로그 형태가 달라지게 됨
    ///
    /// 각 버튼에 들어갈 텍스트는
    /// [positiveText]와 [negativeText]로 설정 가능
    Widget bottomButton = Container();

    if(widget.positive != null && widget.negative == null) {
      bottomButton = Material(
        child: Ink(
          color: Theme.of(context).primaryColor,
          child: InkWell(
            onTap: widget.positive,
            child: Container(
              width: double.infinity,
              height: buttonHeight,
              alignment: Alignment.center,
              child: Text(
                widget.positiveText ?? '확인',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      );
    } else if(widget.positive == null && widget.negative != null) {
      bottomButton = Material(
        child: Ink(
          color: Color(0xffe4e4e4),
          child: InkWell(
            splashColor: Colors.black.withOpacity(0.2),
            onTap: widget.negative,
            child: Container(
              width: double.infinity,
              height: buttonHeight,
              alignment: Alignment.center,
              child: Text(
                widget.negativeText ?? '닫기',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      );
    } else if(widget.positive != null && widget.negative != null) {
      bottomButton = Row(
        children: <Widget>[
          Flexible(
            flex: 37,
            child: Material(
              child: Ink(
                color: Color(0xff444444),
                child: InkWell(
                  onTap: widget.negative,
                  child: Container(
                    width: double.infinity,
                    height: buttonHeight,
                    alignment: Alignment.center,
                    child: Text(
                      widget.negativeText ?? '닫기',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 63,
            child: Material(
              child: Ink(
                color: Theme.of(context).primaryColor,
                child: InkWell(
                  onTap: widget.positive,
                  child: Container(
                    width: double.infinity,
                    height: buttonHeight,
                    alignment: Alignment.center,
                    child: Text(
                      widget.positiveText ?? '확인',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          constraints: BoxConstraints(
            minWidth: 350,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              widgetTitle,
              widgetMessage,
              current,
              bottomButton,
            ],
          ),
        ),
      ),
    );
  }
}
