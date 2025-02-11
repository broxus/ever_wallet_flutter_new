import 'package:app/app/service/messenger/service/messenger_service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/new_account/add_account.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

// TODO(knightforce): Use Elementary
class NewAccountPage extends StatefulWidget {
  const NewAccountPage({
    required this.publicKey,
    required this.password,
    super.key,
  });

  final String? publicKey;
  final String? password;

  @override
  State<NewAccountPage> createState() => _NewAccountPageState();
}

class _NewAccountPageState extends State<NewAccountPage> {
  late final _messageService = inject<MessengerService>();

  bool get _isError => widget.publicKey == null;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        titleText: LocaleKeys.newAccount.tr(),
      ),
      body: _isError
          ? const SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.all(DimensSizeV2.d16),
              child: NewAccountTypeWidget(
                publicKey: PublicKey(publicKey: widget.publicKey!),
                password: widget.password,
              ),
            ),
    );
  }

  void _init() {
    if (!_isError) {
      return;
    }

    // TODO(knightforce): Use localization
    _messageService.showError(
      context,
      ''
              '${widget.publicKey == null ? 'publicKey is null' : ''}'
              ''
          .trim(),
    );
  }
}
