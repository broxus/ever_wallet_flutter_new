import 'package:freezed_annotation/freezed_annotation.dart';

part 'transport_manifest_option.freezed.dart';

@freezed
class TransportManifestOption with _$TransportManifestOption {
  const factory TransportManifestOption.fromConnection() =
      _TransportManifestOptionFromConnection;
}
