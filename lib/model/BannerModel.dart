import 'package:json_annotation/json_annotation.dart';

// user.g.dart 将在我们运行生成命令后自动生成

///这个标注是告诉生成器，这个类是需要生成Model类的

class BannerModel{
  int id;
  String desc;
  String imagePath;
  int isVisible;
  int order;
  String title;
  int type;
  String url;


  BannerModel({this.id, this.desc, this.imagePath, this.isVisible, this.order,
      this.title, this.type, this.url}); //不同的类使用不同的mixin即可
}