part of 'create_seed_cubit.dart';

@Deprecated('Use v2 version')
@freezed
class CreateSeedCubitState with _$CreateSeedCubitState {
  @Deprecated('Use v2 version')
  const factory CreateSeedCubitState.initial() = _Initial;

  @Deprecated('Use v2 version')
  const factory CreateSeedCubitState.generated({
    required List<String> words,
    required bool isCopied,
  }) = _Generated;
}