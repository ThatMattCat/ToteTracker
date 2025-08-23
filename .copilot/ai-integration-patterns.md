# AI Integration Patterns

This file provides GitHub Copilot with specific context about ToteTracker's AI integration patterns, focusing on Google Gemini for image analysis and automatic categorization. These patterns are designed to work with both FlutterFlow and standard Flutter approaches.

## AI Architecture Overview

### Purpose
- **Automatic Item Naming**: Generate descriptive names from item photos
- **Category Suggestion**: Suggest appropriate categories based on image content
- **User Experience**: Reduce manual data entry and improve consistency
- **Offline Fallback**: Graceful degradation when AI services are unavailable

### Technology Stack
- **Google Gemini AI**: Primary AI service for image analysis
- **flutter_gemini Package**: Flutter integration for Gemini API
- **Framework-Agnostic Services**: Services that work with any UI framework
- **Base64 Image Processing**: Convert images for API transmission
- **JSON Response Parsing**: Extract structured data from AI responses
- **Error Handling**: Robust error handling with fallback options

## AI Response Structure

### Framework-Agnostic Response Model
```dart
/// AI Image Analysis Response Model (Works with any framework)
class AIImageResponse {
  final String name;
  final String category;
  final double? confidence;
  final List<String>? alternativeNames;
  final List<String>? alternativeCategories;

  const AIImageResponse({
    required this.name,
    required this.category,
    this.confidence,
    this.alternativeNames,
    this.alternativeCategories,
  });

  factory AIImageResponse.fromJson(Map<String, dynamic> json) {
    return AIImageResponse(
      name: json['name']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      confidence: json['confidence']?.toDouble(),
      alternativeNames: (json['alternativeNames'] as List?)
          ?.map((e) => e.toString())
          .toList(),
      alternativeCategories: (json['alternativeCategories'] as List?)
          ?.map((e) => e.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      if (confidence != null) 'confidence': confidence,
      if (alternativeNames != null) 'alternativeNames': alternativeNames,
      if (alternativeCategories != null) 'alternativeCategories': alternativeCategories,
    };
  }

  bool get isEmpty => name.isEmpty && category.isEmpty;
  bool get isValid => name.isNotEmpty || category.isNotEmpty;
}
```

### FlutterFlow Compatible Struct (If using FlutterFlow)
```dart
/// Gemini Response Struct for FlutterFlow compatibility
class AiImageResponseStruct extends BaseStruct {
  AiImageResponseStruct({
    /// Name of the object
    String? name,
    /// A single category
    String? category,
  }) : _name = name,
       _category = category;

  // Standard getter/setter pattern
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;
  bool hasName() => _name != null;

  String? _category;
  String get category => _category ?? '';
  set category(String? val) => _category = val;
  bool hasCategory() => _category != null;

  // Convert to framework-agnostic model
  AIImageResponse toAIImageResponse() {
    return AIImageResponse(
      name: name,
      category: category,
    );
  }

  // Create from framework-agnostic model
  factory AiImageResponseStruct.fromAIImageResponse(AIImageResponse response) {
    return AiImageResponseStruct(
      name: response.name,
      category: response.category,
    );
  }
}
```

### Expected AI Response Format
```json
{
  "name": "Red Coffee Mug",
  "category": "Kitchen & Dining"
}
```

## AI Integration Patterns

### Image Analysis Workflow
```dart
// Complete workflow for AI-powered item analysis
Future<AiImageResponseStruct?> analyzeItemImage(XFile imageFile) async {
  try {
    // 1. Convert image to base64
    final bytes = await imageFile.readAsBytes();
    final base64Image = base64Encode(bytes);
    
    // 2. Prepare AI prompt
    final prompt = '''
    Analyze this image and provide a JSON response with the item's name and category.
    Format: {"name": "descriptive name", "category": "category"}
    Be specific and descriptive for the name, use common category names.
    ''';
    
    // 3. Send to Gemini AI
    final response = await Gemini.instance.textAndImage(
      text: prompt,
      images: [bytes],
    );
    
    // 4. Parse response
    if (response?.content?.parts?.isNotEmpty == true) {
      final aiText = response!.content!.parts!.first.text ?? '';
      return aiImageResponseToNameCategory(aiText);
    }
    
    return null;
  } catch (e) {
    print('AI analysis error: $e');
    return AiImageResponseStruct(
      name: 'Analysis Failed',
      category: 'Error occurred during AI processing',
    );
  }
}
```

### AI Response Parsing Pattern
```dart
/// Convert AI-Generated JSON'ish object to Item Name and Category
AiImageResponseStruct? aiImageResponseToNameCategory(String aiResponse) {
  // Find JSON boundaries in potentially messy AI response
  final int startIndex = aiResponse.indexOf('{');
  final int endIndex = aiResponse.lastIndexOf('}');
  
  // Validate JSON boundaries exist
  if (startIndex == -1 || endIndex == -1 || endIndex < startIndex) {
    return AiImageResponseStruct(
      name: 'Parsing Error',
      category: 'Invalid AI response format.',
    );
  }
  
  // Extract JSON substring
  final String jsonString = aiResponse.substring(startIndex, endIndex + 1);
  
  try {
    // Parse JSON
    final dynamic decodedData = jsonDecode(jsonString);
    
    if (decodedData is Map<String, dynamic>) {
      // Extract fields with fallbacks
      final String name = decodedData['name'] as String? ?? 'No Name Found';
      final String category = decodedData['category'] as String? ?? 'No Category Found';
      
      return AiImageResponseStruct(
        name: name,
        category: category,
      );
    } else {
      return AiImageResponseStruct(
        name: 'Parsing Error',
        category: 'JSON is not a valid object.',
      );
    }
  } catch (e) {
    return AiImageResponseStruct(
      name: 'Parsing Error',
      category: 'Failed to decode JSON: ${e.toString()}',
    );
  }
}
```

## Configuration Patterns

### API Key Management
```dart
// API keys stored in environment or preferences
class AIConfiguration {
  static String? _geminiApiKey;
  
  static Future<void> initializeGemini() async {
    // Get API key from secure storage
    _geminiApiKey = await getGeminiApiKey();
    
    if (_geminiApiKey != null && _geminiApiKey!.isNotEmpty) {
      Gemini.init(apiKey: _geminiApiKey!);
    }
  }
  
  static bool get isGeminiConfigured => 
    _geminiApiKey != null && _geminiApiKey!.isNotEmpty;
  
  static Future<String?> getGeminiApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('gemini_api_key');
  }
  
  static Future<void> setGeminiApiKey(String apiKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('gemini_api_key', apiKey);
    _geminiApiKey = apiKey;
    
    if (apiKey.isNotEmpty) {
      Gemini.init(apiKey: apiKey);
    }
  }
}
```

### Graceful Degradation
```dart
// Handle scenarios when AI is unavailable
Future<void> addItemWithOptionalAI({
  required XFile imageFile,
  required String containerId,
  String? manualName,
  String? manualCategory,
}) async {
  String itemName = manualName ?? '';
  String itemCategory = manualCategory ?? '';
  
  // Try AI analysis if configured and no manual input
  if (AIConfiguration.isGeminiConfigured && 
      (itemName.isEmpty || itemCategory.isEmpty)) {
    try {
      final aiResult = await analyzeItemImage(imageFile);
      
      if (aiResult != null) {
        itemName = itemName.isEmpty ? aiResult.name : itemName;
        itemCategory = itemCategory.isEmpty ? aiResult.category : itemCategory;
        
        // Show AI suggestion to user for confirmation
        await showAISuggestionDialog(
          context: context,
          suggestedName: aiResult.name,
          suggestedCategory: aiResult.category,
          onAccept: (name, category) {
            itemName = name;
            itemCategory = category;
          },
        );
      }
    } catch (e) {
      // AI failed, fall back to manual entry
      print('AI analysis failed, using manual entry: $e');
    }
  }
  
  // Save item with available data
  await saveItemToDatabase(
    name: itemName.isNotEmpty ? itemName : 'Unnamed Item',
    category: itemCategory.isNotEmpty ? itemCategory : 'Uncategorized',
    containerId: containerId,
    imageFile: imageFile,
  );
}
```

## Error Handling Patterns

### AI Service Error Types
```dart
enum AIErrorType {
  networkError,
  apiKeyInvalid,
  rateLimitExceeded,
  responseParsingError,
  serviceUnavailable,
  imageProcessingError,
}

class AIException implements Exception {
  final AIErrorType type;
  final String message;
  final dynamic originalError;
  
  AIException(this.type, this.message, [this.originalError]);
  
  @override
  String toString() => 'AIException: $message';
}
```

### Comprehensive Error Handling
```dart
Future<AiImageResponseStruct?> robustAIAnalysis(XFile imageFile) async {
  try {
    // Check if AI is configured
    if (!AIConfiguration.isGeminiConfigured) {
      throw AIException(
        AIErrorType.apiKeyInvalid,
        'Gemini API key not configured',
      );
    }
    
    // Validate image file
    final bytes = await imageFile.readAsBytes();
    if (bytes.isEmpty) {
      throw AIException(
        AIErrorType.imageProcessingError,
        'Image file is empty or corrupted',
      );
    }
    
    // Call AI service with timeout
    final response = await Future.timeout(
      Gemini.instance.textAndImage(
        text: getItemAnalysisPrompt(),
        images: [bytes],
      ),
      Duration(seconds: 30),
    );
    
    // Process response
    if (response?.content?.parts?.isNotEmpty == true) {
      final aiText = response!.content!.parts!.first.text ?? '';
      final result = aiImageResponseToNameCategory(aiText);
      
      if (result != null && !result.name.contains('Error')) {
        return result;
      }
    }
    
    throw AIException(
      AIErrorType.responseParsingError,
      'Failed to parse valid response from AI',
    );
    
  } on TimeoutException {
    throw AIException(
      AIErrorType.networkError,
      'AI service request timed out',
    );
  } on SocketException {
    throw AIException(
      AIErrorType.networkError,
      'Network connection error',
    );
  } catch (e) {
    if (e is AIException) rethrow;
    
    throw AIException(
      AIErrorType.serviceUnavailable,
      'Unexpected error during AI analysis',
      e,
    );
  }
}
```

## Prompt Engineering Patterns

### Structured Prompts
```dart
String getItemAnalysisPrompt() {
  return '''
Analyze this image of an item and provide a JSON response with the following structure:
{
  "name": "specific_item_name",
  "category": "general_category"
}

Guidelines:
- Name should be descriptive and specific (e.g., "Red Coffee Mug" not just "Mug")
- Category should be broad and useful for organization (e.g., "Kitchen & Dining", "Tools", "Clothing")
- Use common, everyday language
- If multiple items are visible, focus on the most prominent one
- Respond ONLY with valid JSON, no additional text

Example categories: Kitchen & Dining, Tools & Hardware, Clothing & Accessories, Electronics, Books & Media, Toys & Games, Sports & Recreation, Home & Garden, Office Supplies, Personal Care
''';
}

String getCategoryOnlyPrompt(String itemName) {
  return '''
Given the item name "$itemName", suggest the most appropriate category from this list:
Kitchen & Dining, Tools & Hardware, Clothing & Accessories, Electronics, Books & Media, Toys & Games, Sports & Recreation, Home & Garden, Office Supplies, Personal Care, Automotive, Health & Beauty, Cleaning Supplies, Arts & Crafts, Seasonal Items

Respond with JSON format:
{
  "category": "selected_category"
}
''';
}
```

### Response Validation
```dart
bool isValidAIResponse(AiImageResponseStruct? response) {
  if (response == null) return false;
  
  // Check for error indicators
  final errorKeywords = ['error', 'failed', 'parsing', 'invalid'];
  final name = response.name.toLowerCase();
  final category = response.category.toLowerCase();
  
  for (final keyword in errorKeywords) {
    if (name.contains(keyword) || category.contains(keyword)) {
      return false;
    }
  }
  
  // Check for minimum content requirements
  return response.name.trim().isNotEmpty && 
         response.category.trim().isNotEmpty &&
         response.name.length > 2 &&
         response.category.length > 2;
}
```

## Performance Optimization

### AI Request Caching
```dart
class AIResponseCache {
  static final Map<String, AiImageResponseStruct> _cache = {};
  static const int maxCacheSize = 100;
  
  static String _getImageHash(Uint8List imageBytes) {
    return md5.convert(imageBytes).toString();
  }
  
  static AiImageResponseStruct? getCachedResponse(Uint8List imageBytes) {
    final hash = _getImageHash(imageBytes);
    return _cache[hash];
  }
  
  static void cacheResponse(Uint8List imageBytes, AiImageResponseStruct response) {
    final hash = _getImageHash(imageBytes);
    
    // Simple LRU cache management
    if (_cache.length >= maxCacheSize) {
      final firstKey = _cache.keys.first;
      _cache.remove(firstKey);
    }
    
    _cache[hash] = response;
  }
}
```

### Batch Processing
```dart
Future<List<AiImageResponseStruct?>> analyzeMultipleImages(
  List<XFile> imageFiles,
) async {
  final results = <AiImageResponseStruct?>[];
  
  // Process in batches to avoid rate limiting
  const batchSize = 3;
  for (int i = 0; i < imageFiles.length; i += batchSize) {
    final batch = imageFiles.skip(i).take(batchSize).toList();
    
    final batchResults = await Future.wait(
      batch.map((file) => analyzeItemImage(file)),
    );
    
    results.addAll(batchResults);
    
    // Add delay between batches
    if (i + batchSize < imageFiles.length) {
      await Future.delayed(Duration(seconds: 2));
    }
  }
  
  return results;
}
```

## User Experience Patterns

### AI Suggestion UI
```dart
Widget buildAISuggestionCard(AiImageResponseStruct suggestion) {
  return Card(
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome, color: FlutterFlowTheme.of(context).primary),
              SizedBox(width: 8),
              Text(
                'AI Suggestion',
                style: FlutterFlowTheme.of(context).labelMedium,
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'Name: ${suggestion.name}',
            style: FlutterFlowTheme.of(context).bodyLarge,
          ),
          SizedBox(height: 4),
          Text(
            'Category: ${suggestion.category}',
            style: FlutterFlowTheme.of(context).bodyMedium,
          ),
          SizedBox(height: 12),
          Row(
            children: [
              ElevatedButton(
                onPressed: () => acceptSuggestion(suggestion),
                child: Text('Use Suggestion'),
              ),
              SizedBox(width: 8),
              TextButton(
                onPressed: () => rejectSuggestion(),
                child: Text('Enter Manually'),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
```

## Common AI Integration Gotchas

1. **API Rate Limits**: Implement proper delays and retry logic
2. **Response Variability**: AI responses may not always follow exact format
3. **Network Dependencies**: Always provide offline fallbacks
4. **Cost Management**: Monitor API usage and implement caching
5. **User Expectations**: Make AI suggestions optional, not mandatory
6. **Privacy Concerns**: Clearly communicate what data is sent to AI services
7. **Language Support**: Consider multilingual scenarios
8. **Image Quality**: Poor quality images produce poor AI results