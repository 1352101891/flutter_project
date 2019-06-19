import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class BottomDragWidget extends StatefulWidget {
  @override
  _BottomDragWidgetState createState() => _BottomDragWidgetState();
}

class _BottomDragWidgetState extends State<BottomDragWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Align(
        alignment: Alignment.bottomCenter,
        child: DragContainer(),
      )
    ],);
  }
}

class DragContainer extends StatefulWidget {
  @override
  _DragContainerState createState() => _DragContainerState();
}

class _DragContainerState extends State<DragContainer> {
  double offsetDistance = 0.0;

  @override
  Widget build(BuildContext context) {
    ///使用Transform.translate 移动drag的位置
    return Transform.translate(
      offset: Offset(0.0, offsetDistance),
      child: RawGestureDetector(
        gestures: {MyVerticalDragGestureRecognizer: getRecognizer()},
        child: Container(
          width: 100.0,
          height: 100.0,
          color: Colors.brown,
        ),
      ),
    );
  }

  GestureRecognizerFactoryWithHandlers<MyVerticalDragGestureRecognizer>
  getRecognizer() {
    return GestureRecognizerFactoryWithHandlers(
            () => MyVerticalDragGestureRecognizer(), this._initializer);
  }

  void _initializer(MyVerticalDragGestureRecognizer instance) {
    instance
      ..onStart = _onStart
      ..onUpdate = _onUpdate
      ..onEnd = _onEnd;
  }

  ///接受触摸事件
  void _onStart(DragStartDetails details) {
    print('触摸屏幕${details.globalPosition}');
  }

  ///垂直移动
  void _onUpdate(DragUpdateDetails details) {
    print('垂直移动${details.delta}');
    offsetDistance = offsetDistance + details.delta.dy;
    setState(() {});
  }

  ///手指离开屏幕
  void _onEnd(DragEndDetails details) {
    print('离开屏幕');
  }
}

class MyVerticalDragGestureRecognizer extends VerticalDragGestureRecognizer {
  MyVerticalDragGestureRecognizer({Object debugOwner})
      : super(debugOwner: debugOwner);
}

