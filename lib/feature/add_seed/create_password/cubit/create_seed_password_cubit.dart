import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_seed_password_state.dart';

part 'create_seed_password_cubit.freezed.dart';

/// Cubit for creating seed password.
class CreateSeedPasswordCubit extends Cubit<CreateSeedPasswordState> {
  CreateSeedPasswordCubit({
    required this.phrase,
    required this.completeCallback,
    this.setCurrentKey = false,
    this.name,
  }) : super(const CreateSeedPasswordState());

  /// Callback that calls when seed is created
  final VoidCallback completeCallback;

  /// Phrase that must be used to create seed
  final List<String> phrase;

  /// Name of seed phrase if provided
  final String? name;

  /// If true, then current key will be set as default (provided in onboarding)
  final bool setCurrentKey;

  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  final passwordFocus = FocusNode();
  final confirmFocus = FocusNode();

  final formKey = GlobalKey<FormState>();

  @override
  Future<void> close() {
    passwordController.dispose();
    confirmController.dispose();
    passwordFocus.dispose();
    confirmFocus.dispose();

    return super.close();
  }

  Future<void> nextAction() async {
    if (formKey.currentState?.validate() ?? false) {
      // TODO(alex-a4): add transport checking
      // final keyRepo = context.read<KeysRepository>();
      // final accountsRepo = context.read<AccountsRepository>();
      // final key = await keyRepo.createKey(
      //   phrase: widget.phrase,
      //   password: passwordController.text,
      //   name: widget.name,
      // );
      // // make key visible for subscribers
      // if (widget.setCurrentKey) await keyRepo.setCurrentKey(key.publicKey);
      //
      // final overlay = DefaultDialogController.showFullScreenLoader();
      //
      // /// Waits for founding any accounts. If no accounts found - start creating a new one
      // late StreamSubscription sub;
      // sub = accountsRepo
      //     .accountsForStream(key.publicKey)
      //     .where((event) => event.isNotEmpty)
      //     .timeout(const Duration(seconds: 1), onTimeout: (c) => c.close())
      //     .listen(
      //   (accounts) {
      //     overlay.dismiss(animate: false);
      //     widget.callback(context);
      //     sub.cancel();
      //   },
      //   onDone: () async {
      //     await context.read<AccountsRepository>().addAccount(
      //           publicKey: key.publicKey,
      //           walletType: getDefaultWalletType(isEver),
      //           workchain: kDefaultWorkchain,
      //         );
      //     overlay.dismiss(animate: false);
      //     if (mounted) {
      //       widget.callback(context);
      //     }
      //     sub.cancel();
      //   },
      // );
    }
  }
}
