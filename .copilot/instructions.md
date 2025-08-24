# ToteTracker - GitHub Copilot Development Instructions

## Project Overview

ToteTracker is a comprehensive Flutter storage tracking application that helps users organize and track items in storage containers. The app features AI-powered categorization, QR code scanning, and local SQLite database storage.

### Core Purpose
- Track storage containers and their contents
- AI-powered automatic item categorization using Google Gemini
- QR code integration for container identification
- Local-first approach with SQLite database
- Cross-platform Flutter application (primary focus: Android)

## Architecture & Technology Stack

### Primary Technologies
- **Flutter 3.0+**: Cross-platform mobile framework
- **SQLite**: Local database storage for all app data
- **Google Gemini AI**: Image analysis and automatic categorization
- **Dart**: Primary programming language

### UI Framework Options
- **FlutterFlow** (Current): Visual Flutter development platform (generates base UI components)
- **Standard Flutter**: Pure Flutter implementation with manual widget creation
- **Hybrid Approach**: Mix of FlutterFlow-generated and custom Flutter components

### Key Dependencies
- `sqflite`: SQLite database operations
- `flutter_gemini`: Google Gemini AI integration
- `flutter_barcode_scanner`: QR code and barcode scanning
- `image_picker`: Camera and photo selection
- `shared_preferences`: Settings and preferences storage

### State Management Options
- `provider`: Simple state management (recommended)
- `bloc`: BLoC pattern for complex state
- `riverpod`: Modern state management solution
- `flutter_bloc`: Another BLoC implementation

### Navigation Options  
- `go_router`: Declarative navigation (recommended)
- `navigator_2_0`: Flutter's built-in navigation
- `auto_route`: Code generation-based routing

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── app_state.dart           # Global app state management
├── index.dart               # Export barrel file
├── backend/                 # Data layer
│   ├── schema/             
│   │   └── structs/        # Data structure definitions
│   ├── sqlite/             # SQLite database operations
│   └── api_requests/       # External API integrations
├── pages/                  # UI screens/pages
├── components/             # Reusable UI components
├── custom_code/            # Custom widgets and business logic
│   ├── widgets/           # Custom Flutter widgets
│   └── actions/           # Custom business logic actions
├── core/                   # Framework-agnostic core logic
│   ├── themes/            # Theme definitions
│   ├── navigation/        # Navigation configuration
│   └── utils/             # Utility functions
└── flutter_flow/          # FlutterFlow generated components (optional)
    ├── flutter_flow_theme.dart    # FlutterFlow theming
    ├── flutter_flow_widgets.dart  # FlutterFlow widget helpers
    ├── flutter_flow_model.dart    # FlutterFlow model classes
    └── nav/               # FlutterFlow navigation config
```

## Coding Patterns & Conventions

### Database Operations
- All data is stored locally in SQLite using the `SQLiteManager` class
- Database schemas are defined in `lib/backend/schema/structs/`
- Use struct classes for type-safe data handling
- Follow the existing pattern for CRUD operations

Example database struct pattern:
```dart
class ItemStruct extends BaseStruct {
  ItemStruct({
    String? itemId,
    String? name,
    String? category,
    // ... other fields
  }) : _itemId = itemId,
       _name = name,
       _category = category;

  // Getters and setters with null safety
  String? _itemId;
  String get itemId => _itemId ?? '';
  set itemId(String? val) => _itemId = val;
  bool hasItemId() => _itemId != null;
}
```

### AI Integration Patterns
- Google Gemini integration is handled through `flutter_gemini` package
- AI responses are parsed using custom functions
- Image analysis follows the pattern: capture image → send to AI → parse response → extract name/category

### Theming Patterns

#### FlutterFlow Approach (if using FlutterFlow)
```dart
// Access FlutterFlow theme
FlutterFlowTheme.of(context).primary
FlutterFlowTheme.of(context).bodyMedium
```

#### Standard Flutter Approach
```dart
// Use standard Flutter theming
Theme.of(context).colorScheme.primary
Theme.of(context).textTheme.bodyMedium

// Or create custom theme system
AppTheme.of(context).primary
AppTheme.of(context).bodyMedium
```

### Navigation Patterns

#### FlutterFlow Navigation (if using FlutterFlow)
```dart
context.pushNamed('PageName');
context.pop();
```

#### Standard go_router Navigation
```dart
context.go('/page-name');
context.push('/page-name');
GoRouter.of(context).pop();
```

#### Standard Navigator Navigation
```dart
Navigator.of(context).pushNamed('/page-name');
Navigator.of(context).pop();
```

### State Management

#### Provider Pattern (Recommended)
```dart
// Global state with Provider
class AppState extends ChangeNotifier {
  String? _selectedContainer;
  
  String? get selectedContainer => _selectedContainer;
  
  void setSelectedContainer(String? container) {
    _selectedContainer = container;
    notifyListeners();
  }
}

// Usage
Provider.of<AppState>(context).selectedContainer
context.read<AppState>().setSelectedContainer('container-id');
```

#### FlutterFlow App State (if using FlutterFlow)
```dart
// Access FlutterFlow global state
FFAppState().variableName

// Update FlutterFlow global state
FFAppState().update(() {
  FFAppState().variableName = newValue;
});
```

#### Page State Management

##### FlutterFlow Model Pattern
```dart
class PageNameModel extends FlutterFlowModel<PageNameWidget> {
  final unfocusNode = FocusNode();
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  
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

##### Standard Flutter State Management
```dart
class _PageNameState extends State<PageName> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textController = TextEditingController();
  
  bool _isLoading = false;
  String? _selectedValue;

  @override
  void dispose() {
    _focusNode.dispose();
    _textController.dispose();
    super.dispose();
  }
}
```

### Widget Patterns

#### Standard Flutter Widget Pattern
```dart
class CustomWidget extends StatefulWidget {
  const CustomWidget({
    Key? key,
    this.width,
    this.height,
    required this.onAction,
    this.data,
  }) : super(key: key);

  final double? width;
  final double? height;
  final VoidCallback onAction;
  final String? data;

  @override
  State<CustomWidget> createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton(
        onPressed: widget.onAction,
        child: Text(widget.data ?? 'Default Text'),
      ),
    );
  }
}
```

#### FlutterFlow Compatible Widget Pattern
```dart
class CustomWidget extends StatefulWidget {
  const CustomWidget({
    Key? key,
    this.width,
    this.height,
    required this.onAction, // FlutterFlow callback
  }) : super(key: key);

  final double? width;
  final double? height;
  final Future<dynamic> Function()? onAction; // FlutterFlow async callback

  @override
  _CustomWidgetState createState() => _CustomWidgetState();
}
```

### Error Handling
- Use try-catch blocks for database operations
- Provide user-friendly error messages
- Log errors for debugging while maintaining user experience
- Graceful degradation when AI features are unavailable

## Domain-Specific Context

### Container Management
- Containers have unique IDs and QR codes
- Containers can contain multiple items
- Support for container metadata (name, description, location, color, size)

### Item Tracking
- Items belong to containers (foreign key relationship)
- Items have names, categories, descriptions, and images
- Images stored as base64 strings in database
- Support for manual and AI-generated categorization

### QR Code Integration
- QR codes identify containers uniquely
- Integration with external QR sticker generator project
- Scanning triggers container selection/creation flow

### AI Features
- Automatic item name generation from images
- Category suggestions based on image analysis
- Fallback to manual entry when AI is unavailable
- Response parsing handles malformed AI responses gracefully

## Development Guidelines

### Adding New Features
1. Follow existing architectural patterns
2. Choose appropriate UI framework approach:
   - Use FlutterFlow for rapid prototyping and generated components
   - Use standard Flutter for complete control and customization
   - Use hybrid approach for specific needs
3. Implement custom logic in `custom_code/` or `core/` directory
4. Update database schema in `backend/schema/structs/` if needed
5. Add appropriate error handling and user feedback

### Migration from FlutterFlow to Standard Flutter
If transitioning away from FlutterFlow:

1. **Replace Theme System**:
   ```dart
   // From: FlutterFlowTheme.of(context).primary
   // To: Theme.of(context).colorScheme.primary
   ```

2. **Replace Navigation**:
   ```dart
   // From: context.pushNamed('PageName')
   // To: context.go('/page-name') // go_router
   // Or: Navigator.pushNamed(context, '/page-name') // Navigator
   ```

3. **Replace State Management**:
   ```dart
   // From: FFAppState().variable
   // To: Provider.of<AppState>(context).variable
   ```

4. **Replace Custom Widgets**:
   - Move from `flutter_flow/` generated widgets to custom implementations
   - Replace `FFButtonWidget` with standard `ElevatedButton`
   - Replace FlutterFlow form fields with standard Flutter forms

### Database Schema Changes
1. Update struct definitions in `backend/schema/structs/`
2. Implement migration logic in `SQLiteManager`
3. Test with existing data to ensure backward compatibility
4. Update related UI components and business logic

### UI Development
1. Choose between FlutterFlow and standard Flutter approach
2. Leverage appropriate theme system (FlutterFlow or standard)
3. Use consistent spacing and typography
4. Ensure responsive design for different screen sizes
5. Follow Material Design principles (or chosen design system)
6. Test on actual Android devices

### Button Implementation Examples

#### Standard Flutter Approach
```dart
ElevatedButton(
  onPressed: () => _handleAction(),
  style: ElevatedButton.styleFrom(
    backgroundColor: Theme.of(context).colorScheme.primary,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
  child: Text(
    'Button Text',
    style: Theme.of(context).textTheme.labelLarge?.copyWith(
      color: Theme.of(context).colorScheme.onPrimary,
    ),
  ),
)
```

#### FlutterFlow Approach
```dart
FFButtonWidget(
  onPressed: () async => _handleAction(),
  text: 'Button Text',
  options: FFButtonOptions(
    width: 200,
    height: 40,
    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
    color: FlutterFlowTheme.of(context).primary,
    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
      fontFamily: 'Readex Pro',
      color: Colors.white,
    ),
    elevation: 2,
    borderRadius: BorderRadius.circular(8),
  ),
)
```

### API Integration
1. Handle network failures gracefully
2. Implement proper error handling for external services
3. Use environment variables for API keys
4. Provide meaningful fallbacks when services are unavailable

## Testing Considerations

### Key Areas to Test
- Database operations (CRUD for containers and items)
- AI integration and response parsing
- QR code scanning functionality
- Image capture and storage
- Data backup and restore functionality
- Navigation between screens
- State persistence across app restarts

### Testing Patterns
- Unit tests for business logic functions
- Widget tests for custom components
- Integration tests for database operations
- Manual testing on Android devices for camera/QR functionality

## Common Gotchas

1. **FlutterFlow Regeneration**: Custom code in `flutter_flow/` directory may be overwritten when regenerating from FlutterFlow
2. **Framework Dependencies**: When migrating away from FlutterFlow, ensure all FlutterFlow-specific imports are replaced
3. **Theme Consistency**: When mixing FlutterFlow and standard Flutter, maintain consistent theming approach
4. **Image Storage**: Large images can impact database performance
5. **AI API Limits**: Handle rate limiting and quota exceeded scenarios
6. **QR Code Permissions**: Camera permissions required for scanning
7. **Database Size**: Consider cleanup strategies for large datasets
8. **Offline Usage**: App should work completely offline after initial setup
9. **State Management Migration**: When switching state management approaches, ensure all state access is updated consistently

## Performance Considerations

- Optimize image sizes before database storage
- Implement pagination for large item lists
- Use efficient SQLite queries with proper indexing
- Cache frequently accessed data
- Minimize AI API calls to reduce latency and costs

## Security & Privacy

- All data stored locally (no cloud storage by default)
- API keys should be stored securely
- User consent for camera/storage permissions
- Option to export/backup data maintains user control
- No tracking or analytics without explicit user consent