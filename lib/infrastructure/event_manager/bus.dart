import 'package:event_bus/event_bus.dart';

@pragma('vm:entry-point')
class Buss {
  static Buss? _instance;

  EventBus eventBus = EventBus();

  Buss._();
  factory Buss() {
    _instance ??= Buss._();

    return _instance!;
  }
}
