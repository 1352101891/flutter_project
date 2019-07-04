// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PaperPageInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaperPageInfo _$PaperPageInfoFromJson(Map<String, dynamic> json) {
  return PaperPageInfo(
      json['curPage'] as int,
      json['offset'] as int,
      json['over'] as bool,
      json['pageCount'] as int,
      json['size'] as int,
      json['total'] as int,
      (json['datas'] as List)
          ?.map((e) =>
              e == null ? null : PaperModel.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$PaperPageInfoToJson(PaperPageInfo instance) =>
    <String, dynamic>{
      'curPage': instance.curPage,
      'offset': instance.offset,
      'over': instance.over,
      'pageCount': instance.pageCount,
      'size': instance.size,
      'total': instance.total,
      'datas': instance.datas
    };
