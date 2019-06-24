import 'package:json_annotation/json_annotation.dart';

// user.g.dart 将在我们运行生成命令后自动生成
part 'BannerModel.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()

class BannerModel{
  int id;
  String desc;
  String imagePath;
  int isVisible;
  int order;
  String title;
  int type;
  String url;


  BannerModel(this.id, this.desc, this.imagePath, this.isVisible, this.order,
      this.title, this.type, this.url); //不同的类使用不同的mixin即可
  factory BannerModel.fromJson(Map<String, dynamic> json) => _$BannerModelFromJson(json);
  Map<String, dynamic> toJson() => _$BannerModelToJson(this);
}