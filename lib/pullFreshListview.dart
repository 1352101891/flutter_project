import 'package:flutter/material.dart';
import 'package:flutter_app/eventbusutil.dart';
import 'package:flutter_app/shopcart.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter_app/widget/LoadingWidget.dart';


void main() => runApp(mainApp());


List<Production> prods=<Production>[
  new Production(name:"哇哈哈",price:"2￥",icon:Icons.ac_unit),
  new Production(name:"加多宝",price:"5￥",icon:Icons.accessibility),
  new Production(name:"七喜",price:"3￥",icon:Icons.account_balance),
  new Production(name:"芬达",price:"3￥",icon:Icons.accessible),
  new Production(name:"百事可乐",price:"2.5￥",icon:Icons.access_time),
  new Production(name:"可口可乐",price:"2.5￥",icon:Icons.add_to_queue),
];


class mainApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

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
        leading:IconButton(
          icon: Icon(Icons.arrow_back_ios),
          tooltip: 'Air it',
          onPressed: null,
        ),
        title: Text('My Fancy Dress'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new Stack(
          alignment: const Alignment(0, -1.0),
          children: [
            LoadingWidget(status: STATUS.LOADING)
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
