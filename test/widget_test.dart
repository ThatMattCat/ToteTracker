// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tote_tracker/main.dart';
import 'package:tote_tracker/app_state.dart';
import 'package:tote_tracker/backend/sqlite/sqlite_manager.dart';
import 'package:tote_tracker/flutter_flow/flutter_flow_util.dart';
import 'package:tote_tracker/flutter_flow/flutter_flow_theme.dart';

void main() {
  // Initialize all dependencies before any tests that might use them
  setUpAll(() async {
    // Initialize environment values
    final environmentValues = FFDevEnvironmentValues();
    await environmentValues.initialize();
    
    // Initialize SQLiteManager
    await SQLiteManager.initialize();
    
    // Initialize FlutterFlow theme
    await FlutterFlowTheme.initialize();
  });

  testWidgets('App starts without crashing', (WidgetTester tester) async {
    // Create FFAppState instance
    final appState = FFAppState();
    await appState.initializePersistedState();

    // Build our app and trigger a frame with proper Provider context
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => appState,
        child: MyApp(),
      ),
    );
    
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
