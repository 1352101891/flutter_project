import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/eventbusutil.dart';

class Production{
  String price;
  String name;
  IconData icon;
  Production({this.icon,this.price, this.name});
}

class util{
  //私有方法不可复写
  Color _getColor(BuildContext context,bool inCart) {
    return inCart ? Theme.of(context).primaryColor:Colors.black54 ;
  }

  //私有方法不可复写
  TextStyle _getTextStyle(BuildContext context,bool inCart) {
    if (!inCart) return null;

    return new TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }
}

typedef void ClickShopItem(bool isAdd,Production prod);

class ShopItem extends StatelessWidget with util{
  final bool inCart;
  final Production p;
  final ClickShopItem clickShopItem;

  ShopItem(this.inCart, Production prod,this.clickShopItem):p = prod,
        super(key: new ObjectKey(prod));

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        clickShopItem(!inCart,p);
      },
      leading: new CircleAvatar(
        backgroundColor: _getColor(context,inCart),
        child: Icon(Icons.tablet_android),
      ),
      trailing: new Icon(inCart?Icons.check:Icons.add),
      title: new ItemLayout(p,inCart),
    );
  }
}

class ItemLayout extends StatelessWidget with util{
  bool inCart;
  Production p;
  ItemLayout(this.p,this.inCart);

  @override
  Widget build(BuildContext context) {
    return Row(
        children:<Widget>[
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child:  Text("名称:"+p.name, style: inCart?Theme.of(context).textTheme.title:Theme.of(context).textTheme.subtitle),
          ),
          Text("价格:"+p.price, style: _getTextStyle(context,inCart)),
        ]
    );
  }
}

class MyListView extends StatefulWidget {
  List<Production> productions=new List();

  MyListView({Key key,this.productions}) : super(key: key);

  @override
  ShopList createState() => ShopList();
}

class ShopList extends State<MyListView> with AutomaticKeepAliveClientMixin {
  Set<Production> _shoppingCart=new Set();

  @override
  void initState() {
    super.initState();
    eventBus.on<ClearAllEvent>().listen((event) {
      print("ClearAllEvent:"+(event.flag?"true":"false"));
      if(event.flag){
        _clear();
      }
    });
  }

  @protected
  bool get wantKeepAlive=>true;

  void _clear(){
    setState(() {
      _shoppingCart.clear();
    });
  }

  void _add(Production p) {
    setState(() {
       _shoppingCart.add(p);
    });
  }

  void _remove(Production p){
    setState(() {
      _shoppingCart.remove(p);
    });
  }

  void _clickItem(bool inCart,Production p){
    if(inCart) {
      _add(p);
    }else{
      _remove(p);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: new ListView(
        //不管什么平台这样设置,对于overscroll都可以监听到
        physics: const ClampingScrollPhysics(),
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        children: widget.productions.map((p)=>
            ShopItem(_shoppingCart.contains(p),p,_clickItem)
        ).toList(),
      )
    );
  }
}
