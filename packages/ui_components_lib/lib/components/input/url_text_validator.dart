class UrlTextValidator {
  /// Validates a URL. If the URL is invalid, returns an error message.
  UrlTextValidator({
    this.emptyError,
    this.schemeError,
    this.hostError,
    this.portError,
    this.pathError,
  });

  final String? emptyError;
  final String? schemeError;
  final String? hostError;
  final String? portError;
  final String? pathError;

  String? validate(String? value) {
    final stripped = value?.trim() ?? '';
    final length = stripped.length;

    if (length == 0 && emptyError != null) {
      return emptyError;
    }

    if (length == 0) {
      return null;
    }

    final uri = Uri.tryParse(value!);
    if (uri == null) {
      return schemeError;
    }

    if (schemeError != null && !uri.hasScheme) {
      return schemeError;
    }

    if (hostError != null && uri.host.isEmpty) {
      return hostError;
    }

    if (portError != null && uri.hasPort) {
      return portError;
    }

    if (pathError != null && uri.path.isEmpty) {
      return pathError;
    }

    return null;
  }
}
