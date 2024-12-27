class PresetsConnectionsExceptions implements Exception {
  PresetsConnectionsExceptions(this.message);

  final String message;
}

class FetchPresetsConnectionsExceptions extends PresetsConnectionsExceptions {
  FetchPresetsConnectionsExceptions(super.message);
}

class CachePresetsConnectionsExceptions extends PresetsConnectionsExceptions {
  CachePresetsConnectionsExceptions(super.message);
}
