import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'LoadingWidget.dart';

class FreshContainer extends StatefulWidget{
  Widget child;
  Refresh callback;
  FreshContainer({this.child,this.callback});

  @override
  _dragStateFul createState() => _dragStateFul();
}

class _dragStateFul extends State<FreshContainer> with TickerProviderStateMixin{
  double offsetDistance =-50;
  double destinationy=50;
  double Maxy=70;
  double thresold=35;
  bool isFinished=true;
  double startPositiony;
  int duratime=200;
  STATUS loadingStatus=STATUS.IDLE;
  bool isUp=true;
  double angle=0;
  int ratio=3; //从起点到终点，一共转几圈

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
    return Stack(
        alignment:  Alignment.topCenter,
        children: [
          GestureDetector(
            onVerticalDragStart: _start,
            onVerticalDragEnd: _end,
            onVerticalDragUpdate: _update,
            child:  Container(
              padding: EdgeInsets.fromLTRB(0,10,0,0),
              width: double.infinity,
              height: double.infinity,
              child:NotificationListener<ScrollEndNotification>(
                child:NotificationListener<ScrollUpdateNotification>(
                  child: NotificationListener<OverscrollNotification>(
                    child: NotificationListener<ScrollEndNotification>(
                      child: Offstage(
                        offstage:false ,
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
                gradient: LinearGradient(begin:Alignment.topLeft,end:Alignment.bottomRight,colors: [Colors.white70, Colors.green]),
              ),
            )
          ),
          Transform.translate(
            offset: Offset(0,offsetDistance),
            child:LoadingWidget(status: loadingStatus,angle: angle,),
          )
        ]
    );
  }

  void _start(DragStartDetails details){
    angle = 0;
    print("手指按下：" + details.globalPosition.dx.toString() + ",isFinished" +
        isFinished.toString());
  }

  void _end(DragEndDetails details){
    if(loadingStatus==STATUS.LOADING){
      return;
    }
    print("手指抬起：");
    if(isUp){
      if(offsetDistance<thresold){
        toPosition(y:startPositiony);
      }else{
        toPosition(y:destinationy);
      }
    }else{
      if(offsetDistance>thresold){
        toPosition(y:destinationy);
      }else{
        toPosition(y:startPositiony);
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
      angle=0;
      isFinished=true;

      setState(() {
        if(offsetDistance==destinationy) {
          loadingStatus = STATUS.LOADING;
          doCallback();
        }else if(offsetDistance==startPositiony) {
          loadingStatus = STATUS.IDLE;
        }
      });
    }else{
      isFinished=false;
    }
  }

  void _update(DragUpdateDetails details){
    if(loadingStatus==STATUS.LOADING){
      return;
    }
    offsetDistance=offsetDistance+details.delta.dy;

    angle= (1.00*(offsetDistance+startPositiony))/(destinationy-startPositiony)*ratio;

    if(offsetDistance<startPositiony){
      offsetDistance=startPositiony;
      setState(() { });
      return;
    }
    if(offsetDistance>Maxy){
      offsetDistance=Maxy;
      setState(() { });
      return;
    }

    setState(() { });
    print("正在滑动："+details.delta.dy.toString());
    if(details.delta.dy<0){
      loadingStatus=STATUS.PUSH_UP;
      isUp=true;
    }else{
      loadingStatus=STATUS.PULL_DOWN;
      isUp=false;
    }
  }

  void doCallback(){
    if(widget.callback!=null){
      Future future = new Future.delayed(Duration(milliseconds:1000),() => widget.callback());
      future.then((_){
        toPosition(y:startPositiony);
        print("刷新结束！");
      }).catchError((_){
        toPosition(y:startPositiony);
        print("刷新出错！");
      });
    }
  }
}

typedef void Refresh();
