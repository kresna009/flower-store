import 'package:flower_store/loginTest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('LoginPage widget test', (WidgetTester tester) async {
    await tester.pumpWidget(LoginPage());
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(tester.takeException(), isNull);
  });
}
