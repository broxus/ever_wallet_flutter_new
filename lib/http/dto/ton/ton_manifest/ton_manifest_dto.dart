import 'package:json_annotation/json_annotation.dart';

part 'ton_manifest_dto.g.dart';

@JsonSerializable()
class TokenManifestDto {
  const TokenManifestDto({
    required this.name,
    required this.url,
    required this.iconUrl,
  });

  factory TokenManifestDto.fromJson(Map<String, dynamic> json) =>
      _$TokenManifestDtoFromJson(json);

  final String name;
  final String url;
  final String iconUrl;

  Map<String, dynamic> toJson() => _$TokenManifestDtoToJson(this);
}
