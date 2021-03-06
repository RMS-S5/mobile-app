import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';

import './main.dart' as app;

void main() {
  group('App test', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets('Full application test', (tester) async {
      app.main();
      await tester.pumpAndSettle(); //wait for all animations and settled
      final loginScreenButton = find.byType(ElevatedButton).first;
      await tester.tap(loginScreenButton);
      await tester.pumpAndSettle();

      // tester.enterText(finder, text);
    });
  });
}
