import 'package:app/di/di.dart';
import 'package:app/feature/counter/counter.dart';
import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);
  final _log = Logger('CounterCubit');

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
  void getFromNekoton() => emit(inject<NekotonRepository>().getNewModel().id);
  void getFromService() => emit(inject<CounterService>().ultimateAnswer);

  void getFromNekotonRust() =>
      emit(inject<NekotonRepository>().getFromNekotonRust());

  void logs() {
    _log
      ..finest('some finest log')
      ..finer('some finer log')
      ..fine('some fine log')
      ..config('some config log')
      ..info('some info log')
      ..warning('some warning log')
      ..severe('some severe log')
      ..shout('some shout log');
  }

  void nekotonLogs() => inject<NekotonRepository>().someLogs();
  void nekotonPanic() => inject<NekotonRepository>().somePanic();
}
