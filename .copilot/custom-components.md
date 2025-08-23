# Custom Components & Widget Patterns

This file provides GitHub Copilot with specific context about ToteTracker's custom components, widgets, and actions that extend FlutterFlow functionality.

## Custom Code Architecture

### Directory Structure
```
lib/custom_code/
├── widgets/               # Custom Flutter widgets
│   ├── base64_image.dart           # Display base64 encoded images
│   ├── database_backup_widget.dart # Database export functionality
│   ├── import_database_widget.dart # Database import functionality
│   └── import_db_and_restart_widget.dart # Import with app restart
├── actions/               # Custom business logic functions
│   ├── analyze_image_with_gemini.dart # AI image analysis
│   ├── ai_response_to_item_data.dart # Parse AI responses
│   └── file_to_base64.dart # File conversion utilities
└── index.dart            # Export barrel files
```

### Import Pattern for Custom Code
```dart
// Standard FlutterFlow imports for custom widgets/actions
import '/backend/schema/structs/index.dart';
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!
```

## Custom Widget Patterns

### Base64 Image Display Widget
```dart
/// Base64 Image Display Widget
/// Converts base64 string to displayable image
class Base64Image extends StatefulWidget {
  const Base64Image({
    Key? key,
    this.width,
    this.height,
    required this.base64,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String? base64;

  @override
  _Base64ImageState createState() => _Base64ImageState();
}

class _Base64ImageState extends State<Base64Image> {
  @override
  Widget build(BuildContext context) {
    Uint8List? imageBytes;

    // Safely decode base64 string
    imageBytes = widget.base64 != null ? base64Decode(widget.base64!) : null;

    return imageBytes != null
        ? Image.memory(
            imageBytes,
            width: widget.width,
            height: widget.height,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: widget.width,
                height: widget.height,
                color: Colors.grey[300],
                child: Icon(Icons.broken_image),
              );
            },
          )
        : Container(
            width: widget.width,
            height: widget.height,
            color: Colors.grey[200],
            child: Icon(Icons.image_not_supported),
          );
  }
}
```

### Database Operations Widget Pattern
```dart
/// Widget for database import/export operations
class DatabaseOperationWidget extends StatefulWidget {
  const DatabaseOperationWidget({
    Key? key,
    this.width,
    this.height,
    this.onSuccess,
    this.onError,
  }) : super(key: key);

  final double? width;
  final double? height;
  final Future<dynamic> Function()? onSuccess;
  final Future<dynamic> Function()? onError;

  @override
  _DatabaseOperationWidgetState createState() => _DatabaseOperationWidgetState();
}

class _DatabaseOperationWidgetState extends State<DatabaseOperationWidget> {
  bool _isProcessing = false;

  Future<void> _performOperation() async {
    if (_isProcessing) return;

    setState(() => _isProcessing = true);

    try {
      // Perform database operation
      await _databaseOperation();

      // Call success callback
      if (widget.onSuccess != null) {
        await widget.onSuccess!();
      }

      // Show success message
      _showMessage('Operation completed successfully', isError: false);
    } catch (e) {
      // Call error callback
      if (widget.onError != null) {
        await widget.onError!();
      }

      // Show error message
      _showMessage('Operation failed: ${e.toString()}', isError: true);
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  void _showMessage(String message, {required bool isError}) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError 
          ? FlutterFlowTheme.of(context).error 
          : FlutterFlowTheme.of(context).success,
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton(
        onPressed: _isProcessing ? null : _performOperation,
        style: ElevatedButton.styleFrom(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: _isProcessing
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primaryBackground,
                  ),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.database,
                    color: FlutterFlowTheme.of(context).primaryText,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Database Operation',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                  ),
                ],
              ),
      ),
    );
  }
}
```

## Custom Action Patterns

### Image Analysis Action
```dart
/// Analyze image with Google Gemini AI
Future<String> analyzeImageWithGemini(
  String apiKey,
  FFUploadedFile imageFile,
  String prompt,
) async {
  try {
    // Initialize Gemini with the API key
    Gemini.init(apiKey: apiKey);

    // Get the Gemini instance
    final gemini = Gemini.instance;

    // Get image bytes from FFUploadedFile
    final imageBytes = imageFile.bytes;

    if (imageBytes == null) {
      return 'Error: No image data found';
    }

    // Send the image and prompt to Gemini
    final response = await gemini.textAndImage(
      text: prompt,
      images: [imageBytes],
    );

    // Extract the response text
    final responseText = response?.content?.parts?.last.text;

    // Return the response or a default message if empty
    return responseText ?? 'No response received from Gemini';
  } catch (e) {
    // Return error message if something goes wrong
    return 'Error analyzing image: ${e.toString()}';
  }
}
```

### File Conversion Action
```dart
/// Convert file to base64 string for database storage
Future<String> fileToBase64(FFUploadedFile file) async {
  try {
    final bytes = file.bytes;
    if (bytes == null || bytes.isEmpty) {
      throw Exception('File is empty or corrupted');
    }

    // Convert to base64
    final base64String = base64Encode(bytes);
    
    // Validate conversion
    if (base64String.isEmpty) {
      throw Exception('Failed to convert file to base64');
    }

    return base64String;
  } catch (e) {
    throw Exception('Error converting file to base64: ${e.toString()}');
  }
}

/// Convert base64 string back to file bytes
Uint8List base64ToBytes(String base64String) {
  try {
    return base64Decode(base64String);
  } catch (e) {
    throw Exception('Error decoding base64 string: ${e.toString()}');
  }
}
```

### Database Backup Action
```dart
/// Export database as base64 string
Future<String> exportDatabaseAsBase64() async {
  try {
    final dbPath = await getDatabasesPath();
    final dbFile = File('$dbPath/totetracker.db');
    
    if (!await dbFile.exists()) {
      throw Exception('Database file not found');
    }

    final bytes = await dbFile.readAsBytes();
    final base64String = base64Encode(bytes);
    
    return base64String;
  } catch (e) {
    throw Exception('Error exporting database: ${e.toString()}');
  }
}

/// Import database from base64 string
Future<void> importDatabaseFromBase64(String base64Data) async {
  try {
    final bytes = base64Decode(base64Data);
    final dbPath = await getDatabasesPath();
    final dbFile = File('$dbPath/totetracker.db');
    
    // Close current database connection
    await SQLiteManager.instance.database.close();
    
    // Write new database file
    await dbFile.writeAsBytes(bytes);
    
    // Reinitialize database
    await SQLiteManager.initialize();
    
  } catch (e) {
    throw Exception('Error importing database: ${e.toString()}');
  }
}
```

## FlutterFlow Integration Patterns

### Widget Parameter Handling
```dart
class CustomWidget extends StatefulWidget {
  const CustomWidget({
    Key? key,
    // Standard FlutterFlow parameters
    this.width,
    this.height,
    // Custom parameters
    required this.data,
    this.onCallback,
    this.configuration,
  }) : super(key: key);

  // FlutterFlow passes these automatically
  final double? width;
  final double? height;
  
  // Custom parameters defined in FlutterFlow
  final String data;
  final Future<dynamic> Function()? onCallback;
  final Map<String, dynamic>? configuration;

  @override
  _CustomWidgetState createState() => _CustomWidgetState();
}
```

### Callback Pattern
```dart
// Triggering callbacks in custom widgets
void _handleSuccess(dynamic result) async {
  if (widget.onSuccess != null) {
    try {
      await widget.onSuccess!();
    } catch (e) {
      print('Error in success callback: $e');
    }
  }
}

void _handleError(String error) async {
  if (widget.onError != null) {
    try {
      await widget.onError!();
    } catch (e) {
      print('Error in error callback: $e');
    }
  }
}
```

### State Management in Custom Widgets
```dart
class _CustomWidgetState extends State<CustomWidget> {
  // Local state variables
  bool _isLoading = false;
  String? _errorMessage;
  dynamic _result;

  @override
  void initState() {
    super.initState();
    _initializeWidget();
  }

  @override
  void didUpdateWidget(CustomWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Handle parameter changes
    if (widget.data != oldWidget.data) {
      _handleDataChange();
    }
  }

  @override
  void dispose() {
    // Clean up resources
    super.dispose();
  }

  void _updateState(VoidCallback update) {
    if (mounted) {
      setState(update);
    }
  }
}
```

## Common Custom Component Patterns

### Loading States
```dart
Widget _buildLoadingIndicator() {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularProgressIndicator(
          color: FlutterFlowTheme.of(context).primary,
        ),
        SizedBox(height: 16),
        Text(
          'Processing...',
          style: FlutterFlowTheme.of(context).bodyMedium,
        ),
      ],
    ),
  );
}
```

### Error States
```dart
Widget _buildErrorState(String error) {
  return Container(
    padding: EdgeInsets.all(16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.error_outline,
          color: FlutterFlowTheme.of(context).error,
          size: 48,
        ),
        SizedBox(height: 16),
        Text(
          'Error',
          style: FlutterFlowTheme.of(context).headlineSmall.override(
            fontFamily: 'Readex Pro',
            color: FlutterFlowTheme.of(context).error,
          ),
        ),
        SizedBox(height: 8),
        Text(
          error,
          style: FlutterFlowTheme.of(context).bodyMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: _retry,
          child: Text('Retry'),
        ),
      ],
    ),
  );
}
```

### File Picker Integration
```dart
Future<void> _pickFile() async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['db', 'sqlite'],
    );

    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      await _processSelectedFile(file);
    }
  } catch (e) {
    _showError('Error selecting file: ${e.toString()}');
  }
}
```

## Performance Considerations

### Memory Management
```dart
class _CustomWidgetState extends State<CustomWidget> {
  StreamSubscription? _subscription;
  Timer? _timer;
  
  @override
  void dispose() {
    // Cancel subscriptions and timers
    _subscription?.cancel();
    _timer?.cancel();
    super.dispose();
  }
}
```

### Efficient Rebuilds
```dart
// Use const constructors where possible
const CustomWidget({
  Key? key,
  required this.data,
}) : super(key: key);

// Implement shouldRebuild logic
@override
bool shouldRebuild(oldWidget) {
  return widget.data != oldWidget.data;
}
```

## Testing Custom Components

### Widget Testing Pattern
```dart
void main() {
  testWidgets('Custom widget displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomWidget(
            data: 'test data',
            onCallback: () async {},
          ),
        ),
      ),
    );

    expect(find.byType(CustomWidget), findsOneWidget);
    expect(find.text('test data'), findsOneWidget);
  });
}
```

## Common Gotchas

1. **FlutterFlow Regeneration**: Custom widgets in `flutter_flow/` may be overwritten
2. **Import Order**: FlutterFlow imports must come first
3. **Null Safety**: Always check for null parameters from FlutterFlow
4. **Context Usage**: Ensure context is valid before use (check `mounted`)
5. **Callback Errors**: Wrap callbacks in try-catch blocks
6. **State Updates**: Use `mounted` check before setState
7. **Resource Cleanup**: Always dispose of resources in dispose method
8. **Performance**: Avoid heavy operations in build method