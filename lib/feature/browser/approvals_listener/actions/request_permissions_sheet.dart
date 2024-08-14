import 'package:app/data/models/models.dart';
import 'package:app/feature/browser/approvals_listener/actions/request_permissions/request_permissions.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function that allows show sheet to request permissions for browser
/// tab to interact with accounts.
Future<Permissions?> showRequestPermissionsSheet({
  required BuildContext context,
  required Uri origin,
  required List<Permission> permissions,
}) {
  return showCommonBottomSheet(
    context: context,
    title: LocaleKeys.selectAccount.tr(),
    centerTitle: true,
    body: (_, scrollController) => RequestPermissionsWidget(
      origin: origin,
      permissions: permissions,
      scrollController: scrollController,
      previousSelectedAccount: null,
    ),
  );
}

/// Helper function that allows show sheet to change account for browser.
/// This is same as [showRequestPermissionsSheet] but with different title.
Future<Permissions?> showChangeAccountSheet({
  required BuildContext context,
  required Uri origin,
  required List<Permission> permissions,
  required Address? previousSelectedAccount,
}) {
  return showCommonBottomSheet(
    context: context,
    title: LocaleKeys.changeAccount.tr(),
    centerTitle: true,
    body: (_, scrollController) => RequestPermissionsWidget(
      origin: origin,
      permissions: permissions,
      scrollController: scrollController,
      previousSelectedAccount: previousSelectedAccount,
    ),
  );
}
