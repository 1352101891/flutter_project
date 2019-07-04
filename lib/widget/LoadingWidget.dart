import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


enum STATUS{
  PULL_DOWN,
  LOADING,
  PUSH_UP,
  IDLE
}

class LoadingWidget extends StatefulWidget{
  STATUS status;
  double wAngle=0;
  LoadingWidget({this.status,double angle}){
    wAngle=angle;
  }

  @override
  _LoadingStateFul createState() => _LoadingStateFul();
}

class _LoadingStateFul extends State<LoadingWidget> with TickerProviderStateMixin{

  double height=50;
  double width=50;
  bool isFinished=false;
  int duratime=1000;
  AnimationController controller;
  Animation<double> animation;

  _LoadingStateFul();

  void animateUpdate(double update){
//    setState(() {
//      angle = update;
//    });
  }


  @override
  Widget build(BuildContext context) {
    Widget rotateChild;
    Widget rotateImage=Image.asset(
      'images/loading.png',
      width: width,
      height: height,
      fit: BoxFit.scaleDown,
    );
    switch(widget.status){
      case STATUS.LOADING:
        initAnimation();
        rotateChild=RotationTransition(
          turns: animation,
          alignment: Alignment.center,
          child:rotateImage
        );
        break;
      case STATUS.PULL_DOWN:
      case STATUS.PUSH_UP:
        rotateChild=Transform.rotate(
          angle: widget.wAngle * 2.0 * pi,
          alignment: Alignment.center,
          child:rotateImage
        );
        break;
      case STATUS.IDLE:
        rotateChild=Transform.rotate(
            angle: 0,
            alignment: Alignment.center,
            child:rotateImage
        );
        break;
    }


    // TODO: implement build
    return  Container(
        padding: EdgeInsets.fromLTRB(0,0,0,10),
        width: width,
        height: height,
        child: rotateChild,
    );
  }


  void initAnimation() {
    controller=new AnimationController(vsync: this,duration:Duration(milliseconds:duratime));
    CurvedAnimation curvedAnimation=new CurvedAnimation(parent: controller, curve: Curves.linear);
    animation=new Tween(begin:0.0,end:1.0).animate(curvedAnimation);
    animation.addListener(()=>{animateUpdate(animation.value)});
    controller.forward();
    controller.repeat();
  }


  @override
  void dispose() {
    super.dispose();
    if(controller!=null){
      controller.dispose();
    }
  }

}