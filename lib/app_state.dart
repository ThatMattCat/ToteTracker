import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _geminiApiKey = prefs.getString('ff_geminiApiKey') ?? _geminiApiKey;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  /// Logged-In User's ID
  String _userId = 'GGGGGG';
  String get userId => _userId;
  set userId(String value) {
    _userId = value;
  }

  String _UserName = 'NONAME';
  String get UserName => _UserName;
  set UserName(String value) {
    _UserName = value;
  }

  String _geminiApiKey = '';
  String get geminiApiKey => _geminiApiKey;
  set geminiApiKey(String value) {
    _geminiApiKey = value;
    prefs.setString('ff_geminiApiKey', value);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
