import 'dart:async';

import 'package:app/app/service/localization/service/localization_service.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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
        setLocaleCode: (code) {
          localizationService.setLocaleByLanguageCode(code);
        },
      );
    });

    _localeCodeSubscription = localizationService.localeCodeStream
        .listen((event) => add(LocalizationEvent.setLocaleCode(code: event)));
  }

  final LocalizationService localizationService;

  StreamSubscription<SupportedLocaleCodes>? _localeCodeSubscription;

  @override
  Future<void> close() {
    _localeCodeSubscription?.cancel();
    _localeCodeSubscription = null;

    return super.close();
  }
}
