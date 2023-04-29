import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'account_removed_event.freezed.dart';

@freezed
class AccountRemovedEvent with _$AccountRemovedEvent {
  const factory AccountRemovedEvent(AssetsList account) = _AccountRemovedEvent;
}
