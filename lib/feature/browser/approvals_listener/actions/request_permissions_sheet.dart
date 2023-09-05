import 'package:app/data/models/models.dart';
import 'package:flutter/material.dart';

/// Helper function that allows show sheet to request permissions for browser
/// tab to interact with accounts.
// ignore_for_file: avoid-unused-parameters
Future<Permissions?> showRequestPermissionsSheet({
  required BuildContext context,
  required Uri origin,
  required List<Permission> permissions,
}) {
  return Future.value();
}
