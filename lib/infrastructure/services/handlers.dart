import 'package:event_bus/event_bus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sculpt/constants/enums.dart';
import 'package:sculpt/infrastructure/event_manager/bus.dart';
import 'package:sculpt/infrastructure/event_manager/evnets.dart';

@pragma('vm:entry-point')
void onDidReceiveNotificationResponse(NotificationResponse details) {
  print(details);
}

@pragma('vm:entry-point')
void onDidReceiveBackgroundNotificationResponse(NotificationResponse details) {
  final actionid = details.actionId;
  if (actionid == null) {
    _handleTap(details);
    return;
  }

  _handleAction(actionid);
}

@pragma('vm:entry-point')
_handleAction(String actionId) {
  if (actionId == NotificationAction.stop.name) {
    Buss().eventBus.fire(StopEvent());
  }
}

@pragma('vm:entry-point')
_handleTap(NotificationResponse details) {}
