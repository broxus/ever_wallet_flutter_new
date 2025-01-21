import 'package:app/feature/wallet/new_account/new_account_type/new_account_type_widget.dart';
import 'package:app/feature/wallet/new_account/screen/new_account_screen_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class NewAccountScreen extends ElementaryWidget<NewAccountScreenWidgetModel> {
  const NewAccountScreen({
    this.publicKey,
    this.password,
    super.key,
    WidgetModelFactory<NewAccountScreenWidgetModel> wmFactory =
        defaultNewAccountScreenWidgetModelFactory,
  }) : super(
          wmFactory,
        );

  final String? publicKey;
  final String? password;

  @override
  Widget build(NewAccountScreenWidgetModel wm) {
    return Scaffold(
      appBar: DefaultAppBar(
        titleText: LocaleKeys.newAccount.tr(),
      ),
      body: wm.isError
          ? const SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.all(DimensSizeV2.d16),
              child: NewAccountTypeWidget(
                publicKey: PublicKey(publicKey: publicKey!),
                password: password!,
              ),
            ),
    );
  }
}
