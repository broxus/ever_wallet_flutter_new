import 'package:app/generated/generated.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'change_seed_password_state.dart';

part 'change_seed_password_cubit.freezed.dart';

/// Cubit that allows change password of seed
class ChangeSeedPasswordCubit extends Cubit<ChangeSeedPasswordState> {
  ChangeSeedPasswordCubit(
    this.nekotonRepository,
    this.publicKey,
  ) : super(const ChangeSeedPasswordState.initial());

  final String publicKey;
  final NekotonRepository nekotonRepository;

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final seed = nekotonRepository.seedList.findSeed(publicKey);
    if (seed == null) return;

    try {
      await seed.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      emit(const ChangeSeedPasswordState.completed());
    } catch (_) {
      emit(const ChangeSeedPasswordState.error(LocaleKeys.passwordIsWrong));
    }
  }
}