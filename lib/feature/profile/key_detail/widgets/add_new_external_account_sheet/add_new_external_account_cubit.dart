import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

part 'add_new_external_account_state.dart';

part 'add_new_external_account_cubit.freezed.dart';

/// Cubit that allows to add new external account to [publicKey]
class AddNewExternalAccountCubit extends Cubit<AddNewExternalAccountState> {
  AddNewExternalAccountCubit(
    this.publicKey,
    this.nekotonRepository,
  ) : super(const AddNewExternalAccountState.initial());

  /// Public key for which new account will be added
  final String publicKey;
  final NekotonRepository nekotonRepository;

  Future<void> createAccount(String addr, String name) async {
    final seedKey = nekotonRepository.seedList.findSeedKey(publicKey);
    if (seedKey == null) return;

    emit(const AddNewExternalAccountState.loading());
    final newName = name.trim();
    final address = addr.trim();

    try {
      final isCorrect = await validateAddress(address);
      if (!isCorrect) {
        _showError(LocaleKeys.addressIsWrong.tr());
        emit(const AddNewExternalAccountState.initial());

        return;
      }

      await seedKey.accountList.addExternalAccount(
        address: address,
        name: newName.isEmpty ? null : newName,
      );
      emit(const AddNewExternalAccountState.completed());
    } catch (e) {
      _showError(LocaleKeys.keyIsNotCustodian.tr());
      emit(const AddNewExternalAccountState.initial());
    }
  }

  void _showError(String error) {
    inject<MessengerService>().show(Message.error(message: error));
  }
}
