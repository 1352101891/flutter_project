// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WebsiteModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebsiteModel _$WebsiteModelFromJson(Map<String, dynamic> json) {
  return WebsiteModel(
      json['icon'] as String,
      json['id'] as int,
      json['link'] as String,
      json['name'] as String,
      json['order'] as int,
      json['visible'] as int);
}

Map<String, dynamic> _$WebsiteModelToJson(WebsiteModel instance) =>
    <String, dynamic>{
      'icon': instance.icon,
      'id': instance.id,
      'link': instance.link,
      'name': instance.name,
      'order': instance.order,
      'visible': instance.visible
    };
