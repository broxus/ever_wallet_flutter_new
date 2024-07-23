import 'package:app/v2/feature/add_seed/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'create_seed_state.dart';

part 'create_seed_cubit.freezed.dart';

/// Cubit that helps generating seed phrase.
class CreateSeedCubit extends Cubit<CreateSeedCubitState> {
  CreateSeedCubit() : super(const CreateSeedCubitState.initial());

  Future<void> init() async {
    final seed = await generateKey(accountType: defaultMnemonicType);
    emit(CreateSeedCubitState.generated(words: seed.words, isCopied: false));
  }

  Future<void> copySeed() async {
    final st = state;
    if (st is _$GeneratedImpl) {
      emit(st.copyWith(isCopied: true));
      await Clipboard.setData(
        ClipboardData(text: st.words.join(' ')),
      );
      Future.delayed(const Duration(seconds: 2), () {
        emit(st.copyWith(isCopied: false));
      });
    }
  }
}
