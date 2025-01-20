import 'package:app/http/http.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_token_balances_response_dto.g.dart';

@JsonSerializable()
class SearchTokenBalancesResponseDto {
  const SearchTokenBalancesResponseDto({
    required this.balances,
  });

  factory SearchTokenBalancesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SearchTokenBalancesResponseDtoFromJson(json);

  final List<TokenBalanceDto> balances;

  Map<String, dynamic> toJson() => _$SearchTokenBalancesResponseDtoToJson(this);
}
