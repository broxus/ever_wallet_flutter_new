/// This is a helper class that allow transform string address of account
/// or get helpful information from it.
class AddressUtils {
  /// Get workchain id from account address where it's something like:
  /// 0:1fsagfsdgfas....
  static int workchain(String address) => int.parse(address.split(':').first);
}
