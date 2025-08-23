# Custom Components & Widget Patterns

This file provides GitHub Copilot with specific context about ToteTracker's custom components, widgets, and actions that can work with both FlutterFlow and standard Flutter approaches.

## Custom Code Architecture

### Directory Structure
```
lib/custom_code/               # FlutterFlow custom code (if using FlutterFlow)
├── widgets/                   # Custom Flutter widgets for FlutterFlow
│   ├── base64_image.dart              # Display base64 encoded images
│   ├── database_backup_widget.dart    # Database export functionality
│   ├── import_database_widget.dart    # Database import functionality
│   └── import_db_and_restart_widget.dart # Import with app restart
├── actions/                   # Custom business logic functions
│   ├── analyze_image_with_gemini.dart # AI image analysis
│   ├── ai_response_to_item_data.dart  # Parse AI responses
│   └── file_to_base64.dart            # File conversion utilities
└── index.dart                 # Export barrel files

lib/core/                      # Framework-agnostic custom code
├── widgets/                   # Standard Flutter widgets
│   ├── base64_image_display.dart      # Base64 image display
│   ├── database_operations.dart       # Database operation widgets
│   └── custom_buttons.dart            # Custom button components
├── services/                  # Business logic services
│   ├── ai_service.dart                # AI integration service
│   ├── database_service.dart          # Database operations service
│   └── file_service.dart              # File handling service
└── utils/                     # Utility functions
    ├── validators.dart                # Form validation utilities
    └── converters.dart                # Data conversion utilities
```

### Import Patterns

#### FlutterFlow Custom Widget Imports
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

#### Standard Flutter Widget Imports
```dart
// Standard Flutter imports for custom widgets
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Or chosen state management
import '../../backend/schema/structs/index.dart';
import '../../backend/sqlite/sqlite_manager.dart';
import '../../core/themes/app_theme.dart'; // Custom theme system
import '../services/index.dart'; // Custom services
import '../utils/index.dart'; // Utility functions
```

#### Framework-Agnostic Imports
```dart
// Imports that work with any approach
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
```

## Custom Widget Patterns

### Base64 Image Display Widget - FlutterFlow Compatible
```dart
/// Base64 Image Display Widget for FlutterFlow
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

### Base64 Image Display Widget - Standard Flutter
```dart
/// Base64 Image Display Widget for Standard Flutter
class Base64ImageDisplay extends StatelessWidget {
  const Base64ImageDisplay({
    Key? key,
    this.width,
    this.height,
    required this.base64String,
    this.fit = BoxFit.contain,
    this.placeholder,
    this.errorWidget,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String? base64String;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    if (base64String == null || base64String!.isEmpty) {
      return _buildPlaceholder();
    }

    try {
      final imageBytes = base64Decode(base64String!);
      return Image.memory(
        imageBytes,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
      );
    } catch (e) {
      return _buildErrorWidget();
    }
  }

  Widget _buildPlaceholder() {
    return placeholder ??
        Container(
          width: width,
          height: height,
          color: Colors.grey[200],
          child: const Icon(
            Icons.image_not_supported,
            color: Colors.grey,
          ),
        );
  }

  Widget _buildErrorWidget() {
    return errorWidget ??
        Container(
          width: width,
          height: height,
          color: Colors.grey[300],
          child: const Icon(
            Icons.broken_image,
            color: Colors.red,
          ),
        );
  }
}
```

### Framework-Agnostic Base64 Image Service
```dart
/// Service for handling base64 image operations
class Base64ImageService {
  static Uint8List? decodeBase64(String? base64String) {
    if (base64String == null || base64String.isEmpty) return null;
    
    try {
      return base64Decode(base64String);
    } catch (e) {
      debugPrint('Error decoding base64 image: $e');
      return null;
    }
  }

  static String? encodeImage(Uint8List imageBytes) {
    try {
      return base64Encode(imageBytes);
    } catch (e) {
      debugPrint('Error encoding image to base64: $e');
      return null;
    }
  }

  static Widget buildImageWidget({
    required String? base64String,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Widget? placeholder,
    Widget? errorWidget,
  }) {
    final imageBytes = decodeBase64(base64String);
    
    if (imageBytes == null) {
      return placeholder ?? _defaultPlaceholder(width, height);
    }

    return Image.memory(
      imageBytes,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return errorWidget ?? _defaultErrorWidget(width, height);
      },
    );
  }

  static Widget _defaultPlaceholder(double? width, double? height) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[200],
      child: const Icon(Icons.image_not_supported, color: Colors.grey),
    );
  }

  static Widget _defaultErrorWidget(double? width, double? height) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[300],
      child: const Icon(Icons.broken_image, color: Colors.red),
    );
  }
}

// Usage:
// Base64ImageService.buildImageWidget(base64String: myBase64String)
```

### Database Operations Widget Patterns

#### FlutterFlow Database Widget
```dart
/// FlutterFlow-compatible database operations widget
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
  final Future<dynamic> Function()? onSuccess; // FlutterFlow callback
  final Future<dynamic> Function()? onError;   // FlutterFlow callback

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

#### Standard Flutter Database Widget
```dart
/// Standard Flutter database operations widget
class DatabaseOperationButton extends StatefulWidget {
  const DatabaseOperationButton({
    Key? key,
    this.width,
    this.height,
    this.operationType = DatabaseOperationType.export,
    this.onSuccess,
    this.onError,
    this.buttonText,
  }) : super(key: key);

  final double? width;
  final double? height;
  final DatabaseOperationType operationType;
  final VoidCallback? onSuccess; // Standard Flutter callback
  final void Function(String error)? onError;
  final String? buttonText;

  @override
  State<DatabaseOperationButton> createState() => _DatabaseOperationButtonState();
}

class _DatabaseOperationButtonState extends State<DatabaseOperationButton> {
  bool _isProcessing = false;

  Future<void> _performOperation() async {
    if (_isProcessing) return;

    setState(() => _isProcessing = true);

    try {
      switch (widget.operationType) {
        case DatabaseOperationType.export:
          await DatabaseService.exportDatabase();
          break;
        case DatabaseOperationType.import:
          await DatabaseService.importDatabase();
          break;
        case DatabaseOperationType.backup:
          await DatabaseService.backupDatabase();
          break;
      }

      if (widget.onSuccess != null) {
        widget.onSuccess!();
      }

      _showMessage('Operation completed successfully');
    } catch (e) {
      final errorMessage = 'Operation failed: ${e.toString()}';
      
      if (widget.onError != null) {
        widget.onError!(errorMessage);
      }

      _showMessage(errorMessage, isError: true);
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  void _showMessage(String message, {bool isError = false}) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError 
          ? Theme.of(context).colorScheme.error 
          : Theme.of(context).colorScheme.primary,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton.icon(
        onPressed: _isProcessing ? null : _performOperation,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        icon: _isProcessing
            ? SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              )
            : const Icon(Icons.database),
        label: Text(
          widget.buttonText ?? _getDefaultButtonText(),
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
    );
  }

  String _getDefaultButtonText() {
    switch (widget.operationType) {
      case DatabaseOperationType.export:
        return 'Export Database';
      case DatabaseOperationType.import:
        return 'Import Database';
      case DatabaseOperationType.backup:
        return 'Backup Database';
    }
  }
}

enum DatabaseOperationType { export, import, backup }
```

#### Framework-Agnostic Database Service
```dart
/// Framework-agnostic database operations service
class DatabaseService {
  static Future<String> exportDatabase() async {
    try {
      final dbPath = await getDatabasesPath();
      final dbFile = File('$dbPath/totetracker.db');
      
      if (!await dbFile.exists()) {
        throw Exception('Database file not found');
      }

      final bytes = await dbFile.readAsBytes();
      return base64Encode(bytes);
    } catch (e) {
      throw Exception('Error exporting database: ${e.toString()}');
    }
  }

  static Future<void> importDatabase(String base64Data) async {
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

  static Future<void> backupDatabase() async {
    try {
      final exportedData = await exportDatabase();
      // Save to device storage or cloud
      await _saveBackupToStorage(exportedData);
    } catch (e) {
      throw Exception('Error backing up database: ${e.toString()}');
    }
  }

  static Future<void> _saveBackupToStorage(String data) async {
    // Implementation for saving backup data
    // This could save to local storage, cloud storage, etc.
  }
}
```

## Custom Action Patterns

### Image Analysis Actions

#### FlutterFlow Action Pattern
```dart
/// Analyze image with Google Gemini AI (FlutterFlow action)
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

#### Standard Flutter Service Pattern
```dart
/// AI Image Analysis Service (Framework-agnostic)
class AIImageAnalysisService {
  static Future<ImageAnalysisResult> analyzeImage({
    required String apiKey,
    required Uint8List imageBytes,
    required String prompt,
  }) async {
    try {
      // Initialize Gemini with the API key
      Gemini.init(apiKey: apiKey);

      final gemini = Gemini.instance;

      // Send the image and prompt to Gemini
      final response = await gemini.textAndImage(
        text: prompt,
        images: [imageBytes],
      );

      // Extract the response text
      final responseText = response?.content?.parts?.last.text;

      if (responseText == null || responseText.isEmpty) {
        return ImageAnalysisResult.error('No response received from Gemini');
      }

      return ImageAnalysisResult.success(responseText);
    } catch (e) {
      return ImageAnalysisResult.error('Error analyzing image: ${e.toString()}');
    }
  }

  static Future<ImageAnalysisResult> analyzeImageFromFile({
    required String apiKey,
    required File imageFile,
    required String prompt,
  }) async {
    try {
      final imageBytes = await imageFile.readAsBytes();
      return analyzeImage(
        apiKey: apiKey,
        imageBytes: imageBytes,
        prompt: prompt,
      );
    } catch (e) {
      return ImageAnalysisResult.error('Error reading image file: ${e.toString()}');
    }
  }
}

/// Result class for image analysis operations
class ImageAnalysisResult {
  final bool isSuccess;
  final String? data;
  final String? error;

  const ImageAnalysisResult._({
    required this.isSuccess,
    this.data,
    this.error,
  });

  factory ImageAnalysisResult.success(String data) {
    return ImageAnalysisResult._(isSuccess: true, data: data);
  }

  factory ImageAnalysisResult.error(String error) {
    return ImageAnalysisResult._(isSuccess: false, error: error);
  }
}
```

#### Unified AI Service (Works with both approaches)
```dart
/// Unified AI service that works with both FlutterFlow and standard Flutter
class UnifiedAIService {
  static Future<String> analyzeImage({
    required String apiKey,
    required String prompt,
    FFUploadedFile? flutterFlowFile,
    Uint8List? imageBytes,
    File? imageFile,
  }) async {
    Uint8List? finalImageBytes;

    // Handle different input types
    if (flutterFlowFile != null) {
      finalImageBytes = flutterFlowFile.bytes;
    } else if (imageBytes != null) {
      finalImageBytes = imageBytes;
    } else if (imageFile != null) {
      finalImageBytes = await imageFile.readAsBytes();
    }

    if (finalImageBytes == null) {
      throw Exception('No valid image data provided');
    }

    try {
      Gemini.init(apiKey: apiKey);
      final gemini = Gemini.instance;

      final response = await gemini.textAndImage(
        text: prompt,
        images: [finalImageBytes],
      );

      final responseText = response?.content?.parts?.last.text;
      return responseText ?? 'No response received from Gemini';
    } catch (e) {
      throw Exception('Error analyzing image: ${e.toString()}');
    }
  }
}
```

### File Conversion Patterns

#### FlutterFlow File Conversion Action
```dart
/// Convert FlutterFlow uploaded file to base64 string for database storage
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

#### Standard Flutter File Conversion Service
```dart
/// Framework-agnostic file conversion service
class FileConversionService {
  /// Convert file to base64 string
  static Future<FileConversionResult> fileToBase64({
    File? file,
    Uint8List? bytes,
    String? filePath,
  }) async {
    try {
      Uint8List? fileBytes;

      if (bytes != null) {
        fileBytes = bytes;
      } else if (file != null) {
        fileBytes = await file.readAsBytes();
      } else if (filePath != null) {
        final fileFromPath = File(filePath);
        fileBytes = await fileFromPath.readAsBytes();
      }

      if (fileBytes == null || fileBytes.isEmpty) {
        return FileConversionResult.error('No valid file data provided');
      }

      final base64String = base64Encode(fileBytes);
      
      if (base64String.isEmpty) {
        return FileConversionResult.error('Failed to convert file to base64');
      }

      return FileConversionResult.success(base64String);
    } catch (e) {
      return FileConversionResult.error('Error converting file to base64: ${e.toString()}');
    }
  }

  /// Convert base64 string back to bytes
  static FileConversionResult base64ToBytes(String base64String) {
    try {
      if (base64String.isEmpty) {
        return FileConversionResult.error('Base64 string is empty');
      }

      final bytes = base64Decode(base64String);
      return FileConversionResult.successBytes(bytes);
    } catch (e) {
      return FileConversionResult.error('Error decoding base64 string: ${e.toString()}');
    }
  }

  /// Save bytes to file
  static Future<FileConversionResult> saveToFile({
    required Uint8List bytes,
    required String filePath,
  }) async {
    try {
      final file = File(filePath);
      await file.writeAsBytes(bytes);
      return FileConversionResult.success('File saved successfully to $filePath');
    } catch (e) {
      return FileConversionResult.error('Error saving file: ${e.toString()}');
    }
  }

  /// Get file size in a human-readable format
  static String getFileSize(Uint8List bytes) {
    const suffixes = ['B', 'KB', 'MB', 'GB'];
    var size = bytes.length.toDouble();
    var suffixIndex = 0;

    while (size >= 1024 && suffixIndex < suffixes.length - 1) {
      size /= 1024;
      suffixIndex++;
    }

    return '${size.toStringAsFixed(1)} ${suffixes[suffixIndex]}';
  }
}

/// Result class for file conversion operations
class FileConversionResult {
  final bool isSuccess;
  final String? data;
  final Uint8List? bytes;
  final String? error;

  const FileConversionResult._({
    required this.isSuccess,
    this.data,
    this.bytes,
    this.error,
  });

  factory FileConversionResult.success(String data) {
    return FileConversionResult._(isSuccess: true, data: data);
  }

  factory FileConversionResult.successBytes(Uint8List bytes) {
    return FileConversionResult._(isSuccess: true, bytes: bytes);
  }

  factory FileConversionResult.error(String error) {
    return FileConversionResult._(isSuccess: false, error: error);
  }
}
```

#### Image Processing Service (Framework-Agnostic)
```dart
/// Image processing service that works with any framework
class ImageProcessingService {
  /// Compress image for database storage
  static Future<Uint8List?> compressImage({
    required Uint8List imageBytes,
    int quality = 85,
    int? maxWidth,
    int? maxHeight,
  }) async {
    try {
      // Note: This would require image processing packages like 'image' or 'flutter_image_compress'
      // Implementation would depend on chosen package
      
      // Placeholder implementation
      return imageBytes;
    } catch (e) {
      debugPrint('Error compressing image: $e');
      return null;
    }
  }

  /// Get image metadata
  static Future<ImageMetadata?> getImageMetadata(Uint8List imageBytes) async {
    try {
      // Note: Implementation would depend on image processing package
      
      // Placeholder implementation
      return ImageMetadata(
        width: 0,
        height: 0,
        format: 'unknown',
        sizeInBytes: imageBytes.length,
      );
    } catch (e) {
      debugPrint('Error getting image metadata: $e');
      return null;
    }
  }
}

class ImageMetadata {
  final int width;
  final int height;
  final String format;
  final int sizeInBytes;

  ImageMetadata({
    required this.width,
    required this.height,
    required this.format,
    required this.sizeInBytes,
  });

  String get sizeFormatted => FileConversionService.getFileSize(
    Uint8List(sizeInBytes)
  );
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