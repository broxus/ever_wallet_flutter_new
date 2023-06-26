extension StringExtensions on String {
  /// Get address of account, suitable for displaying in UI.
  String ellipseAddress() =>
      '${substring(0, 6)}...${substring(length - 4, length)}';

  /// Get public key, suitable for displaying in UI.
  String ellipsePublicKey() =>
      '${substring(0, 4)}...${substring(length - 4, length)}';
}
