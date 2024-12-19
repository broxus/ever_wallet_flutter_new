import 'package:json_annotation/json_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'get_token_balances_request_dto.g.dart';

@JsonSerializable()
class GetTokenBalancesRequestDto {
  const GetTokenBalancesRequestDto({
    required this.limit,
    required this.offset,
    required this.ownerAddress,
    this.rootAddresses,
    this.balanceGt,
  });

  factory GetTokenBalancesRequestDto.fromJson(Map<String, dynamic> json) =>
      _$GetTokenBalancesRequestDtoFromJson(json);

  final int limit;
  final int offset;
  final Address ownerAddress;
  final List<Address>? rootAddresses;
  final String? balanceGt;

  Map<String, dynamic> toJson() => _$GetTokenBalancesRequestDtoToJson(this);
}
