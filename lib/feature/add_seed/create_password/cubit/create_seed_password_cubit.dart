// ignore_for_file: use_build_context_synchronously

import 'package:app/app/service/network_connection/network_connection_service.dart';
import 'package:app/app/service/service.dart';
import 'package:app/data/models/seed/seed_phrase_model.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/add_seed/create_password/model/password_status.dart';
import 'package:app/utils/mixins/connection_mixin.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

part 'create_seed_password_cubit.freezed.dart';

part 'create_seed_password_state.dart';

const _minPasswordLength = 8;

/// Cubit for creating seed password.
class CreateSeedPasswordCubit extends Cubit<CreateSeedPasswordState>
    with ConnectionMixin {
  CreateSeedPasswordCubit({
    required this.completeCallback,
    required this.seedPhrase,
    required this.type,
    this.setCurrentKey = false,
    this.name,
  }) : super(CreateSeedPasswordState.initial()) {
    passwordController.addListener(_validate);
    confirmController.addListener(_validate);
  }

  /// Callback that calls when seed is created
  final void Function(PublicKey) completeCallback;

  /// Phrase that must be used to create seed
  final SeedPhraseModel seedPhrase;

  /// Name of seed phrase if provided
  final String? name;

  /// If true, then current key will be set as default (provided in onboarding)
  final bool setCurrentKey;
  final SeedAddType type;

  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  final passwordFocus = FocusNode();
  final confirmFocus = FocusNode();

  final formKey = GlobalKey<FormState>();

  @override
  @protected
  final networkConnectionService = inject<NetworkConnectionService>();

  @override
  @protected
  final messengerService = inject<MessengerService>();

  @override
  Future<void> close() {
    passwordController.dispose();
    confirmController.dispose();
    passwordFocus.dispose();
    confirmFocus.dispose();

    return super.close();
  }

  Future<void> nextAction(BuildContext context) async {
    if (seedPhrase.isEmpty || !await checkConnection(context)) {
      return;
    }

    emit(state.copyWith(isLoading: true));
    final nekoton = inject<NekotonRepository>();
    final currentKeyService = inject<CurrentKeyService>();
    try {
      final publicKey = await nekoton.addSeed(
        phrase: seedPhrase.words,
        password: passwordController.text,
        name: name,
        addType: type,
      );
      if (setCurrentKey) {
        currentKeyService.changeCurrentKey(publicKey);
      }
      await inject<BiometryService>().setKeyPassword(
        publicKey: publicKey,
        password: passwordController.text,
      );
      completeCallback(publicKey);
    } catch (e) {
      Logger('CreateSeedPasswordCubit').severe(e);
      emit(state.copyWith(isLoading: false));
      messengerService.show(
        Message.error(
          context: context,
          message: e.toString(),
        ),
      );
    }
  }

  void _validate() {
    if (passwordController.text.length < _minPasswordLength) {
      emit(state.copyWith(status: PasswordStatus.tooWeak));
    } else {
      if (passwordController.text != confirmController.text) {
        emit(state.copyWith(status: PasswordStatus.mustMatch));
      } else {
        emit(state.copyWith(status: PasswordStatus.match));
      }
    }
  }
}
