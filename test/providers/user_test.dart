import 'package:flutter_test/flutter_test.dart';
import 'package:rms_mobile_app/providers/user.dart';

void main() {
  group("User", () {
    test('Without login should return false to isAuth', () async {
      // Arrange
      final userProvider = User();
      // Assert
      expect(userProvider.isAuth(), false);
    });

    test('Without login should return empty user data', () async {
      // Arrange
      final userProvider = User();
      // Assert
      expect(userProvider.userData, {});
    });

    test('Without login should return empty token', () async {
      // Arrange
      final userProvider = User();
      // Assert
      expect(userProvider.token, null);
    });

    test('Without login should return null account type', () async {
      // Arrange
      final userProvider = User();
      // Assert
      expect(userProvider.accountType, null);
    });
  });
}
