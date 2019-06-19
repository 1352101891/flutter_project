import 'package:flutter/material.dart';
import 'package:flutter_app/eventbusutil.dart';
import 'package:flutter_app/shopcart.dart';
import 'package:event_bus/event_bus.dart';

void main() => runApp(mainApp());


class mainApp extends StatelessWidget {
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
List<Production> prods=<Production>[
  new Production(name:"哇哈哈",price:"2￥",icon:Icons.ac_unit),
  new Production(name:"加多宝",price:"5￥",icon:Icons.accessibility),
  new Production(name:"七喜",price:"3￥",icon:Icons.account_balance),
  new Production(name:"芬达",price:"3￥",icon:Icons.accessible),
  new Production(name:"百事可乐",price:"2.5￥",icon:Icons.access_time),
  new Production(name:"可口可乐",price:"2.5￥",icon:Icons.add_to_queue),
];

class _MyHomePageState extends State<MyHomePage> {
  void _clearAll() {
    eventBus.fire(new ClearAllEvent(true));
  }

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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.playlist_play),
            tooltip: 'Air it',
            onPressed: null,
          ),
          IconButton(
            icon: Icon(Icons.playlist_add),
            tooltip: 'Restitch it',
            onPressed: null,
          ),
          IconButton(
            icon: Icon(Icons.playlist_add_check),
            tooltip: 'Repair it',
            onPressed: null,
          ),
        ],
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: MyListView(
            productions:prods
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _clearAll,
        tooltip: 'Increment',
        child: Icon(Icons.clear_all),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
