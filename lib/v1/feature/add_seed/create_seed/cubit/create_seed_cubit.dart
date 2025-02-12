import 'package:app/core/bloc/bloc_mixin.dart';
import 'package:app/data/models/seed/seed_phrase_model.dart';
import 'package:app/v1/feature/add_seed/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'create_seed_cubit.freezed.dart';
part 'create_seed_state.dart';

/// Cubit that helps generating seed phrase.
class CreateSeedCubit extends Cubit<CreateSeedCubitState> with BlocBaseMixin {
  CreateSeedCubit() : super(const CreateSeedCubitState.initial());

  void init() {
    final seed = generateKey(accountType: defaultMnemonicType);
    emitSafe(
      CreateSeedCubitState.generated(
        seed: SeedPhraseModel.fromWords(seed.words),
        isCopied: false,
      ),
    );
  }

  Future<void> copySeed() async {
    final st = state;
    if (st is _$GeneratedImpl) {
      emitSafe(st.copyWith(isCopied: true));
      await Clipboard.setData(
        ClipboardData(text: st.seed.phrase),
      );
      Future.delayed(const Duration(seconds: 2), () {
        emitSafe(st.copyWith(isCopied: false));
      });
    }
  }
}
