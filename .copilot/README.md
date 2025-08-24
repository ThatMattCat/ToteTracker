# ToteTracker Copilot Context Summary

This directory contains comprehensive GitHub Copilot instructions for ToteTracker development. Each file provides specific context for different aspects of the codebase.

## Files Overview

### 📋 [`instructions.md`](./instructions.md)
**Main development instructions and project overview**
- Project architecture and technology stack
- Core development patterns and conventions
- Domain-specific context (containers, items, AI features)
- Development guidelines and best practices
- Common gotchas and performance considerations

### 🎨 [`flutterflow-patterns.md`](./flutterflow-patterns.md)
**FlutterFlow integration patterns and conventions**
- Theme system usage and color schemes
- Widget development patterns
- Navigation and routing patterns
- State management with FlutterFlow models
- Custom widget creation and styling

### 🗃️ [`database-patterns.md`](./database-patterns.md)
**SQLite database operations and data management**
- Database schema and entity relationships
- SQLiteManager singleton pattern
- CRUD operation patterns
- Data structure definitions (structs)
- Transaction handling and error management
- Image storage (base64) patterns

### 🤖 [`ai-integration-patterns.md`](./ai-integration-patterns.md)
**Google Gemini AI integration and image analysis**
- AI workflow patterns (image → analysis → parsing)
- Response parsing and error handling
- Configuration and API key management
- Graceful degradation when AI is unavailable
- Prompt engineering and response validation
- Performance optimization and caching

### 🧩 [`custom-components.md`](./custom-components.md)
**Custom widgets and FlutterFlow extensions**
- Custom widget development patterns
- FlutterFlow integration for custom code
- File conversion utilities (base64, image handling)
- Database operation widgets
- Callback patterns and state management
- Performance and memory management

### 🧪 [`testing-debugging.md`](./testing-debugging.md)
**Testing strategies and debugging approaches**
- Unit testing patterns (database, AI, widgets)
- Integration testing for complete workflows
- Debug logging and performance monitoring
- Error boundary patterns
- Test data management and mocking
- Manual testing strategies

## Quick Reference

### Key Architectural Patterns
```dart
// SQLite singleton
SQLiteManager.instance.methodName()

// FlutterFlow theming
FlutterFlowTheme.of(context).primary

// AI integration
analyzeImageWithGemini(apiKey, imageFile, prompt)

// Custom widget structure
class CustomWidget extends StatefulWidget {
  // FlutterFlow parameters
  final double? width;
  final double? height;
  final Future<dynamic> Function()? onCallback;
}
```

### Common Imports
```dart
// Standard FlutterFlow custom code imports
import '/backend/schema/structs/index.dart';
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart';
import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';
import 'package:flutter/material.dart';
```

### Directory Structure
```
lib/
├── main.dart                    # App entry point
├── app_state.dart              # Global state management
├── backend/                    # Data layer
│   ├── schema/structs/        # Data structures
│   ├── sqlite/                # Database operations
│   └── api_requests/          # External APIs
├── pages/                     # UI screens
├── components/                # Reusable UI components
├── custom_code/               # Custom FlutterFlow extensions
│   ├── widgets/              # Custom widgets
│   └── actions/              # Custom business logic
└── flutter_flow/             # FlutterFlow generated code
    ├── flutter_flow_theme.dart
    ├── flutter_flow_widgets.dart
    └── nav/                  # Navigation configuration
```

## Development Workflow

1. **Start with FlutterFlow**: Use FlutterFlow for UI components and basic logic
2. **Extend with Custom Code**: Add complex business logic in `custom_code/`
3. **Follow Patterns**: Use established patterns for database, AI, and UI operations
4. **Test Thoroughly**: Unit test business logic, integration test workflows
5. **Handle Errors Gracefully**: Provide fallbacks for AI and network operations
6. **Optimize Performance**: Consider database size, image optimization, and caching

## Key Principles

- **Local-First**: All data stored locally in SQLite
- **AI-Enhanced**: Optional AI features with manual fallbacks
- **FlutterFlow Integration**: Extend rather than replace FlutterFlow patterns
- **Error Resilience**: Graceful handling of failures and edge cases
- **User Privacy**: No cloud storage by default, user controls data
- **Performance**: Optimize for mobile devices with limited resources

## Getting Started

When working on ToteTracker:

1. **Read the main instructions** (`instructions.md`) for project overview
2. **Check relevant pattern files** for specific implementation guidance
3. **Follow established conventions** for consistency
4. **Test your changes** using provided testing patterns
5. **Consider performance implications** for mobile users

This context will help GitHub Copilot provide more accurate and consistent suggestions that align with ToteTracker's architecture and development practices.