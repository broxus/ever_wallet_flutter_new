part of 'create_seed_password_cubit.dart';

/// States for <CreateSeedPasswordCubit>
@Deprecated('Use v2 version')
@freezed
class CreateSeedPasswordState with _$CreateSeedPasswordState {
  @Deprecated('Use v2 version')
  const factory CreateSeedPasswordState({
    required bool obscurePassword,
    required bool obscureConfirm,
    required bool isLoading,
  }) = _CreateSeedPasswordState;

  @Deprecated('Use v2 version')
  factory CreateSeedPasswordState.initial() => const CreateSeedPasswordState(
        obscurePassword: true,
        obscureConfirm: true,
        isLoading: false,
      );
}
