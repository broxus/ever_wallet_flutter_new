import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function to show [AccountRenameSheet].
ModalRoute<void> getRenameAccountSheet(String address) {
  return commonBottomSheetRoute(
    title: LocaleKeys.enterNewName.tr(),
    body: (_, __) => AccountRenameSheet(address: address),
  );
}

/// Sheet that allows to rename account with [address].
class AccountRenameSheet extends StatefulWidget {
  const AccountRenameSheet({
    required this.address,
    super.key,
  });

  final String address;

  @override
  State<AccountRenameSheet> createState() => _AccountRenameSheetState();
}

class _AccountRenameSheetState extends State<AccountRenameSheet> {
  final nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SeparatedColumn(
      mainAxisSize: MainAxisSize.min,
      separatorSize: DimensSize.d16,
      children: [
        CommonInput(
          controller: nameController,
          titleText: LocaleKeys.nameWord.tr(),
          onSubmitted: (_) => _renameAccount(context),
        ),
        CommonButton.primary(
          fillWidth: true,
          text: LocaleKeys.renameWord.tr(),
          onPressed: () => _renameAccount(context),
        ),
      ],
    );
  }

  void _renameAccount(BuildContext context) {
    final name = nameController.text.trim();

    if (name.isEmpty) {
      return;
    }
    final account = inject<NekotonRepository>()
        .seedList
        .findAccountByAddress(widget.address);
    account?.rename(name);
    inject<MessengerService>().show(
      Message.successful(
        message: LocaleKeys.valueRenamed.tr(
          args: [LocaleKeys.accountWord.tr()],
        ),
      ),
    );
    Navigator.of(context).pop();
  }
}
