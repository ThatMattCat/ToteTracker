# UI Framework Integration Patterns

This file provides GitHub Copilot with specific context about ToteTracker's UI framework integration patterns, supporting both FlutterFlow and standard Flutter approaches.

## Framework Options

### FlutterFlow Integration (Current Approach)
- **Location**: `lib/flutter_flow/` directory
- **Purpose**: Contains FlutterFlow-generated base components, themes, and utilities
- **Advantages**: Rapid development, visual design, automatic code generation
- **Key Files**:
  - `flutter_flow_theme.dart` - Theme definitions and color schemes
  - `flutter_flow_widgets.dart` - Custom widget helpers and extensions
  - `flutter_flow_model.dart` - Base model classes for state management
  - `nav/nav.dart` - Navigation routing configuration

### Standard Flutter Implementation (Alternative)
- **Location**: `lib/core/` directory for framework-agnostic components
- **Purpose**: Pure Flutter implementation with full control
- **Advantages**: Complete customization, no external dependencies, better performance
- **Structure**:
  - `core/themes/` - Custom theme system
  - `core/widgets/` - Standard Flutter widgets
  - `core/navigation/` - Navigation configuration
  - `core/models/` - State management models

### Hybrid Approach (Recommended for Migration)
- **Purpose**: Gradual migration from FlutterFlow to standard Flutter
- **Strategy**: Replace FlutterFlow components incrementally
- **Benefits**: Maintain existing functionality while gaining flexibility

## Theme System Patterns

### FlutterFlow Theme System
When using FlutterFlow-generated themes:

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

### Standard Flutter Theme System
Alternative approach using standard Flutter theming:

```dart
// Access standard theme colors
Theme.of(context).colorScheme.primary
Theme.of(context).colorScheme.secondary
Theme.of(context).colorScheme.onPrimary
Theme.of(context).colorScheme.onSurface

// Typography
Theme.of(context).textTheme.bodyMedium
Theme.of(context).textTheme.headlineSmall

// Theme-aware styling
style: Theme.of(context).textTheme.bodyMedium?.copyWith(
  color: Theme.of(context).colorScheme.onSurface,
)
```

### Custom Theme System
For complete control over theming:

```dart
// Custom theme provider
class AppTheme {
  static AppTheme of(BuildContext context) {
    return Provider.of<AppTheme>(context);
  }
  
  final Color primary;
  final Color secondary;
  final TextStyle bodyText;
  
  AppTheme({
    required this.primary,
    required this.secondary,
    required this.bodyText,
  });
}

// Usage
AppTheme.of(context).primary
AppTheme.of(context).bodyText
```

### Color Scheme Structure
Common color categories across all theme systems:
- Primary colors: `primary`, `secondary`, `tertiary`
- Background colors: `primaryBackground`, `secondaryBackground`, `surface`
- Text colors: `primaryText`, `secondaryText`, `onSurface`
- Semantic colors: `success`, `warning`, `error`, `info`
- Accent colors: `accent1`, `accent2`, `accent3`, `accent4`

## Widget Development Patterns

### FlutterFlow Custom Widget Structure
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
  final Future<dynamic> Function()? onCallback; // FlutterFlow async callback

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

### Standard Flutter Widget Structure
```dart
// Standard Flutter widget template
class MyCustomWidget extends StatefulWidget {
  const MyCustomWidget({
    Key? key,
    this.width,
    this.height,
    required this.onCallback,
    this.data,
  }) : super(key: key);

  final double? width;
  final double? height;
  final VoidCallback onCallback; // Standard Flutter callback
  final String? data;

  @override
  State<MyCustomWidget> createState() => _MyCustomWidgetState();
}

class _MyCustomWidgetState extends State<MyCustomWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: // Widget implementation
    );
  }
}
```

### Button Patterns

#### FlutterFlow Button
```dart
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

#### Standard Flutter Button
```dart
ElevatedButton(
  onPressed: () {
    // Action logic
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Theme.of(context).colorScheme.primary,
    foregroundColor: Theme.of(context).colorScheme.onPrimary,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    elevation: 2,
  ),
  child: Text(
    'Button Text',
    style: Theme.of(context).textTheme.labelLarge,
  ),
)
```

#### Custom Button (Framework Agnostic)
```dart
class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.width,
    this.height,
    this.style,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String text;
  final double? width;
  final double? height;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: style ?? _defaultStyle(context),
        child: Text(text),
      ),
    );
  }

  ButtonStyle _defaultStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}
```

## Navigation Patterns

### FlutterFlow Route Definition Structure
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

### FlutterFlow Navigation Usage
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

### Standard go_router Navigation
```dart
// Route definition in main.dart or separate router file
GoRoute(
  path: '/page-path',
  name: 'PageName',
  builder: (context, state) => PageNameWidget(
    parameter: state.queryParameters['parameter'],
  ),
)

// Navigation usage
context.go('/page-path');
context.push('/page-path');
context.pushNamed('PageName', queryParameters: {'parameter': 'value'});
GoRouter.of(context).pop();
```

### Standard Navigator Navigation
```dart
// Route definition in main.dart
MaterialApp(
  routes: {
    '/page-path': (context) => PageNameWidget(),
  },
)

// Navigation usage
Navigator.of(context).pushNamed('/page-path');
Navigator.of(context).pushNamed('/page-path', arguments: {'parameter': 'value'});
Navigator.of(context).pop();
```

### Navigation Service Pattern (Framework Agnostic)
```dart
// Create a navigation service
class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService() => _instance;
  NavigationService._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void navigateTo(String routeName, {Object? arguments}) {
    navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  void goBack() {
    navigatorKey.currentState?.pop();
  }
}

// Usage
NavigationService().navigateTo('/page-path');
NavigationService().goBack();
```

## State Management Patterns

### FlutterFlow Page Model Pattern
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

### Standard Flutter State Management
```dart
// Standard Flutter StatefulWidget state
class _PageNameState extends State<PageName> {
  final FocusNode _unfocusNode = FocusNode();
  FocusNode? _textFieldFocusNode;
  TextEditingController? _textController;

  bool _isLoading = false;
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _textFieldFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    _textFieldFocusNode?.dispose();
    _textController?.dispose();
    super.dispose();
  }
}
```

### Provider State Management
```dart
// State model class
class PageState extends ChangeNotifier {
  bool _isLoading = false;
  String? _selectedValue;

  bool get isLoading => _isLoading;
  String? get selectedValue => _selectedValue;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setSelectedValue(String? value) {
    _selectedValue = value;
    notifyListeners();
  }
}

// Usage in widget
Consumer<PageState>(
  builder: (context, pageState, child) {
    return Text(pageState.selectedValue ?? 'No selection');
  },
)
```

### Global State Access

#### FlutterFlow Global State
```dart
// Access global app state
FFAppState().variableName

// Update global state
FFAppState().update(() {
  FFAppState().variableName = newValue;
});
```

#### Provider Global State
```dart
// Access global app state
Provider.of<AppState>(context).variableName
context.read<AppState>().variableName
context.watch<AppState>().variableName

// Update global state
context.read<AppState>().updateVariable(newValue);
```

#### Riverpod State Management (Alternative)
```dart
// State provider
final selectedValueProvider = StateProvider<String?>((ref) => null);

// Usage in widget
Consumer(
  builder: (context, ref, child) {
    final selectedValue = ref.watch(selectedValueProvider);
    return Text(selectedValue ?? 'No selection');
  },
)

// Update state
ref.read(selectedValueProvider.notifier).state = newValue;
```

## Form Handling Patterns

### FlutterFlow Text Field Pattern
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

### Standard Flutter Text Field Pattern
```dart
TextFormField(
  controller: _textController,
  focusNode: _textFieldFocusNode,
  decoration: InputDecoration(
    labelText: 'Label',
    labelStyle: Theme.of(context).textTheme.labelMedium,
    hintText: 'Hint text',
    hintStyle: Theme.of(context).textTheme.labelMedium,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.outline,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.primary,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  style: Theme.of(context).textTheme.bodyMedium,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  },
)
```

### Custom Text Field Component
```dart
class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    required this.controller,
    this.focusNode,
    this.labelText,
    this.hintText,
    this.validator,
    this.obscureText = false,
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? labelText;
  final String? hintText;
  final String? Function(String?)? validator;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      validator: validator,
    );
  }
}
```

### Validation Patterns

#### FlutterFlow Validation
```dart
// Validator function
String? Function(BuildContext, String?)? textControllerValidator = (context, val) {
  if (val == null || val.isEmpty) {
    return 'Field is required.';
  }
  return null;
};
```

#### Standard Flutter Validation
```dart
// Validator function
String? _validateRequired(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field is required';
  }
  return null;
}

String? _validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  }
  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    return 'Please enter a valid email';
  }
  return null;
}
```

#### Validation Service Pattern
```dart
class ValidationService {
  static String? required(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) return null;
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? minLength(String? value, int minLength) {
    if (value == null || value.length < minLength) {
      return 'Must be at least $minLength characters';
    }
    return null;
  }
}

// Usage
validator: (value) => ValidationService.required(value, fieldName: 'Name'),
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

## Migration Strategies

### FlutterFlow to Standard Flutter Migration

#### Step 1: Replace Theme System
```dart
// Before (FlutterFlow)
FlutterFlowTheme.of(context).primary

// After (Standard Flutter)
Theme.of(context).colorScheme.primary

// Migration strategy:
// 1. Create a custom theme system that mimics FlutterFlow structure
// 2. Gradually replace FlutterFlow theme calls
// 3. Eventually migrate to standard Flutter theming
```

#### Step 2: Replace Navigation System
```dart
// Before (FlutterFlow)
context.pushNamed('PageName');

// After (go_router)
context.go('/page-name');

// After (Navigator)
Navigator.of(context).pushNamed('/page-name');
```

#### Step 3: Replace State Management
```dart
// Before (FlutterFlow)
FFAppState().variable

// After (Provider)
Provider.of<AppState>(context).variable

// After (Riverpod)
ref.watch(variableProvider)
```

#### Step 4: Replace Custom Widgets
```dart
// Before (FlutterFlow)
FFButtonWidget(
  onPressed: () async => action(),
  text: 'Button',
  options: FFButtonOptions(/* ... */),
)

// After (Standard Flutter)
ElevatedButton(
  onPressed: action,
  child: Text('Button'),
)
```

### Hybrid Approach Strategy

1. **Keep FlutterFlow for Rapid Prototyping**: Use FlutterFlow for new screens and quick iterations
2. **Standard Flutter for Complex Logic**: Use standard Flutter for custom business logic and complex widgets
3. **Shared Services**: Create framework-agnostic services that work with both approaches
4. **Gradual Migration**: Migrate one component/screen at a time

### Component Replacement Map

| FlutterFlow Component | Standard Flutter Replacement |
|----------------------|------------------------------|
| `FFButtonWidget` | `ElevatedButton`, `TextButton`, `OutlinedButton` |
| `FlutterFlowTheme.of(context)` | `Theme.of(context)` |
| `context.pushNamed()` | `context.go()` or `Navigator.pushNamed()` |
| `FFAppState()` | `Provider.of<AppState>()` or `ref.watch()` |
| `FlutterFlowModel` | Custom state management or `ChangeNotifier` |
| `FFRoute` | `GoRoute` or standard routes |

## Framework-Agnostic Patterns

### Service Layer Pattern
Create services that work regardless of UI framework:

```dart
// AI Service (framework-agnostic)
class AIService {
  static Future<String> analyzeImage(Uint8List imageBytes, String prompt) async {
    // Implementation works with any UI framework
  }
}

// Database Service (framework-agnostic)
class DatabaseService {
  static Future<List<ItemStruct>> getItems() async {
    // Implementation works with any UI framework
  }
}
```

### Dependency Injection Pattern
```dart
// Abstract interfaces
abstract class ThemeService {
  Color get primaryColor;
  TextStyle get bodyText;
}

abstract class NavigationService {
  void navigateTo(String route);
  void goBack();
}

// FlutterFlow implementation
class FlutterFlowThemeService implements ThemeService {
  final BuildContext context;
  FlutterFlowThemeService(this.context);
  
  @override
  Color get primaryColor => FlutterFlowTheme.of(context).primary;
  
  @override
  TextStyle get bodyText => FlutterFlowTheme.of(context).bodyMedium;
}

// Standard Flutter implementation
class StandardThemeService implements ThemeService {
  final BuildContext context;
  StandardThemeService(this.context);
  
  @override
  Color get primaryColor => Theme.of(context).colorScheme.primary;
  
  @override
  TextStyle get bodyText => Theme.of(context).textTheme.bodyMedium ?? const TextStyle();
}
```

## Common Development Gotchas

### FlutterFlow-Specific Issues
1. **Code Regeneration**: FlutterFlow may overwrite generated files in `flutter_flow/` directory
2. **Custom Code Placement**: Keep custom code in `custom_code/` directory to avoid overwriting
3. **Theme Consistency**: Always use FlutterFlow theme system when using FlutterFlow components
4. **Navigation Context**: Use proper context for FlutterFlow navigation
5. **State Updates**: Use proper FlutterFlow state update patterns to trigger rebuilds

### Standard Flutter Issues
1. **Theme Consistency**: Ensure consistent theming across all components
2. **State Management**: Choose one state management approach and stick to it
3. **Memory Leaks**: Properly dispose controllers, listeners, and streams
4. **Navigation Context**: Ensure navigation context is valid
5. **Performance**: Avoid heavy operations in build methods

### Migration Issues
1. **Import Conflicts**: Avoid mixing FlutterFlow and standard imports in the same file
2. **Theme System Conflicts**: Don't mix `FlutterFlowTheme` and `Theme` in the same widget
3. **State Management Conflicts**: Use only one state management system per feature
4. **Navigation Conflicts**: Don't mix FlutterFlow navigation with standard navigation
5. **Build Context Issues**: Ensure context is valid when transitioning between systems

### General Best Practices
1. **Gradual Migration**: Migrate components one at a time rather than all at once
2. **Testing**: Test each component thoroughly after migration
3. **Documentation**: Document which components use which framework approach
4. **Consistency**: Maintain consistent patterns within each approach
5. **Performance**: Monitor performance when switching between approaches