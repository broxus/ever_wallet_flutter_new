import 'dart:math';

import 'package:flutter_nekoton_bridge/flutter_nekoton_bridge.dart'
    as flutter_nekoton_bridge;
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// {@template nekoton_repository}
/// Nekoton repository package
/// {@endtemplate}
@singleton
class NekotonRepository {
  /// {@macro nekoton_repository}
  const NekotonRepository();

  /// Create a new example thing
  ExampleModel getNewModel() => ExampleModel(id: Random().nextInt(1 << 16));

  /// Call something from nekoton
  int getFromNekotonRust() => flutter_nekoton_bridge.simpleAdderSync(1, 2);
}
