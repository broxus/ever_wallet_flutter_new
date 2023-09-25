import 'package:app/data/models/models.dart';

enum ConnectionType {
  jrpc,
  gql,
  proto;

  bool get enableMultipleEndpoints {
    switch (this) {
      case ConnectionType.jrpc:
        return false;
      case ConnectionType.gql:
        return true;
      case ConnectionType.proto:
        return false;
    }
  }

  bool get enableLocal {
    switch (this) {
      case ConnectionType.jrpc:
        return false;
      case ConnectionType.gql:
        return true;
      case ConnectionType.proto:
        return false;
    }
  }

  static ConnectionType fromConnection(ConnectionData connection) {
    return connection.when(
      gql: (
        _,
        __,
        ___,
        ____,
        _____,
        ______,
        _______,
        ________,
        _________,
        __________,
        ___________,
        ____________,
      ) =>
          ConnectionType.gql,
      proto: (
        _,
        __,
        ___,
        ____,
        _____,
        ______,
        _______,
        ________,
        _________,
        __________,
      ) =>
          ConnectionType.proto,
      jrpc: (
        _,
        __,
        ___,
        ____,
        _____,
        ______,
        _______,
        ________,
        _________,
        __________,
      ) =>
          ConnectionType.jrpc,
    );
  }
}
