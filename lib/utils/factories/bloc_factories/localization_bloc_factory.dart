import 'package:app/app/service/localization/service/localization_service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/localization/bloc/localization_bloc.dart';
import 'package:flutter/cupertino.dart';

LocalizationBloc localizationBlocFactory(BuildContext context) =>
    LocalizationBloc(inject<LocalizationService>());
