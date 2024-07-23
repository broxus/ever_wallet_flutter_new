import 'package:app/app/service/service.dart';
import 'package:app/generated/generated.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:local_auth/local_auth.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'add_seed_enable_biometry_state.dart';

part 'add_seed_enable_biometry_cubit.freezed.dart';

/// Cubit to enable biometry for newly added seed phrase from onboarding.
@Deprecated('Use v2 version')
class AddSeedEnableBiometryCubit extends Cubit<AddSeedEnableBiometryState> {
  AddSeedEnableBiometryCubit(
    this.biometryService,
    this.nekotonRepository,
  ) : super(const AddSeedEnableBiometryState.init());

  final BiometryService biometryService;
  final NekotonRepository nekotonRepository;

  Future<void> init() async {
    final types = await biometryService.getAvailableBiometry();
    emit(
      AddSeedEnableBiometryState.ask(
        isFaceBiometry: types.contains(BiometricType.face),
      ),
    );
  }

  /// This is a fake setting up for a password, we just trying to authenticate
  /// user.
  /// Password for this screen, not needed it was set on screen with creating
  /// password.
  Future<void> requestBiometry() async {
    try {
      await biometryService.setStatus(
        localizedReason: LocaleKeys.biometryAuthReason.tr(),
        isEnabled: true,
      );
    } finally {
      emit(const AddSeedEnableBiometryState.completed());
    }
  }
}
