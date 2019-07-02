//"id": 6,
//"link": "",
//"name": "面试",
//"order": 1,
//"visible": 1
import 'package:json_annotation/json_annotation.dart';

part 'HotWord.g.dart';
///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class HotWord{
  int id;
  String link;
  String name;
  int order;
  int visible;

  HotWord(this.id, this.link, this.name, this.order,
      this.visible); //不同的类使用不同的mixin即可
  factory HotWord.fromJson(Map<String, dynamic> json) => _$HotWordFromJson(json);
  Map<String, dynamic> toJson() => _$HotWordToJson(this);
}