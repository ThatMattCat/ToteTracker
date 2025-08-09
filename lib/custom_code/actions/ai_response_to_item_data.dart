// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

//
import 'dart:convert';

/// Convert AI-Generated JSON'ish object to Item Name and Category
AiImageResponseStruct aiResponseToItemData(String aiResponse) {
  /// MODIFY CODE ONLY BELOW THIS LINE

  // Find the first opening curly brace '{' which indicates the start of the JSON object.
  final int startIndex = aiResponse.indexOf('{');

  // Find the last closing curly brace '}' which indicates the end of the JSON object.
  final int endIndex = aiResponse.lastIndexOf('}');

  // Check if both an opening and a closing brace were found in the correct order.
  if (startIndex == -1 || endIndex == -1 || endIndex < startIndex) {
    // If not, the string does not contain a valid JSON object.
    // Return an AiImageResponse with error information.
    // You can customize these default error messages.
    return AiImageResponseStruct(
      name: 'Parsing Error',
      category: 'Invalid AI response format.',
    );
  }

  // Extract the substring that likely contains the JSON object.
  final String jsonString = aiResponse.substring(startIndex, endIndex + 1);

  try {
    // Attempt to decode the extracted string into a JSON map.
    final dynamic decodedData = jsonDecode(jsonString);

    if (decodedData is Map<String, dynamic>) {
      // If decoding is successful, extract the 'name' and 'category' fields.
      // The '??' operator provides a default value if a key is not found.
      final String name = decodedData['name'] as String? ?? 'No Name Found';
      final String category =
          decodedData['category'] as String? ?? 'No Category Found';

      // Create an instance of your custom data type and return it.
      return AiImageResponseStruct(
        name: name,
        category: category,
      );
    } else {
      // Handle cases where the decoded JSON is not a map
      return AiImageResponseStruct(
        name: 'Parsing Error',
        category: 'JSON is not a valid object.',
      );
    }
  } catch (e) {
    // If an error occurs during JSON decoding (e.g., malformed JSON),
    // catch the exception and return an AiImageResponse with error information.
    return AiImageResponseStruct(
      name: 'Parsing Error',
      category: 'Failed to decode JSON: ${e.toString()}',
    );
  }

  /// MODIFY CODE ONLY ABOVE THIS LINE
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
