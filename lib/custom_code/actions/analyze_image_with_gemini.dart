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

import 'package:flutter_gemini/flutter_gemini.dart';
import 'dart:typed_data';

Future<String> analyzeImageWithGemini(
  String apiKey,
  FFUploadedFile imageFile,
  String prompt,
) async {
  // Add your function code here!

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
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
