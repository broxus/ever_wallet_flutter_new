class PresetsConnectionsExceptions implements Exception {
  PresetsConnectionsExceptions(this.message);

  final String message;

  @override
  String toString() {
    return ''
        'PresetsConnectionsExceptions('
        '\n'
        ' message: $message'
        '\n'
        ')'
        '';
  }
}

class FetchPresetsConnectionsExceptions extends PresetsConnectionsExceptions {
  FetchPresetsConnectionsExceptions(super.message);
}

class CachePresetsConnectionsExceptions extends PresetsConnectionsExceptions {
  CachePresetsConnectionsExceptions(super.message);
}

class LocalPresetsConnectionsExceptions extends PresetsConnectionsExceptions {
  LocalPresetsConnectionsExceptions(super.message);
}
