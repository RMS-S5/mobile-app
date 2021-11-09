import 'package:flutter_test/flutter_test.dart';
import 'package:rms_mobile_app/providers/notifications.dart';

void main() {
  group("Notifications", () {
    final mockNotifications = [
      {
        "id": "359d0cb9-87f6-4e3a-946b-6baa440b4241",
        "title": "Testing Notfication Title",
        "description": "Testing notification description"
      },
      {
        "id": "359d0cb9-87f6-4e3a-946b-6baa440b4453",
        "title": "Testing Notfication Title 2",
        "description": "Testing notification description 2"
      }
    ];
    test('Given notification with notification should return notifications',
        () async {
      // Arrange
      final notificationProvider = Notifications("", mockNotifications);
      // Assert
      expect(notificationProvider.notifications, mockNotifications);
    });

    test(
        'Given notification with notification should return notification count',
        () async {
      // Arrange
      final notificationProvider = Notifications("", mockNotifications);
      // Assert
      expect(notificationProvider.notificationCount, 2);
    });

    test('Should remove notification and update list', () async {
      // Arrange
      final notificationProvider = Notifications("", mockNotifications);
      // Assert

      expect(notificationProvider.notificationCount, 2);
      notificationProvider
          .removeNotification("359d0cb9-87f6-4e3a-946b-6baa440b4241");
      expect(notificationProvider.notificationCount, 1);
    });

    test('Should clear notification list', () async {
      // Arrange
      final notificationProvider = Notifications("", mockNotifications);
      // Assert
      notificationProvider.clearNotifications();
      expect(notificationProvider.notificationCount, 0);
    });
  });
}
