abstract interface class StorageMigration {
  Future<void> apply();

  Future<void> complete();
}
