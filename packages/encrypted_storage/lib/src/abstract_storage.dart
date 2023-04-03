import 'dart:async';

/// Default domain name
const String defaultDomain = 'default';

/// {@template storage}
/// AbstractStorage: storage interface
/// {@endtemplate}
abstract class AbstractStorage {
  /// Clear storage: all records
  Future<void> clearAll();

  /// Clear storage: all records in one domain
  Future<void> clearDomain([String? domain = defaultDomain]);

  /// Write the key-value pair. [value] will be written for the [key] in
  /// [domain].
  /// If the pair was already existed it will be overwritten if [overwrite]
  /// is true (by default)
  Future<void> set(
    String key,
    String value, {
    String domain = defaultDomain,
    bool overwrite = true,
  });

  /// Write the key-value pair map. [pairs] will be written in [domain].
  /// If the pair was already existed it will be overwritten if [overwrite]
  /// is true (by default). Unspecified in [pairs] in db will not be altered
  /// or deleted.
  Future<void> setDomain(
    Map<String, String> pairs, {
    String domain = defaultDomain,
    bool overwrite = true,
  });

  /// Delete by [key] from [domain].
  Future<void> delete(
    String key, {
    String domain = defaultDomain,
  });

  /// Delete by [keys] from [domain].
  Future<void> deleteDomain(
    List<String> keys, {
    String domain = defaultDomain,
  });

  /// Get value by [key] and [domain]. If not found will return [defaultValue]
  Future<String?> get(
    String key, {
    String? defaultValue,
    String domain = defaultDomain,
  });

  /// Get key-value pair map from [domain].
  Future<Map<String, String>> getDomain({
    String domain = defaultDomain,
  });
}
