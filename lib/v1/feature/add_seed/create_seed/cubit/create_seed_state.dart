part of 'create_seed_cubit.dart';

@freezed
class CreateSeedCubitState with _$CreateSeedCubitState {
  const factory CreateSeedCubitState.initial() = _Initial;

  const factory CreateSeedCubitState.generated({
    required SeedPhraseModel seed,
    required bool isCopied,
  }) = _Generated;
}
