import 'package:json_annotation/json_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'token_balance_dto.g.dart';

@JsonSerializable()
class TokenBalanceDto {
  const TokenBalanceDto({
    required this.amount,
    required this.ownerAddress,
    required this.rootAddress,
    required this.tokenWalletAddress,
    required this.token,
  });

  factory TokenBalanceDto.fromJson(Map<String, dynamic> json) =>
      _$TokenBalanceDtoFromJson(json);

  final String amount;
  final Address ownerAddress;
  final Address rootAddress;
  final Address tokenWalletAddress;
  final String token;

  Map<String, dynamic> toJson() => _$TokenBalanceDtoToJson(this);
}
