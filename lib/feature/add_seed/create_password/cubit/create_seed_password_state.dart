part of 'create_seed_password_cubit.dart';

/// States for <CreateSeedPasswordCubit>
@freezed
class CreateSeedPasswordState with _$CreateSeedPasswordState {
  const factory CreateSeedPasswordState({
    required bool isLoading,
    required PasswordStatus status,
  }) = _CreateSeedPasswordState;

  factory CreateSeedPasswordState.initial() => const CreateSeedPasswordState(
        isLoading: false,
        status: PasswordStatus.initial,
      );
}
