import 'package:freezed_annotation/freezed_annotation.dart';

part 'transport_native_token_option.freezed.dart';

@freezed
sealed class TransportNativeTokenTickerOption
    with _$TransportNativeTokenTickerOption {
  const factory TransportNativeTokenTickerOption.fromConnection() =
      _TransportNativeTokenTickerOptionFromConnection;

  const factory TransportNativeTokenTickerOption.byName(String name) =
      _TransportNativeTokenTickerOptionByName;
}
