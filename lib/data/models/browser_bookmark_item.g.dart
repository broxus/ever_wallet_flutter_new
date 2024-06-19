// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'browser_bookmark_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BrowserBookmarkItemImpl _$$BrowserBookmarkItemImplFromJson(
        Map<String, dynamic> json) =>
    _$BrowserBookmarkItemImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      url: uriJsonConverter.fromJson(json['url'] as String),
      sortingOrder: (json['sortingOrder'] as num).toDouble(),
    );

Map<String, dynamic> _$$BrowserBookmarkItemImplToJson(
        _$BrowserBookmarkItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'url': uriJsonConverter.toJson(instance.url),
      'sortingOrder': instance.sortingOrder,
    };
