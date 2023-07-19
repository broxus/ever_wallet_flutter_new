import 'package:equatable/equatable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Information of wallet that is used to map transactions.
class TokenWalletStorageInfo extends Equatable {
  const TokenWalletStorageInfo({
    required this.networkId,
    required this.group,
    required this.owner,
    required this.rootTokenContract,
  });

  final int networkId;
  final String group;
  final Address owner;
  final Address rootTokenContract;

  @override
  List<Object?> get props => [networkId, group, owner, rootTokenContract];
}
