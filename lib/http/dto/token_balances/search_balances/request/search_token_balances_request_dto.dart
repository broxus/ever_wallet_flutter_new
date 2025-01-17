import 'package:json_annotation/json_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'search_token_balances_request_dto.g.dart';

@JsonSerializable()
class SearchTokenBalancesRequestDto {
  const SearchTokenBalancesRequestDto({
    required this.limit,
    required this.ownerAddress,
    this.rootAddresses,
  });

  factory SearchTokenBalancesRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SearchTokenBalancesRequestDtoFromJson(json);

  final int limit;
  final Address ownerAddress;
  final List<Address>? rootAddresses;

  Map<String, dynamic> toJson() => _$SearchTokenBalancesRequestDtoToJson(this);
}
