import 'dart:async';

import 'package:app/app/service/localization/localization.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

part 'localization_event.dart';
part 'localization_state.dart';
part 'localization_bloc.freezed.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  LocalizationBloc(this.localizationService)
      : super(
          LocalizationState(
            localeCode: localizationService.localeCode,
          ),
        ) {
    on<LocalizationEvent>((event, emit) {
      event.when(
        setLocaleCodeFromService: (code) {
          _log.finest('setting locale from service ${code.name}');
          emit(LocalizationState(localeCode: code));
        },
        changeLocaleCode: (SupportedLocaleCodes code) {
          _log.finest('change locale to ${code.name}');
          localizationService.changeLocaleCode(code);
        },
      );
    });

    _localeCodeSubscription = localizationService.localeCodeStream.listen(
      (code) {
        _log.finest('received new locale from service ${code.name}');
        add(LocalizationEvent.setLocaleCodeFromService(code: code));
      },
    );
  }
  final _log = Logger('LocalizationBloc');

  final LocalizationService localizationService;

  StreamSubscription<SupportedLocaleCodes>? _localeCodeSubscription;

  @override
  Future<void> close() {
    _localeCodeSubscription?.cancel();
    _localeCodeSubscription = null;

    return super.close();
  }
}
