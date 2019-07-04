import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'LoadingWidget.dart';

class FreshContainer extends StatefulWidget{
  Widget child;
  Refresh refresh;
  LoadMore loadMore;
  FreshContainer({this.child,this.refresh,this.loadMore});

  @override
  _dragStateFul createState() => _dragStateFul();
}

class _dragStateFul extends State<FreshContainer> with TickerProviderStateMixin{
  double offsetDistance =-60;
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

  double upoffset=0;
  double upthresold=-50;
  double upangle=0;
  bool isLoadingMore=false;
  STATUS uploadStatus=STATUS.IDLE;

  _dragStateFul(){
    startPositiony=offsetDistance;
  }

  void animateUpdate(double update){
    setState(() {
      offsetDistance = update;
    });
  }
  void upsetUpdate(double update){
    setState(() {
      upoffset = update;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
        alignment:  Alignment.topCenter,
        children: [
          Stack(alignment:  Alignment.bottomCenter,
            children: [Container(
             alignment: Alignment.bottomCenter,
              child: LoadingWidget(status:uploadStatus,angle: upangle),
              height:50,
              decoration: new BoxDecoration(
//                color: Color(0xFF4068D1), // 底色
                shape: BoxShape.rectangle, // 默认值也是矩形
              )
          ),
            Transform.translate(offset: Offset(0, upoffset),
              child: GestureDetector(
                onVerticalDragStart: _start,
                onVerticalDragEnd: _end,
                onVerticalDragUpdate: _update,
                child:  Container(
                  padding: EdgeInsets.fromLTRB(0,0,0,0),
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
                    gradient: LinearGradient(begin:Alignment.topCenter,end:Alignment.bottomCenter,colors: [Colors.black12, Colors.white]),
                  ),
                )
              )
            )
          ]),
          Transform.translate(
            offset: Offset(0,offsetDistance),
            child:LoadingWidget(status: loadingStatus,angle: angle),
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
    if(isLoadingMore){
      return;
    }
    print("手指抬起：");
    if(upoffset>upthresold){
      loadtoPosition(y: 0);
    }else if(upoffset<=upthresold && upoffset>=1.5*upthresold){
      loadtoPosition(y: upthresold);
    }
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

  void loadtoPosition({double y}){
    double currentY=upoffset;
    AnimationController controller=new AnimationController(vsync: this,duration:Duration(milliseconds:duratime));
    CurvedAnimation curvedAnimation=new CurvedAnimation(parent: controller, curve: Curves.easeIn);
    Animation<double> animation=new Tween(begin:currentY,end:y).animate(curvedAnimation);
    animation.addListener(()=>{upsetUpdate(animation.value)});
    animation.addStatusListener(stateListener);
    controller.forward();
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
        if(upoffset==upthresold){
          uploadStatus=STATUS.LOADING;
          doLoadMore();
        }
        if(offsetDistance==destinationy) {
          loadingStatus = STATUS.LOADING;
          doFresh();
        }else if(offsetDistance==startPositiony) {
          loadingStatus = STATUS.IDLE;
        }
      });
    }else{
      isFinished=false;
    }
  }

  void _update(DragUpdateDetails details){
    print("正在overScroll滑动："+details.delta.dy.toString());

    if(loadingStatus==STATUS.LOADING){
      return;
    }
    if(isLoadingMore){
      return;
    }
    offsetDistance=offsetDistance+details.delta.dy;

    angle= (1.00*(offsetDistance+startPositiony))/(destinationy-startPositiony)*ratio;

    if(offsetDistance<startPositiony){
      offsetDistance=startPositiony;
      upoffset=upoffset+details.delta.dy;
      if(details.delta.dy<0){
        uploadStatus=STATUS.PUSH_UP;
      }else{
        uploadStatus=STATUS.PULL_DOWN;
      }
      if(upoffset<upthresold*1.5){
        upoffset=upthresold*1.5;
      }else{
        upangle= (1.00*(upoffset))/(upthresold*1.5)*ratio;
        setState(() { });
      }
      return;
    }
    if(offsetDistance>Maxy){
      offsetDistance=Maxy;
      setState(() { });
      return;
    }

    setState(() { });

    if(details.delta.dy<0){
      loadingStatus=STATUS.PUSH_UP;
      isUp=true;
    }else{
      loadingStatus=STATUS.PULL_DOWN;
      isUp=false;
    }
  }

  void doFresh(){
    if(widget.refresh!=null){
      Future future = new Future.delayed(Duration(milliseconds:1000),() => widget.refresh());
      future.then((_){
        toPosition(y:startPositiony);
        print("刷新结束！");
      }).catchError((_){
        toPosition(y:startPositiony);
        print("刷新出错！");
      });
    }
  }

  void doLoadMore(){
    isLoadingMore=true;
    if(widget.loadMore!=null){
      Future future = new Future.delayed(Duration(milliseconds:1000),() => widget.loadMore());
      future.then((_){
        loadtoPosition(y:0);
        print("加载更多结束！");
        isLoadingMore=false;
      }).catchError((_){
        loadtoPosition(y:0);
        print("加载更多出错！");
        isLoadingMore=false;
      });
    }
  }
}

typedef void Refresh();
typedef void LoadMore();
