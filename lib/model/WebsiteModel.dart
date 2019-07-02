//"icon": "",
//"id": 17,
//"link": "http://www.wanandroid.com/article/list/0?cid=176",
//"name": "国内大牛博客集合",
//"order": 1,
//"visible": 1
import 'package:json_annotation/json_annotation.dart';

// user.g.dart 将在我们运行生成命令后自动生成
part 'WebsiteModel.g.dart';
//"name": "问答",
//"url": "/article/list/0?cid=440"
///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class WebsiteModel{
  String icon;
  int id;
  String link;
  String name;
  int order;
  int visible;

  WebsiteModel(this.icon, this.id, this.link, this.name, this.order,
      this.visible); //不同的类使用不同的mixin即可
  factory WebsiteModel.fromJson(Map<String, dynamic> json) => _$WebsiteModelFromJson(json);
  Map<String, dynamic> toJson() => _$WebsiteModelToJson(this);
}