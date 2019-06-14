import 'package:event_bus/event_bus.dart';

class ClearAllEvent{
  bool flag;
  ClearAllEvent(this.flag);
}

EventBus eventBus = new EventBus();