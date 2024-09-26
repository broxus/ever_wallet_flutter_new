import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

class AppBlocObserver extends BlocObserver {
  final _log = Logger('AppBlocObserver');

  // TODO(nesquikm): Maybe this this is a good point to debug something bad?
  // @override
  // void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
  //   super.onChange(bloc, change);
  //   _log.fine('onChange(${bloc.runtimeType}, $change)');
  // }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    _log.severe('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}
