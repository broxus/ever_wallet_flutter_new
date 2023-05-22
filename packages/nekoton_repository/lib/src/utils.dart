extension AddressExtension on String {
  /// Get workchain id from account address where it's something like:
  /// 0:1fsagfsdgfas....
  int get workchain => int.parse(split(':').first);
}
