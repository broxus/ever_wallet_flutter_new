// ignore_for_file: use_build_context_synchronously

import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

part 'add_new_external_account_cubit.freezed.dart';

part 'add_new_external_account_state.dart';

/// Cubit that allows to add new external account to [publicKey]
class AddNewExternalAccountCubit extends Cubit<AddNewExternalAccountState> {
  AddNewExternalAccountCubit(
    this.publicKey,
    this.nekotonRepository,
    this.currentAccountsService,
  ) : super(const AddNewExternalAccountState.initial());

  /// Public key for which new account will be added
  final PublicKey? publicKey;
  final NekotonRepository nekotonRepository;
  final CurrentAccountsService currentAccountsService;

  PublicKey? getPublicKey() {
    return currentAccountsService.currentActiveAccount?.publicKey;
  }

  Future<void> createAccount(
    BuildContext context,
    String addressString,
    String name,
  ) async {
    final publicKey = this.publicKey ?? getPublicKey();
    if (publicKey == null) return;
    final seedKey = nekotonRepository.seedList.findSeedKey(publicKey);
    if (seedKey == null) return;

    emit(const AddNewExternalAccountState.loading());
    final newName = name.trim();
    final address = Address(address: addressString.trim());

    try {
      final isCorrect = await validateAddress(address);
      if (!isCorrect) {
        _showError(context, LocaleKeys.addressIsWrong.tr());
        emit(const AddNewExternalAccountState.initial());

        return;
      }

      await seedKey.accountList.addExternalAccount(
        address: address,
        name: newName.isEmpty ? null : newName,
      );
      emit(const AddNewExternalAccountState.completed());
    } catch (e) {
      _showError(context, LocaleKeys.keyIsNotCustodian.tr());
      emit(const AddNewExternalAccountState.initial());
    }
  }

  void _showError(BuildContext context, String error) {
    inject<MessengerService>()
        .show(Message.error(context: context, message: error));
  }
}
