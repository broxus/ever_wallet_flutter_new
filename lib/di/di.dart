import 'package:get_it/get_it.dart';
export 'modules.dart';

abstract class Di {
  const Di();

  Future<void> register(GetIt serviceLocator);
}

T inject<T extends Object>({
  String? instanceName,
}) =>
    GetIt.I.get<T>(
      instanceName: instanceName,
    );
