import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'key_removed_event.freezed.dart';

@freezed
class KeyRemovedEvent with _$KeyRemovedEvent {
  const factory KeyRemovedEvent(KeyStoreEntry key) = _KeyRemovedEvent;
}
