# FlutterFlow Integration Patterns

This file provides GitHub Copilot with specific context about how ToteTracker integrates with FlutterFlow and the patterns used throughout the codebase.

## FlutterFlow Generated vs Custom Code

### Generated Components
- **Location**: `lib/flutter_flow/` directory
- **Purpose**: Contains FlutterFlow-generated base components, themes, and utilities
- **Key Files**:
  - `flutter_flow_theme.dart` - Theme definitions and color schemes
  - `flutter_flow_widgets.dart` - Custom widget helpers and extensions
  - `flutter_flow_model.dart` - Base model classes for state management
  - `nav/nav.dart` - Navigation routing configuration

### Custom Extensions
- **Location**: `lib/custom_code/` directory
- **Purpose**: Custom widgets and actions that extend FlutterFlow functionality
- **Structure**:
  - `widgets/` - Custom Flutter widgets
  - `actions/` - Custom business logic functions

## Theme System Patterns

### Using FlutterFlow Themes
```dart
// Access theme colors
FlutterFlowTheme.of(context).primary
FlutterFlowTheme.of(context).secondary
FlutterFlowTheme.of(context).primaryText
FlutterFlowTheme.of(context).secondaryText

// Typography
FlutterFlowTheme.of(context).bodyMedium
FlutterFlowTheme.of(context).headlineSmall

// Theme-aware styling
style: FlutterFlowTheme.of(context).bodyMedium.override(
  fontFamily: 'Readex Pro',
  color: FlutterFlowTheme.of(context).primaryText,
)
```

### Color Scheme Structure
- **Light/Dark Mode Support**: Automatic theme switching
- **Color Categories**:
  - Primary colors: `primary`, `secondary`, `tertiary`
  - Background colors: `primaryBackground`, `secondaryBackground`
  - Text colors: `primaryText`, `secondaryText`
  - Semantic colors: `success`, `warning`, `error`, `info`
  - Accent colors: `accent1`, `accent2`, `accent3`, `accent4`

## Widget Development Patterns

### Custom Widget Structure
```dart
// FlutterFlow custom widget template
class MyCustomWidget extends StatefulWidget {
  const MyCustomWidget({
    Key? key,
    this.width,
    this.height,
    // Add parameters as needed
    required this.onCallback,
  }) : super(key: key);

  final double? width;
  final double? height;
  final Future<dynamic> Function()? onCallback;

  @override
  _MyCustomWidgetState createState() => _MyCustomWidgetState();
}

class _MyCustomWidgetState extends State<MyCustomWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: // Widget implementation
    );
  }
}
```

### Button Patterns
```dart
// FlutterFlow button with custom styling
FFButtonWidget(
  onPressed: () async {
    // Action logic
  },
  text: 'Button Text',
  options: FFButtonOptions(
    width: 200,
    height: 40,
    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
    color: FlutterFlowTheme.of(context).primary,
    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
      fontFamily: 'Readex Pro',
      color: Colors.white,
    ),
    elevation: 2,
    borderSide: BorderSide(
      color: Colors.transparent,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(8),
  ),
)
```

## Navigation Patterns

### Route Definition Structure
```dart
// Routes are defined in lib/flutter_flow/nav/nav.dart
FFRoute(
  name: 'PageName',
  path: '/page-path',
  builder: (context, params) => PageNameWidget(
    // Pass parameters from route
    parameter: params.getParam('parameter', ParamType.String),
  ),
  requireAuth: false,
)
```

### Navigation Usage
```dart
// Navigate to a page
context.pushNamed('PageName');

// Navigate with parameters
context.pushNamed(
  'PageName',
  queryParameters: {
    'parameter': 'value',
  },
);

// Go back
context.pop();
```

## State Management Patterns

### Page Model Pattern
```dart
// Page models extend FlutterFlowModel
class PageNameModel extends FlutterFlowModel<PageNameWidget> {
  // Form controllers
  final unfocusNode = FocusNode();
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;

  // Page state variables
  bool isLoading = false;
  String? selectedValue;

  @override
  void initState(BuildContext context) {
    // Initialize controllers and state
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
```

### Global State Access
```dart
// Access global app state
FFAppState().variableName

// Update global state
FFAppState().update(() {
  FFAppState().variableName = newValue;
});
```

## Form Handling Patterns

### Text Field Pattern
```dart
TextFormField(
  controller: _model.textController,
  focusNode: _model.textFieldFocusNode,
  autofocus: false,
  obscureText: false,
  decoration: InputDecoration(
    labelText: 'Label',
    labelStyle: FlutterFlowTheme.of(context).labelMedium,
    hintText: 'Hint text',
    hintStyle: FlutterFlowTheme.of(context).labelMedium,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: FlutterFlowTheme.of(context).alternate,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: FlutterFlowTheme.of(context).primary,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  style: FlutterFlowTheme.of(context).bodyMedium,
  validator: _model.textControllerValidator.asValidator(context),
)
```

### Validation Patterns
```dart
// Validator function
String? Function(BuildContext, String?)? textControllerValidator = (context, val) {
  if (val == null || val.isEmpty) {
    return 'Field is required.';
  }
  return null;
};
```

## Custom Action Patterns

### Database Operations in Actions
```dart
// Custom action example
Future<void> customDatabaseAction(String parameter) async {
  try {
    // Database operation
    await SQLiteManager.instance.insertItem(
      // parameters
    );
    
    // Update UI or show success
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Success!')),
    );
  } catch (e) {
    // Handle error
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: ${e.toString()}')),
    );
  }
}
```

## Integration with Custom Widgets

### Import Pattern for Custom Widgets
```dart
// Standard FlutterFlow imports for custom widgets
import '/backend/schema/structs/index.dart';
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
```

### Widget Communication Pattern
```dart
// Callback pattern for widget communication
class CustomWidget extends StatefulWidget {
  final Future<dynamic> Function()? onSuccess;
  final Future<dynamic> Function()? onError;

  const CustomWidget({
    Key? key,
    this.onSuccess,
    this.onError,
  }) : super(key: key);

  // Implementation that calls callbacks
  void _handleSuccess() async {
    if (widget.onSuccess != null) {
      await widget.onSuccess!();
    }
  }
}
```

## Performance Optimization Patterns

### Efficient Rebuilds
```dart
// Use specific widget rebuilds
Consumer<FFAppState>(
  builder: (context, appState, child) {
    return Text(appState.specificValue);
  },
)

// Avoid full page rebuilds when possible
```

### Memory Management
```dart
// Proper disposal in custom widgets
@override
void dispose() {
  // Clean up controllers, listeners, etc.
  super.dispose();
}
```

## Common FlutterFlow Gotchas

1. **Code Regeneration**: FlutterFlow may overwrite generated files
2. **Custom Code Placement**: Keep custom code in `custom_code/` directory
3. **Theme Consistency**: Always use FlutterFlow theme system
4. **Navigation Context**: Use proper context for navigation
5. **State Updates**: Use proper state update patterns to trigger rebuilds