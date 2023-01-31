import 'package:app/di/di.dart';
import 'package:app/feature/counter/counter.dart';
import 'package:bloc/bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
  void getFromNekoton() => emit(inject<NekotonRepository>().getNewModel().id);
  void getFromService() => emit(inject<CounterService>().ultimateAnswer);

  void getFromNekotonRust() =>
      emit(inject<NekotonRepository>().getFromNekotonRust());
}
