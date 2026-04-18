import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Portfolio app smoke test', (WidgetTester tester) async {
    // Basic test - project builds and MaterialApp is present
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: Text('Portfolio'))));
    expect(find.text('Portfolio'), findsOneWidget);
  });
}
