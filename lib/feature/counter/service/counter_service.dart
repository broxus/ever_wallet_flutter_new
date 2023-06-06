import 'package:injectable/injectable.dart';

@singleton
class CounterService {
  // ignore: no-magic-number
  int get ultimateAnswer => 42;
}
