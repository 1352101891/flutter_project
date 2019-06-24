// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_app/model/BannerModel.dart';
import 'package:flutter_app/net/Constants.dart';
import 'package:flutter_app/net/NetRequestUtil.dart';

class TabbedAppBarSample extends StatefulWidget {

  @override
  _TabbedAppBar createState() {
    return _TabbedAppBar();
  }
}

class _TabbedAppBar extends State<TabbedAppBarSample>  {
  List<BannerModel> banners=[];
  bool isloading=true;
  //私有方法不可复写
  Color _getColor(BuildContext context) {
    return  Theme.of(context).primaryColor;
  }


  @override
  Widget build(BuildContext context) {
    if(isloading){
//    要通过json_serializable方式反序列化JSON字符串，我们不需要对先前的代码进行任何更改。
//    Map userMap = JSON.decode(json);
//    var user = new User.fromJson(userMap);
//    序列化也一样。调用API与之前相同。
//    String json = JSON.encode(user);

      get(getBanner,
              (map){
                map["data"].forEach((item){
                  var bm = new BannerModel.fromJson(item);
                  banners.add(bm);
                });
                setState(() {isloading=false; });
              }
      );


      return new MaterialApp(
          home: new Scaffold(
            backgroundColor: _getColor(context),
            body: Center(
                child:Icon(Icons.local_activity)
              )
            ),
        );
    }else{
      return new MaterialApp(
        home: new DefaultTabController(
          length: banners.length,
          child: new Scaffold(
            appBar: new AppBar(
              title: const Text('Tabbed AppBar'),
              bottom: new TabBar(
                isScrollable: true,
                tabs: banners.map((BannerModel ban) {
                  return new Tab(
                    text: ban.title,
                    icon: Image.network(ban.url),
                  );
                }).toList(),
              ),
            ),
            body: new TabBarView(
              children: banners.map((BannerModel ban) {
                return new Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: new ChoiceCard(choice: ban),
                );
              }).toList(),
            ),
          ),
        ),
      );
    }
  }
}

class Choice {
  const Choice({ this.title, this.icon });
  final String title;
  final IconData icon;
}


class ChoiceCard extends StatelessWidget {
  const ChoiceCard({ Key key, this.choice }) : super(key: key);

  final BannerModel choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return new Card(
      color: Colors.white,
      child: new Center(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
//            new Icon(choice.icon, size: 128.0, color: textStyle.color),
            new Text(choice.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(new TabbedAppBarSample());
}