import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class dragWidget extends StatefulWidget{
  Widget child;
  dragWidget({this.child});

  @override
  _dragStateFul createState() => _dragStateFul();
}

class _dragStateFul extends State<dragWidget> with TickerProviderStateMixin{
  double offsetDistance =380.0;
  double destinationy=0;
  double dragHeight=400;
  double upThresold=300;
  double downThresold=100;
  bool isFinished=false;
  double startPositiony;
  int duratime=200;
  bool isClosed=true;

  _dragStateFul(){
    startPositiony=offsetDistance;
  }

  void animateUpdate(double update){
    setState(() {
      offsetDistance = update;
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Transform.translate(
      offset: Offset(0,offsetDistance),
      child:GestureDetector(
          onVerticalDragStart: _start,
          onVerticalDragEnd: _end,
          onVerticalDragUpdate: _update,
          child: 
            Container(
              padding: EdgeInsets.fromLTRB(0,20,0,0),
              width: double.infinity,
              height: dragHeight,
              child:NotificationListener<ScrollEndNotification>(
                child:NotificationListener<ScrollUpdateNotification>(
                  child: NotificationListener<OverscrollNotification>(
                    child: NotificationListener<ScrollEndNotification>(
                      child: Offstage(
                          offstage:isClosed,
                          child:widget.child
                      ),
                      onNotification: (ScrollEndNotification notification) {
                        print("滑动结束");
                        return false;
                      },
                    ),
                    onNotification: (OverscrollNotification notification) {
                      if (notification.dragDetails != null &&
                          notification.dragDetails.delta != null) {
                        _update(notification.dragDetails);
                        print("滑动过头");
                      }
                      return false;
                    },
                  ),
                  onNotification:(ScrollUpdateNotification notification) {
                    return false;
                  },
                ),
                onNotification:(ScrollEndNotification notification) {
                  _end(notification.dragDetails);
                  return false;
                },
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(colors: [Colors.white70, Colors.green]),
              ),
            )

      ),
    );
  }

  void _start(DragStartDetails details){
    print("手指按下："+details.globalPosition.dx.toString()+",isFinished"+isFinished.toString());
  }

  void _end(DragEndDetails details){
    print("手指抬起：");
    if(isUp){
      if(offsetDistance<upThresold){
        toPosition(y:destinationy);
      }else{
        toPosition(y:startPositiony);
      }
    }else{
      if(offsetDistance>downThresold){
        toPosition(y:startPositiony);
      }else{
        toPosition(y:destinationy);
      }
    }
  }

  void toPosition({double x,double y}){
    double currentY=offsetDistance;
    AnimationController controller=new AnimationController(vsync: this,duration:Duration(milliseconds:duratime));
    CurvedAnimation curvedAnimation=new CurvedAnimation(parent: controller, curve: Curves.easeIn);
    Animation<double> animation=new Tween(begin:currentY,end:y).animate(curvedAnimation);
    animation.addListener(()=>{animateUpdate(animation.value)});
    animation.addStatusListener(stateListener);
    controller.forward();
  }

  void stateListener(AnimationStatus status){
    if(status==AnimationStatus.completed){
      isFinished=true;

      setState(() {
        if(offsetDistance==destinationy)
          isClosed=false;
        else if(offsetDistance==startPositiony)
          isClosed=true;
      });
    }else{
      isFinished=false;
    }
  }

  bool isUp=true;
  void _update(DragUpdateDetails details){

    offsetDistance=offsetDistance+details.delta.dy;
    if(offsetDistance<destinationy){
      offsetDistance=destinationy;
      setState(() { });
      return;
    }
    if(offsetDistance>startPositiony){
      offsetDistance=startPositiony;
      setState(() { });
      return;
    }

    setState(() { });
    print("正在滑动："+details.delta.dy.toString());
    if(details.delta.dy<0){
      isUp=true;
    }else{
      isUp=false;
    }
  }
}