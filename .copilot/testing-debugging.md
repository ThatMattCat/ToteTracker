# Testing & Debugging Patterns

This file provides GitHub Copilot with specific context about testing strategies, debugging approaches, and quality assurance practices for ToteTracker development across different framework approaches.

## Testing Architecture

### Test Structure
```
test/
├── widget_test.dart           # Basic widget tests
├── unit/                      # Unit tests for business logic
│   ├── services/             # Service layer tests
│   ├── models/               # Data model tests
│   └── utils/                # Utility function tests
├── integration/               # Integration tests for workflows
│   ├── database/             # Database integration tests
│   ├── ai/                   # AI integration tests
│   └── ui/                   # UI workflow tests
├── mocks/                     # Mock implementations
└── helpers/                   # Test utility functions
```

### Analysis Configuration (Framework-Agnostic)
```yaml
# analysis_options.yaml
analyzer:
  exclude:
    - lib/custom_code/**         # Exclude FlutterFlow custom code
    - lib/flutter_flow/**        # Exclude FlutterFlow generated code
    - build/**                   # Exclude build artifacts
    - web/**                     # Exclude web build files
    - .dart_tool/**             # Exclude Dart tools

linter:
  rules:
    # Add rules that work with any framework approach
    prefer_const_constructors: true
    prefer_const_literals_to_create_immutables: true
    avoid_unnecessary_containers: true
    use_build_context_synchronously: false
```

## Unit Testing Patterns

### Framework-Agnostic Service Testing
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:tote_tracker/core/services/ai_service.dart';
import 'package:tote_tracker/core/services/database_service.dart';

// Generate mocks
@GenerateMocks([AIAnalysisService, DatabaseService])
import 'service_test.mocks.dart';

void main() {
  group('AI Analysis Service', () {
    late MockAIAnalysisService mockAIService;
    
    setUp(() {
      mockAIService = MockAIAnalysisService();
    });

    test('should parse valid JSON response', () {
      // Arrange
      const responseText = '{"name": "Coffee Mug", "category": "Kitchen"}';
      
      // Act
      final result = AIAnalysisService.parseAIResponse(responseText);
      
      // Assert
      expect(result.name, equals('Coffee Mug'));
      expect(result.category, equals('Kitchen'));
    });

    test('should handle malformed JSON gracefully', () {
      // Arrange
      const invalidJson = '{"name": "Coffee Mug", "category":}';
      
      // Act
      final result = AIAnalysisService.parseAIResponse(invalidJson);
      
      // Assert
      expect(result.name, isNotEmpty);
      expect(result.category, equals('Uncategorized'));
    });
  });
}
```

### Database Operations Testing
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:tote_tracker/backend/sqlite/sqlite_manager.dart';
import 'package:tote_tracker/backend/schema/structs/index.dart';

void main() {
  group('Database Operations', () {
    late Database testDb;
    
    setUpAll(() async {
      // Initialize FFI for testing
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    });
    
    setUp(() async {
      // Create in-memory test database
      testDb = await openDatabase(
        inMemoryDatabasePath,
        version: 1,
        onCreate: (db, version) async {
          // Create test tables
          await db.execute('''
            CREATE TABLE Containers (
              containerId TEXT PRIMARY KEY,
              name TEXT NOT NULL,
              description TEXT,
              createdAt INTEGER
            )
          ''');
          
          await db.execute('''
            CREATE TABLE Items (
              itemId INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT NOT NULL,
              containerId TEXT,
              category TEXT,
              FOREIGN KEY (containerId) REFERENCES Containers (containerId)
            )
          ''');
        },
      );
    });

    tearDown(() async {
      await testDb.close();
    });

    test('should insert and retrieve container', () async {
      // Arrange
      final container = ContainerStruct(
        containerId: 'test-container-1',
        name: 'Test Container',
        description: 'A test container',
      );

      // Act
      await testDb.insert('Containers', container.toMap());
      final results = await testDb.query('Containers', 
        where: 'containerId = ?', 
        whereArgs: [container.containerId]
      );

      // Assert
      expect(results.length, equals(1));
      expect(results.first['name'], equals('Test Container'));
    });

    test('should maintain referential integrity', () async {
      // Test foreign key constraints
      final container = ContainerStruct(
        containerId: 'container-1',
        name: 'Parent Container',
      );
      
      final item = ItemStruct(
        name: 'Test Item',
        containerId: 'container-1',
        category: 'Test Category',
      );

      // Insert container first
      await testDb.insert('Containers', container.toMap());
      
      // Insert item with valid foreign key
      await testDb.insert('Items', item.toMap());
      
      // Verify relationship
      final itemResults = await testDb.query('Items',
        where: 'containerId = ?',
        whereArgs: ['container-1']
      );
      
      expect(itemResults.length, equals(1));
      expect(itemResults.first['name'], equals('Test Item'));
    });
  });
}
```

### Widget Testing Patterns

#### FlutterFlow Widget Testing
```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tote_tracker/custom_code/widgets/base64_image.dart';

void main() {
  group('FlutterFlow Custom Widgets', () {
    testWidgets('Base64Image widget should display placeholder for null data', 
      (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Base64Image(
              width: 100,
              height: 100,
              base64: null,
            ),
          ),
        ),
      );

      // Act
      await tester.pump();

      // Assert
      expect(find.byIcon(Icons.image_not_supported), findsOneWidget);
    });

    testWidgets('Database operation widget should show loading state', 
      (WidgetTester tester) async {
      // Test async operations and loading states
      bool callbackCalled = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DatabaseOperationWidget(
              onSuccess: () async {
                callbackCalled = true;
              },
            ),
          ),
        ),
      );

      // Tap the button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Verify loading indicator appears
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
```

#### Standard Flutter Widget Testing
```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:tote_tracker/core/widgets/base64_image_display.dart';
import 'package:tote_tracker/core/providers/app_state.dart';

void main() {
  group('Standard Flutter Widgets', () {
    testWidgets('Base64ImageDisplay should handle error gracefully', 
      (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Base64ImageDisplay(
              width: 100,
              height: 100,
              base64String: 'invalid-base64',
            ),
          ),
        ),
      );

      await tester.pump();
      expect(find.byIcon(Icons.broken_image), findsOneWidget);
    });

    testWidgets('Widget should respond to provider state changes', 
      (WidgetTester tester) async {
      final appState = AppState();
      
      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: appState,
          child: MaterialApp(
            home: Scaffold(
              body: Consumer<AppState>(
                builder: (context, state, child) {
                  return Text(state.selectedContainer ?? 'No container');
                },
              ),
            ),
          ),
        ),
      );

      // Initial state
      expect(find.text('No container'), findsOneWidget);

      // Update state
      appState.setSelectedContainer('container-1');
      await tester.pump();

      // Verify UI updates
      expect(find.text('container-1'), findsOneWidget);
      expect(find.text('No container'), findsNothing);
    });
  });
}
```
              userId TEXT
            )
          ''');
          
          await db.execute('''
            CREATE TABLE Items (
              itemId INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT NOT NULL,
              containerId TEXT,
              FOREIGN KEY (containerId) REFERENCES Containers (containerId)
            )
          ''');
        },
      );
    });

    tearDown(() async {
      await testDb.close();
    });

    test('should insert and retrieve container', () async {
      // Arrange
      final containerId = 'test-container-1';
      final containerName = 'Test Container';
      
      // Act
      await testDb.insert('Containers', {
        'containerId': containerId,
        'name': containerName,
        'userId': 'test-user',
      });
      
      final result = await testDb.query(
        'Containers',
        where: 'containerId = ?',
        whereArgs: [containerId],
      );
      
      // Assert
      expect(result.length, 1);
      expect(result.first['name'], containerName);
    });

    test('should handle foreign key relationships', () async {
      // Test container-item relationships
      await testDb.insert('Containers', {
        'containerId': 'container-1',
        'name': 'Container 1',
        'userId': 'user-1',
      });
      
      await testDb.insert('Items', {
        'name': 'Test Item',
        'containerId': 'container-1',
      });
      
      final items = await testDb.rawQuery('''
        SELECT i.name, c.name as containerName
        FROM Items i
        JOIN Containers c ON i.containerId = c.containerId
        WHERE c.containerId = ?
      ''', ['container-1']);
      
      expect(items.length, 1);
      expect(items.first['containerName'], 'Container 1');
    });
  });
}
```

### AI Integration Testing
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tote_tracker/flutter_flow/custom_functions.dart';

void main() {
  group('AI Response Parsing', () {
    test('should parse valid JSON response', () {
      // Arrange
      const validResponse = '''
        Some text before
        {"name": "Red Coffee Mug", "category": "Kitchen & Dining"}
        Some text after
      ''';
      
      // Act
      final result = aiImageResponseToNameCategory(validResponse);
      
      // Assert
      expect(result, isNotNull);
      expect(result!.name, 'Red Coffee Mug');
      expect(result.category, 'Kitchen & Dining');
    });

    test('should handle malformed JSON gracefully', () {
      // Arrange
      const malformedResponse = 'This is not JSON at all';
      
      // Act
      final result = aiImageResponseToNameCategory(malformedResponse);
      
      // Assert
      expect(result, isNotNull);
      expect(result!.name, 'Parsing Error');
      expect(result.category, contains('Invalid AI response format'));
    });

    test('should handle incomplete JSON', () {
      // Arrange
      const incompleteResponse = '{"name": "Item", "categ';
      
      // Act
      final result = aiImageResponseToNameCategory(incompleteResponse);
      
      // Assert
      expect(result, isNotNull);
      expect(result!.name, 'Parsing Error');
      expect(result.category, contains('Failed to decode JSON'));
    });
  });
}
```

### Custom Widget Testing
```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tote_tracker/custom_code/widgets/base64_image.dart';

void main() {
  group('Base64Image Widget', () {
    testWidgets('displays image when valid base64 provided', (tester) async {
      // Arrange - Create a simple 1x1 pixel PNG in base64
      const validBase64 = 'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChAGA2wlNegAAAABJRU5ErkJggg==';
      
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Base64Image(
              base64: validBase64,
              width: 100,
              height: 100,
            ),
          ),
        ),
      );
      
      // Assert
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('displays placeholder when invalid base64 provided', (tester) async {
      // Arrange
      const invalidBase64 = 'invalid-base64-string';
      
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Base64Image(
              base64: invalidBase64,
              width: 100,
              height: 100,
            ),
          ),
        ),
      );
      
      // Assert
      expect(find.byIcon(Icons.broken_image), findsOneWidget);
    });

    testWidgets('displays placeholder when null base64 provided', (tester) async {
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Base64Image(
              base64: null,
              width: 100,
              height: 100,
            ),
          ),
        ),
      );
      
      // Assert
      expect(find.byIcon(Icons.image_not_supported), findsOneWidget);
    });
  });
}
```

## Integration Testing Patterns

### End-to-End Flow Testing
```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tote_tracker/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Item Management Flow', () {
    testWidgets('complete item creation flow', (tester) async {
      // Initialize app
      app.main();
      await tester.pumpAndSettle();

      // Navigate to add item page
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Fill in item details
      await tester.enterText(find.byKey(Key('item_name_field')), 'Test Item');
      await tester.enterText(find.byKey(Key('item_category_field')), 'Test Category');
      
      // Submit form
      await tester.tap(find.byKey(Key('save_item_button')));
      await tester.pumpAndSettle();

      // Verify item was created
      expect(find.text('Test Item'), findsOneWidget);
    });

    testWidgets('container selection flow', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to containers
      await tester.tap(find.byIcon(Icons.inbox));
      await tester.pumpAndSettle();

      // Select a container
      await tester.tap(find.byKey(Key('container_card_0')));
      await tester.pumpAndSettle();

      // Verify container contents are displayed
      expect(find.byKey(Key('container_contents')), findsOneWidget);
    });
  });
}
```

### Database Migration Testing
```dart
void main() {
  group('Database Migration', () {
    test('migrates from version 1 to 2', () async {
      // Create v1 database
      final v1Db = await openDatabase(
        'test_migration.db',
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE Items (
              itemId INTEGER PRIMARY KEY,
              name TEXT,
              containerId TEXT
            )
          ''');
        },
      );

      // Insert test data
      await v1Db.insert('Items', {
        'name': 'Test Item',
        'containerId': 'container-1',
      });

      await v1Db.close();

      // Open with migration to v2
      final v2Db = await openDatabase(
        'test_migration.db',
        version: 2,
        onUpgrade: (db, oldVersion, newVersion) async {
          if (oldVersion < 2) {
            await db.execute('ALTER TABLE Items ADD COLUMN category TEXT');
          }
        },
      );

      // Verify migration worked
      final tableInfo = await v2Db.rawQuery('PRAGMA table_info(Items)');
      final hasCategory = tableInfo.any((column) => column['name'] == 'category');
      
      expect(hasCategory, isTrue);
      await v2Db.close();
    });
  });
}
```

## Debugging Patterns

### Debug Logging
```dart
class DebugLogger {
  static const bool _debugMode = true; // Set to false for release
  
  static void log(String message, [String? tag]) {
    if (_debugMode) {
      final timestamp = DateTime.now().toIso8601String();
      final logTag = tag ?? 'ToteTracker';
      print('[$timestamp] [$logTag] $message');
    }
  }
  
  static void logError(String message, dynamic error, [StackTrace? stackTrace]) {
    if (_debugMode) {
      final timestamp = DateTime.now().toIso8601String();
      print('[$timestamp] [ERROR] $message');
      print('Error: $error');
      if (stackTrace != null) {
        print('Stack trace: $stackTrace');
      }
    }
  }
  
  static void logDatabaseOperation(String operation, Map<String, dynamic>? params) {
    if (_debugMode) {
      log('Database $operation${params != null ? ' with params: $params' : ''}', 'DB');
    }
  }
  
  static void logAIOperation(String operation, String? prompt, String? response) {
    if (_debugMode) {
      log('AI $operation', 'AI');
      if (prompt != null) log('Prompt: $prompt', 'AI');
      if (response != null) log('Response: ${response.substring(0, 100)}...', 'AI');
    }
  }
}
```

### Performance Monitoring
```dart
class PerformanceMonitor {
  static final Map<String, DateTime> _startTimes = {};
  
  static void startTimer(String operation) {
    _startTimes[operation] = DateTime.now();
    DebugLogger.log('Started: $operation', 'PERF');
  }
  
  static void endTimer(String operation) {
    final startTime = _startTimes[operation];
    if (startTime != null) {
      final duration = DateTime.now().difference(startTime);
      DebugLogger.log('Completed: $operation in ${duration.inMilliseconds}ms', 'PERF');
      _startTimes.remove(operation);
    }
  }
  
  static T measureOperation<T>(String operation, T Function() function) {
    startTimer(operation);
    try {
      final result = function();
      endTimer(operation);
      return result;
    } catch (e) {
      endTimer(operation);
      rethrow;
    }
  }
  
  static Future<T> measureAsyncOperation<T>(String operation, Future<T> Function() function) async {
    startTimer(operation);
    try {
      final result = await function();
      endTimer(operation);
      return result;
    } catch (e) {
      endTimer(operation);
      rethrow;
    }
  }
}
```

### Error Boundary Pattern
```dart
class ErrorBoundary extends StatefulWidget {
  final Widget child;
  final Widget Function(String error)? errorBuilder;
  
  const ErrorBoundary({
    Key? key,
    required this.child,
    this.errorBuilder,
  }) : super(key: key);

  @override
  _ErrorBoundaryState createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  String? _error;

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return widget.errorBuilder?.call(_error!) ?? 
        _buildDefaultErrorWidget(_error!);
    }

    return widget.child;
  }

  Widget _buildDefaultErrorWidget(String error) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, size: 48, color: Colors.red),
          SizedBox(height: 16),
          Text('Something went wrong', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text(error, textAlign: TextAlign.center),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => setState(() => _error = null),
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }

  void handleError(String error) {
    setState(() => _error = error);
    DebugLogger.logError('Error boundary caught error', error);
  }
}
```

## Manual Testing Strategies

### Device Testing Checklist
```dart
/// Manual testing checklist for ToteTracker
/// 
/// Core Functionality:
/// ✓ Container creation and QR code scanning
/// ✓ Item addition with camera capture
/// ✓ AI analysis (with valid API key)
/// ✓ Manual item entry (fallback)
/// ✓ Search functionality across items
/// ✓ Database backup and restore
/// 
/// Edge Cases:
/// ✓ Network disconnection during AI analysis
/// ✓ Camera permission denied
/// ✓ Storage permission denied
/// ✓ Large image file handling
/// ✓ Database corruption recovery
/// ✓ Low storage space scenarios
/// 
/// Performance:
/// ✓ App startup time
/// ✓ Large dataset handling (100+ containers, 1000+ items)
/// ✓ Image loading performance
/// ✓ Search response time
/// ✓ Database operation speed
/// 
/// UI/UX:
/// ✓ Dark/light theme switching
/// ✓ Accessibility features
/// ✓ Different screen sizes
/// ✓ Orientation changes
/// ✓ Back button behavior
```

### Debugging Tools Integration
```dart
class DevToolsHelper {
  static void enableFlutterInspector() {
    // Enable debugging tools in debug mode
    assert(() {
      // Flutter Inspector
      debugPaintSizeEnabled = false; // Set to true to see widget boundaries
      debugRepaintRainbowEnabled = false; // Set to true to see repaints
      return true;
    }());
  }
  
  static void logWidgetTree(BuildContext context) {
    assert(() {
      debugDumpApp();
      return true;
    }());
  }
  
  static void logRenderTree(BuildContext context) {
    assert(() {
      debugDumpRenderTree();
      return true;
    }());
  }
}
```

## Test Data Management

### Test Data Factory
```dart
class TestDataFactory {
  static ContainerStruct createTestContainer({
    String? id,
    String? name,
    String? userId,
  }) {
    return ContainerStruct(
      containerId: id ?? 'test-container-${DateTime.now().millisecondsSinceEpoch}',
      name: name ?? 'Test Container',
      userId: userId ?? 'test-user',
      containerNumber: '001',
      description: 'Test container description',
      color: '#FF0000',
      size: 'Medium',
      createdAt: DateTime.now(),
    );
  }
  
  static ItemStruct createTestItem({
    String? name,
    String? containerId,
    String? category,
  }) {
    return ItemStruct(
      name: name ?? 'Test Item',
      containerId: containerId ?? 'test-container-1',
      category: category ?? 'Test Category',
      description: 'Test item description',
      quantity: 1,
      createdAt: DateTime.now(),
    );
  }
  
  static AiImageResponseStruct createTestAIResponse({
    String? name,
    String? category,
  }) {
    return AiImageResponseStruct(
      name: name ?? 'AI Generated Name',
      category: category ?? 'AI Generated Category',
    );
  }
}
```

### Mock Data Setup
```dart
class MockDataSeeder {
  static Future<void> seedTestData() async {
    // Create test containers
    for (int i = 1; i <= 5; i++) {
      final container = TestDataFactory.createTestContainer(
        name: 'Container $i',
        id: 'container-$i',
      );
      
      await SQLiteManager.instance.insertContainer(container);
      
      // Add items to each container
      for (int j = 1; j <= 3; j++) {
        final item = TestDataFactory.createTestItem(
          name: 'Item $j in Container $i',
          containerId: 'container-$i',
        );
        
        await SQLiteManager.instance.insertItem(item);
      }
    }
  }
  
  static Future<void> clearTestData() async {
    await SQLiteManager.instance.deleteAllItems();
    await SQLiteManager.instance.deleteAllContainers();
  }
}
```

## Common Testing Gotchas

1. **Async Operations**: Always use `pumpAndSettle()` after async operations
2. **Database State**: Clean up database state between tests
3. **Mock Services**: Mock external services (AI, file picker) for consistent tests
4. **Platform Differences**: Test on both Android and iOS if supporting both
5. **Permission Handling**: Mock or handle permission requests in tests
6. **Network Conditions**: Test offline scenarios
7. **Memory Leaks**: Monitor memory usage during long-running tests
8. **State Persistence**: Test app restart scenarios with saved state