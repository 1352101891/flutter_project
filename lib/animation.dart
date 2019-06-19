import 'package:flutter/material.dart';
import 'package:flutter_app/bottomdragwidget.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
          child:Align(
            alignment: Alignment.bottomCenter,
            child: dragWidget(),
          ),
      )
    );
  }

}

class dragWidget extends StatefulWidget{

  @override
  _dragStateFul createState() => _dragStateFul();
}

class _dragStateFul extends State<dragWidget> with TickerProviderStateMixin{
  double offsetDistance = 350.0;
  double destinationy=0;
  double dragHeight=400;
  double upThresold=300;
  double downThresold=100;
  bool isFinished=false;
  double startPositiony;
  int duratime=500;

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
              child: Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                height: dragHeight,
                child: Text("拖拽我"),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
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