import 'dart:math';

import 'package:nekoton_repository/nekoton_repository.dart';

/// {@template nekoton_repository}
/// Nekoton repository package
/// {@endtemplate}
class NekotonRepository {
  /// {@macro nekoton_repository}
  const NekotonRepository();

  /// Create a new example thing
  ExampleModel getNewModel() => ExampleModel(id: Random().nextInt(1 << 16));
}
