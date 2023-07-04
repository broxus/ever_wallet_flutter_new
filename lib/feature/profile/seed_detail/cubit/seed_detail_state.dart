part of 'seed_detail_cubit.dart';

@freezed
class SeedDetailState with _$SeedDetailState {
  const factory SeedDetailState.initial() = _Initial;

  /// Seed found, we can show it
  const factory SeedDetailState.data({
    required Seed seed,
    required bool isCurrentSeed,
    required PublicKey? currentPublicKey,
  }) = _Data;

  /// No seed found, we need close screen
  const factory SeedDetailState.empty() = _Empty;
}
