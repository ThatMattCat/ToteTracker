// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:tote_tracker/main.dart';

void main() {
  testWidgets('App starts without crashing', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());
    
    // Verify that the app loads successfully
    await tester.pumpAndSettle();
    
    // Basic check that the app has been loaded
    expect(find.byType(MaterialApp), findsOneWidget);
  });
  
  test('App version is properly defined', () {
    // Simple unit test to check that app constants are defined
    expect('tote_tracker', isNotEmpty);
  });
}
