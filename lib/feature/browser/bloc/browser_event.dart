part of 'browser_bloc.dart';

@freezed
class BrowserEvent with _$BrowserEvent {
  const factory BrowserEvent.addTab({required Uri uri}) = _AddTab;
}
