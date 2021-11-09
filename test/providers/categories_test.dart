import 'package:flutter_test/flutter_test.dart';
import 'package:rms_mobile_app/providers/categories.dart';

void main() {
  group("Categories", () {
    test('without fetch should return empty categories', () async {
      // Arrange
      final categoriesProvider = Categories();
      // Assert
      expect(categoriesProvider.categories, []);
    });
  });
}
