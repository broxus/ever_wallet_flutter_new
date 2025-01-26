// ignore_for_file: use_build_context_synchronously

import 'package:app/app/service/service.dart';
import 'package:app/core/bloc/bloc_mixin.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/new_account/add_account_result/add_account_result_sheet.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

part 'add_new_local_account_type_cubit.freezed.dart';

part 'add_new_local_account_type_state.dart';

/// Cubit for selecting new type of account for creating for [publicKey].
class AddNewLocalAccountTypeCubit extends Cubit<AddNewLocalAccountTypeState>
    with BlocBaseMixin {
  AddNewLocalAccountTypeCubit(
    this.publicKey,
    this.name,
    this.nekotonRepository,
  ) : super(const AddNewLocalAccountTypeState.initial());

  final NekotonRepository nekotonRepository;

  /// Key for which account will be created
  final PublicKey publicKey;

  /// If name is empty, then default will be created
  final String name;

  late List<WalletType> availableAccounts;
  late WalletType defaultAccount;
  late List<WalletType> createdAccounts;
  late SeedKey keyCreateFor;

  /// Current may be null if no accounts can be created
  WalletType? currentSelected;

  void init() {
    final key = nekotonRepository.seedList.findSeedKey(publicKey);
    if (key == null) return;

    keyCreateFor = key;

    availableAccounts = List<WalletType>.from(
      nekotonRepository.currentTransport.availableWalletTypes,
    );
    const account = WalletType.multisig(MultisigType.multisig2);
    if (availableAccounts.contains(account)) {
      //move multisig2 to the end
      availableAccounts
        ..remove(account)
        ..add(account);
    }
    defaultAccount = nekotonRepository.currentTransport.defaultWalletType;

    // remove default as it will be displayed separately
    availableAccounts.remove(defaultAccount);

    createdAccounts = key.createdAccountTypes;

    currentSelected = availableAccounts
        .where((av) => !createdAccounts.contains(av))
        .firstOrNull;

    _emitDataState();
  }

  void changeType(WalletType type) {
    currentSelected = type;
    _emitDataState();
  }

  Future<void> createAccount(BuildContext context) async {
    if (currentSelected == null) return;

    final newName = name.trim();
    try {
      final address = await keyCreateFor.accountList.addAccount(
        walletType: currentSelected!,
        workchain: defaultWorkchainId,
        name: newName.isEmpty ? null : newName,
      );
      await showNewAccountResultSheet(context: context, address: address);
    } on Exception catch (e) {
      inject<MessengerService>()
          .show(Message.error(context: context, message: e.toString()));
    }

    _emitDataState(isCompleted: true);
  }

  void _emitDataState({bool isCompleted = false}) {
    emitSafe(
      AddNewLocalAccountTypeState.data(
        availableAccounts: availableAccounts,
        defaultAccount: defaultAccount,
        createdAccounts: createdAccounts,
        currentSelected: currentSelected,
        isCompleted: isCompleted,
      ),
    );
  }
}
