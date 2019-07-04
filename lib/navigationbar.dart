// Flutter code sample for material.BottomNavigationBar.1

// This example shows a [BottomNavigationBar] as it is used within a [Scaffold]
// widget. The [BottomNavigationBar] has three [BottomNavigationBarItem]
// widgets and the [currentIndex] is set to index 0. The selected item is
// amber. The `_onItemTapped` function changes the selected item's index
// and displays a corresponding message in the center of the [Scaffold].
//
// ![A scaffold with a bottom navigation bar containing three bottom navigation
// bar items. The first one is selected.](https://flutter.github.io/assets-for-api-docs/assets/material/bottom_navigation_bar.png)

import 'package:flutter/material.dart';
import 'package:flutter_app/animation.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/page/HomeTabView.dart';
import 'package:flutter_app/shopcart.dart';
import 'package:flutter_app/widget/FreshContainer.dart';
import 'package:flutter_app/widget/LoadingWidget.dart';

import 'eventbusutil.dart';

void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class drawerLayout extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Drawer(
        child:ListView(
          children:<Widget>[
            DrawerHeader(
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.all(0),
                child: GestureDetector(
                  onTap: ()=>showTip(context,"DrawerHeader"),
                  child:Image(fit:BoxFit.contain,image: new AssetImage('images/timg.jpg')),
                )
            )
          ]..addAll(prods.map((f)=>
              ListTile(
                onTap:()=>showTip(context,f.name),
                title: Text(f.name),
                subtitle: Text(f.price),
                leading: new CircleAvatar(
                  child: Icon(f.icon),
                ),
                trailing: new Icon(Icons.add),
              )).toList())
        ),
    );
  }

  /// 创建一个平移变换
  /// 跳转过去查看源代码，可以看到有各种各样定义好的变换
  static SlideTransition createTransition(
      Animation<double> animation, Widget child) {
//    return new FadeTransition(opacity: new Tween(begin: 1.0,end: 0.0).animate(animation),child: child);
    return new SlideTransition(
      position: new Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(animation),
      child: child, // child is the value returned by pageBuilder
    );
  }

  void showTip(BuildContext context,String name){
    if(name=="哇哈哈" || name=="加多宝"){
      Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
        return new mainApp();
      }));
    }else{
      Navigator.of(context).push(new PageRouteBuilder(pageBuilder:
          (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return new mainApp();
      }, transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
          ) {
        // 添加一个平移动画
        return createTransition(animation, child);
      }));
    }
//    showModalBottomSheet(
//        context: context,
//        builder: (BuildContext context) {
//          return new Container(
//            height: 100.0,
//            child: new Text("你点击了："+name),
//          );
//        }).then((val) {
//      print(val);
//    });
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}
class _MyStatefulWidgetState extends State<MyStatefulWidget>  with AutomaticKeepAliveClientMixin {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  /// 页面控制器（`PageController`）组件，页面视图（`PageView`）的控制器。
  PageController _controller = PageController();

  static void _clearAll() {
    eventBus.fire(new ClearAllEvent(true));
  }

  static List<Widget> _widgetOptions = <Widget>[
    HomeTabView(),
    MyListView(
        productions:prods
    ),
    Scaffold(
      body: Center(
        child:Align(
          alignment: Alignment.center,
          child:FreshContainer(
            child: MyListView(
              productions: prods,
            ),
            refresh:(){ _clearAll();print("测试游戏啊！");},
          ),
        )
      )
    )
  ];

  static const navigationitem=const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('Home'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      title: Text('Business'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.school),
      title: Text('School'),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // 跳到页面（`jumpToPage`）方法，更改显示在的页面视图（`PageView`）组件中页面。
      _controller.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Sample'),
      ),
      body: PageView.builder(
        // 物理（`physics`）属性，页面视图应如何响应用户输入。
        // 从不可滚动滚动物理（`NeverScrollableScrollPhysics`）类，不允许用户滚动。
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return _widgetOptions.elementAt(index);
        },
        itemCount: _widgetOptions.length,
        // 控制器（`controller`）属性，用于控制滚动此页面视图位置的对象。
        controller: _controller,
      ),
      // 底部导航栏（`bottomNavigationBar`）属性，显示在脚手架（`Scaffold`）组件的底部。
      // 底部导航栏（`BottomNavigationBar`）组件，显示在应用程序底部的组件，
      // 用于在几个屏幕之间中进行选择，通常在三到五之间，再多就不好看了。
      bottomNavigationBar: BottomNavigationBar(
        // 项目（`items`）属性，位于底部导航栏中的交互组件，其中每一项都有一个图标和标题。
        items: navigationitem,
        // 目前的索引（`currentIndex`）属性，当前活动项的项目索引。
        currentIndex: _selectedIndex,
        // 固定颜色（`fixedColor`）属性，当BottomNavigationBarType.fixed时所选项目的颜色。
        fixedColor: Color(0xffFE7C30),
        // 在点击（`onTap`）属性，点击项目时调用的回调。
        onTap: _onItemTapped,
        // 定义底部导航栏（`BottomNavigationBar`）组件的布局和行为。
        type: BottomNavigationBarType.fixed,
      ),
      drawer:drawerLayout(),
    );
  }

  /// 释放相关资源。
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @protected
  bool get wantKeepAlive=>true;
}