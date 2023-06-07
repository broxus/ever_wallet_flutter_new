// ignore_for_file: no-magic-number
import 'package:app/data/models/site_meta_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'site_meta_data_dto.freezed.dart';
part 'site_meta_data_dto.g.dart';

@freezed
class SiteMetaDataDto with _$SiteMetaDataDto {
  @HiveType(typeId: 2)
  const factory SiteMetaDataDto({
    @HiveField(0) required String url,
    @HiveField(1) String? title,
    @HiveField(2) String? image,
    @HiveField(3) String? description,
  }) = _SiteMetaDataDto;
}

extension SiteMetaDataX on SiteMetaData {
  SiteMetaDataDto toDto() => SiteMetaDataDto(
        url: url,
        title: title,
        image: image,
        description: description,
      );
}

extension SiteMetaDataDtoX on SiteMetaDataDto {
  SiteMetaData toModel() => SiteMetaData(
        url: url,
        title: title,
        image: image,
        description: description,
      );
}
