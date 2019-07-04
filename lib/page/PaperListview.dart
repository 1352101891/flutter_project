import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/eventbusutil.dart';
import 'package:flutter_app/model/BannerModel.dart';
import 'package:flutter_app/model/PaperModel.dart';
import 'package:flutter_app/model/PaperPageInfo.dart';
import 'package:flutter_app/net/NetRequestUtil.dart';
import 'package:flutter_app/widget/FreshContainer.dart';

class util{
  //私有方法不可复写
  Color _getColor(BuildContext context,bool inCart) {
    return inCart ? Theme.of(context).primaryColor:Colors.black54 ;
  }

  //私有方法不可复写
  TextStyle _getTextStyle(BuildContext context,bool inCart) {
    if(!inCart){
      return new TextStyle(
        fontSize:10.0,
        color: Colors.black,
        decoration: TextDecoration.none,
      );
    }
    return new TextStyle(
      fontSize:10.0,
      color: Colors.blueGrey,
      decoration: TextDecoration.none,
    );
  }
}

typedef void ClickShopItem(bool isAdd,PaperModel prod);

class ArticleItem extends StatelessWidget with util{
  final bool inCart;
  final PaperModel p;
  final ClickShopItem clickShopItem;

  ArticleItem(this.inCart, PaperModel prod,this.clickShopItem):p = prod,
        super(key: new ObjectKey(prod));

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        clickShopItem(!inCart,p);
      },
//      leading: new CircleAvatar(
//        backgroundColor: _getColor(context,inCart),
//        child: Icon(Icons.insert_emoticon),
//      ),
      title: new ItemLayout(p,inCart),
    );
  }
}

class ItemLayout extends StatelessWidget with util{
  bool inCart;
  PaperModel p;
  ItemLayout(this.p,this.inCart);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:<Widget>[
          new Padding(
            padding: const EdgeInsets.fromLTRB(0,0,0,8),
            child:  Text(p.title, style: inCart?Theme.of(context).textTheme.subhead:Theme.of(context).textTheme.body1),
          ),
          Row(
            mainAxisAlignment:MainAxisAlignment.end ,
            children:<Widget>[
              Text("作者:"+p.author, style: _getTextStyle(context,inCart)),
              Padding(padding: EdgeInsets.fromLTRB(0,0,10,0)),
              Text("时间:"+p.niceDate, style: _getTextStyle(context,inCart))
            ]
          ),
          Padding(padding: EdgeInsets.fromLTRB(0,10,0,0)),
          Container(decoration:new BoxDecoration(color: Colors.white)
            ,padding:EdgeInsets.fromLTRB(0,1,0,0)
          )
        ]
    );
  }
}

class PaperListview extends StatefulWidget {
  BannerModel bannerModel;

  PaperListview({this.bannerModel});

  @override
  State createState() => PaperList();
}

class PaperList extends State<PaperListview> with AutomaticKeepAliveClientMixin {
  Set<PaperModel> _shoppingCart=new Set();
  List<PaperModel> papers=new List();
  int pageno=0;

  @override
  void initState() {
    super.initState();
    getData(pageno);
    eventBus.on<ClearAllEvent>().listen((event) {
      print("ClearAllEvent:"+(event.flag?"true":"false"));
      if(event.flag){
        _clear();
      }
    });
  }


  void getData(int pn){
    String url="https://www.wanandroid.com/article/list/"+pageno.toString()+"/json";
    get(url,(map){
      if(pn==0){
        pageno=0;
        papers.clear();
      }
      if(map!=null && map.length>0) {
        PaperPageInfo pageInfo= new PaperPageInfo.fromJson(map["data"]);
        papers.addAll(pageInfo.datas);
        pageno++;
      }
      setState(() {});
    });
  }

  @protected
  bool get wantKeepAlive=>true;

  void _clear(){
    setState(() {
      _shoppingCart.clear();
    });
  }

  void _add(PaperModel p) {
    setState(() {
       _shoppingCart.add(p);
    });
  }

  void _remove(PaperModel p){
    setState(() {
      _shoppingCart.remove(p);
    });
  }

  void _clickItem(bool inCart,PaperModel p){
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
      body: Center(
        child:Align(
          alignment: Alignment.center,
          child:FreshContainer(
            child:ListView(
              //不管什么平台这样设置,对于overscroll都可以监听到
              physics: const ClampingScrollPhysics(),
              children: papers.map((p)=>
                  ArticleItem(_shoppingCart.contains(p),p,_clickItem)
              ).toList(),
            ),
            refresh:()=>getData(0),
            loadMore: ()=>getData(pageno),
          ),
        )
      )
    );
  }
}
