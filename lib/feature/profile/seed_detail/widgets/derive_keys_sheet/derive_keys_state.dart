part of 'derive_keys_cubit.dart';

@freezed
class DeriveKeysState with _$DeriveKeysState {
  const factory DeriveKeysState.initial() = _Initial;

  /// [displayDerivedKeys] contains small list of keys, that should be displayed
  /// on single page.
  ///
  /// if [isLoading] = true, then state when button should display loading
  /// indicator.
  /// prev and next page buttons should be disabled.
  /// if [isCompleted] = true, then sheet must be closed.
  const factory DeriveKeysState.data({
    required bool canPrevPage,
    required bool canNextPage,
    required int currentPageIndex,
    required int pageCount,
    required List<PublicKey> displayDerivedKeys,
    required List<PublicKey> selectedKeys,
    required Map<PublicKey, String> keyNames,
    required bool isLoading,
    required bool isCompleted,
  }) = _Data;
}
