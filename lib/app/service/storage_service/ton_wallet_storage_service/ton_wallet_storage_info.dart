import 'package:equatable/equatable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Information of wallet that is used to map transactions.
class TonWalletStorageInfo extends Equatable {
  const TonWalletStorageInfo({
    required this.networkId,
    required this.group,
    required this.address,
  });

  final int networkId;
  final String group;
  final Address address;

  @override
  List<Object?> get props => [networkId, group, address];
}
