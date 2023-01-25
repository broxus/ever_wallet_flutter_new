import 'package:app/di/di.dart';
import 'package:app/feature/counter/counter.dart';
import 'package:get_it/get_it.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class CounterDi extends Di {
  @override
  Future<void> register(GetIt serviceLocator) async {
    serviceLocator
      ..registerLazySingleton(NekotonRepository.new)
      ..registerLazySingleton(CounterService.new);
  }
}
