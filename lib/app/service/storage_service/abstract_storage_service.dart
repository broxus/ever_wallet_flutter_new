/// This is an abstraction above any storage service that allows init and clear
/// data from <StorageManagerService>.
abstract class AbstractStorageService {
  /// Init all user-data.
  /// This let you call read methods to init stream data.
  Future<void> init();

  /// Remove from storage all data that can be linked to user.
  Future<void> clear();
}
