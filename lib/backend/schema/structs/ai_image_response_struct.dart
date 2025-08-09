// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// Gemini Response Containing a generated name and category
class AiImageResponseStruct extends BaseStruct {
  AiImageResponseStruct({
    /// Name of the object
    String? name,

    /// A single category
    String? category,
  })  : _name = name,
        _category = category;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  set category(String? val) => _category = val;

  bool hasCategory() => _category != null;

  static AiImageResponseStruct fromMap(Map<String, dynamic> data) =>
      AiImageResponseStruct(
        name: data['name'] as String?,
        category: data['category'] as String?,
      );

  static AiImageResponseStruct? maybeFromMap(dynamic data) => data is Map
      ? AiImageResponseStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'category': _category,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'category': serializeParam(
          _category,
          ParamType.String,
        ),
      }.withoutNulls;

  static AiImageResponseStruct fromSerializableMap(Map<String, dynamic> data) =>
      AiImageResponseStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        category: deserializeParam(
          data['category'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'AiImageResponseStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is AiImageResponseStruct &&
        name == other.name &&
        category == other.category;
  }

  @override
  int get hashCode => const ListEquality().hash([name, category]);
}

AiImageResponseStruct createAiImageResponseStruct({
  String? name,
  String? category,
}) =>
    AiImageResponseStruct(
      name: name,
      category: category,
    );
