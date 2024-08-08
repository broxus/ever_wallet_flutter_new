// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'browser_history_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BrowserHistoryItemDtoImpl _$$BrowserHistoryItemDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$BrowserHistoryItemDtoImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      url: uriJsonConverter.fromJson(json['url'] as String),
      visitTime: DateTime.parse(json['visitTime'] as String),
    );

Map<String, dynamic> _$$BrowserHistoryItemDtoImplToJson(
        _$BrowserHistoryItemDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'url': uriJsonConverter.toJson(instance.url),
      'visitTime': instance.visitTime.toIso8601String(),
    };
