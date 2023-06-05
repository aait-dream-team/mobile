import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';

class LocalNotificationDataProvider {
  static Future<bool> instantNotify(
      {required String title, required String body}) async {
    if (!await AwesomeNotifications().isNotificationAllowed()) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }

    final AwesomeNotifications awesomeNotifications = AwesomeNotifications();
    return await awesomeNotifications.createNotification(
      content: NotificationContent(
        id: Random().nextInt(100),
        channelKey: 'basic',
        title: title,
        body: body,
      ),
    );
  }
}
