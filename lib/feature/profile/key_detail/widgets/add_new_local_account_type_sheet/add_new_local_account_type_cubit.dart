import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'add_new_local_account_type_state.dart';

part 'add_new_local_account_type_cubit.freezed.dart';

/// Cubit for selecting new type of account for creating for [publicKey].
class AddNewLocalAccountTypeCubit extends Cubit<AddNewLocalAccountTypeState> {
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

  Future<void> createAccount() async {
    if (currentSelected == null) return;

    final newName = name.trim();
    await keyCreateFor.accountList.addAccount(
      walletType: currentSelected!,
      workchain: defaultWorkchainId,
      name: newName.isEmpty ? null : newName,
    );

    _emitDataState(isCompleted: true);
  }

  void _emitDataState({bool isCompleted = false}) {
    emit(
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
