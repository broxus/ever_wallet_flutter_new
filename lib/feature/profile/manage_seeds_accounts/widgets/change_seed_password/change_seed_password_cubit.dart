import 'package:app/app/service/service.dart';
import 'package:app/core/bloc/bloc_mixin.dart';
import 'package:app/generated/generated.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'change_seed_password_cubit.freezed.dart';
part 'change_seed_password_state.dart';

/// Cubit that allows change password of seed
class ChangeSeedPasswordCubit extends Cubit<ChangeSeedPasswordState>
    with BlocBaseMixin {
  ChangeSeedPasswordCubit(
    this.nekotonRepository,
    this.publicKey,
    this.biometryService,
  ) : super(const ChangeSeedPasswordState.initial());

  final PublicKey publicKey;
  final NekotonRepository nekotonRepository;
  final BiometryService biometryService;

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

      await biometryService.updatePasswordIfPossible(
        publicKey: publicKey,
        newPassword: newPassword,
      );
      emitSafe(const ChangeSeedPasswordState.completed());
    } catch (_) {
      emitSafe(const ChangeSeedPasswordState.error(LocaleKeys.passwordIsWrong));
    }
  }
}
