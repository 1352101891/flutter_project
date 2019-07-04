import 'package:json_annotation/json_annotation.dart';

import 'PaperModel.dart';
import 'Tag.dart';

// user.g.dart 将在我们运行生成命令后自动生成
part 'PaperPageInfo.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class PaperPageInfo{
  int curPage;
  int offset;

  bool over;
  int pageCount;

  int size;
  int total;
  List<PaperModel> datas;

  PaperPageInfo(this.curPage, this.offset, this.over, this.pageCount, this.size,
      this.total,this.datas);
  factory PaperPageInfo.fromJson(Map<String, dynamic> json) => _$PaperPageInfoFromJson(json);
  Map<String, dynamic> toJson() => _$PaperPageInfoToJson(this);

}
