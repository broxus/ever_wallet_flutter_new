import 'package:app/http/http.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_token_balances_response_dto.g.dart';

@JsonSerializable()
class GetTokenBalancesResponseDto {
  const GetTokenBalancesResponseDto({
    required this.balances,
  });

  factory GetTokenBalancesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$GetTokenBalancesResponseDtoFromJson(json);

  final List<TokenBalanceDto> balances;

  Map<String, dynamic> toJson() => _$GetTokenBalancesResponseDtoToJson(this);
}
