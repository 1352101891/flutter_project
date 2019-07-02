import 'package:json_annotation/json_annotation.dart';

import 'Tag.dart';

// user.g.dart 将在我们运行生成命令后自动生成
part 'PaperModel.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class PaperModel{
String apkLink;
String author;
int chapterId;
String chapterName;
bool collect;
String courseId;
String desc;
String envelopePic;
bool fresh;
String id;
String link;
String niceDate;
String origin;
String prefix;
String projectLink;
double publishTime;
int superChapterId;
String superChapterName;
List<Tag> tags;
String title;
int type;
int userId;
int visible;
int zan;


PaperModel(this.apkLink, this.author, this.chapterId, this.chapterName,
    this.collect, this.courseId, this.desc, this.envelopePic, this.fresh,
    this.id, this.link, this.niceDate, this.origin, this.prefix,
    this.projectLink, this.publishTime, this.superChapterId,
    this.superChapterName, this.tags, this.title, this.type, this.userId,
    this.visible, this.zan); //不同的类使用不同的mixin即可
factory PaperModel.fromJson(Map<String, dynamic> json) => _$PaperModelFromJson(json);
Map<String, dynamic> toJson() => _$PaperModelToJson(this);
}

//"apkLink": "",
//"author": "三好码农",
//"chapterId": 313,
//"chapterName": "字节码",
//"collect": false,
//"courseId": 13,
//"desc": "",
//"envelopePic": "",
//"fresh": false,
//"id": 8635,
//"link": "https://juejin.im/post/5d0fa403f265da1bb67a2335",
//"niceDate": "2019-06-24",
//"origin": "",
//"prefix": "",
//"projectLink": "",
//"publishTime": 1561372474000,
//"superChapterId": 245,
//"superChapterName": "Java深入",
//"tags": [],
//"title": "重学Java-一个Java对象到底占多少内存",
//"type": 0,
//"userId": -1,
//"visible": 1,
//"zan": 0