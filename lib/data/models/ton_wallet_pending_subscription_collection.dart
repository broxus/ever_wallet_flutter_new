import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Collection that is used to compare TonWallet that is in progress
/// of subscribing
@immutable
class TonWalletPendingSubscriptionCollection {
  const TonWalletPendingSubscriptionCollection({
    required this.asset,
    required this.transportCollection,
  });

  final TonWalletAsset asset;
  final List<dynamic> transportCollection;

  bool isSameTransport(List<dynamic> otherTransportCollection) =>
      const DeepCollectionEquality()
          .equals(transportCollection, otherTransportCollection);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TonWalletPendingSubscriptionCollection &&
          runtimeType == other.runtimeType &&
          asset == other.asset;

  @override
  int get hashCode => asset.hashCode;
}
