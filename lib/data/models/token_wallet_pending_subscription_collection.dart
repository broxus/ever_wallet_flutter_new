import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:tuple/tuple.dart';

@immutable

/// Collection that is used to compare TokenWallet that is in progress
/// of subscribing
class TokenWalletPendingSubscriptionCollection {
  const TokenWalletPendingSubscriptionCollection({
    required this.asset,
    required this.transportCollection,
  });

  /// first - owner(address), second - rootContract
  final Tuple2<String, String> asset;
  final List<dynamic> transportCollection;

  bool isSameTransport(List<dynamic> otherTransportCollection) =>
      const DeepCollectionEquality()
          .equals(transportCollection, otherTransportCollection);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokenWalletPendingSubscriptionCollection &&
          runtimeType == other.runtimeType &&
          asset == other.asset;

  @override
  int get hashCode => asset.hashCode;
}
