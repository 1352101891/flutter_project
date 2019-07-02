import 'package:json_annotation/json_annotation.dart';

// user.g.dart 将在我们运行生成命令后自动生成
part 'Tag.g.dart';
//"name": "问答",
//"url": "/article/list/0?cid=440"
///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class Tag{
  String name;
  String url;

  Tag(this.name, this.url); //不同的类使用不同的mixin即可
  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
  Map<String, dynamic> toJson() => _$TagToJson(this);
}