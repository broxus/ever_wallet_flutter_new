import 'package:json_annotation/json_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'ton_token_info_dto.g.dart';

@JsonSerializable()
class TonTokenInfoDto {
  const TonTokenInfoDto({
    required this.address,
    required this.name,
    required this.symbol,
    required this.decimals,
    required this.description,
    required this.imageUrl,
  });

  factory TonTokenInfoDto.fromJson(Map<String, dynamic> json) =>
      _$TonTokenInfoDtoFromJson(json);

  final Address address;
  final String? name;
  final String? symbol;
  final int? decimals;
  final String? description;
  final String? imageUrl;

  Map<String, dynamic> toJson() => _$TonTokenInfoDtoToJson(this);
}
