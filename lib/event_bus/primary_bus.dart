import 'package:event_bus/event_bus.dart';
import 'package:rxdart/rxdart.dart';

final primaryBus = EventBus();
final behaviorBus = EventBus.customController(BehaviorSubject());
