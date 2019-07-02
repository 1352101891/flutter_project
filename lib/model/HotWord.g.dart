// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HotWord.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotWord _$HotWordFromJson(Map<String, dynamic> json) {
  return HotWord(json['id'] as int, json['link'] as String,
      json['name'] as String, json['order'] as int, json['visible'] as int);
}

Map<String, dynamic> _$HotWordToJson(HotWord instance) => <String, dynamic>{
      'id': instance.id,
      'link': instance.link,
      'name': instance.name,
      'order': instance.order,
      'visible': instance.visible
    };
