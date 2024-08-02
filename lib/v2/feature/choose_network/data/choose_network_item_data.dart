class ChooseNetworkItemData {
  ChooseNetworkItemData({
    required this.id,
    required this.networkType,
  });

  final String id;
  final ChooseNetworkType networkType;
}

enum ChooseNetworkType {
  ever,
  venom,
}
