import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class NekotonAddressConverter implements JsonConverter<Address, String> {
  const NekotonAddressConverter();

  @override
  Address fromJson(String json) => Address(address: json);

  @override
  String toJson(Address object) => object.address;
}
