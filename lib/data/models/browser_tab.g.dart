// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'browser_tab.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BrowserTabImpl _$$BrowserTabImplFromJson(Map<String, dynamic> json) =>
    _$BrowserTabImpl(
      id: json['id'] as String,
      url: uriJsonConverter.fromJson(json['url'] as String),
      imageId: json['imageId'] as String?,
      title: json['title'] as String?,
      sortingOrder: (json['sortingOrder'] as num).toDouble(),
    );

Map<String, dynamic> _$$BrowserTabImplToJson(_$BrowserTabImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': uriJsonConverter.toJson(instance.url),
      'imageId': instance.imageId,
      'title': instance.title,
      'sortingOrder': instance.sortingOrder,
    };
