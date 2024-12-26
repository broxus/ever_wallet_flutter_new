import 'dart:async';

import 'package:app/app/service/localization/localization.dart';
import 'package:app/core/bloc/bloc_mixin.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

part 'localization_bloc.freezed.dart';

part 'localization_event.dart';

part 'localization_state.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState>
    with BlocBaseMixin {
  LocalizationBloc(this.localizationService)
      : super(
          LocalizationState(
            localeCode: localizationService.localeCode,
          ),
        ) {
    on<_SetLocaleCodeFromService>((event, emit) {
      _log.finest('setting locale from service ${event.code.name}');
      emitSafe(LocalizationState(localeCode: event.code));
    });
    on<_ChangeLocaleCode>((event, emit) {
      _log.finest('change locale to ${event.code.name}');
      localizationService.changeLocaleCode(event.code);
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
