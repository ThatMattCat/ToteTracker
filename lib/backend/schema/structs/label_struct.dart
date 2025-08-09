// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LabelStruct extends BaseStruct {
  LabelStruct({
    int? labelId,
    String? name,
    String? color,
    String? userId,
    DateTime? createdAt,
  })  : _labelId = labelId,
        _name = name,
        _color = color,
        _userId = userId,
        _createdAt = createdAt;

  // "labelId" field.
  int? _labelId;
  int get labelId => _labelId ?? 0;
  set labelId(int? val) => _labelId = val;

  void incrementLabelId(int amount) => labelId = labelId + amount;

  bool hasLabelId() => _labelId != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "color" field.
  String? _color;
  String get color => _color ?? '';
  set color(String? val) => _color = val;

  bool hasColor() => _color != null;

  // "userId" field.
  String? _userId;
  String get userId => _userId ?? '';
  set userId(String? val) => _userId = val;

  bool hasUserId() => _userId != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  set createdAt(DateTime? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  static LabelStruct fromMap(Map<String, dynamic> data) => LabelStruct(
        labelId: castToType<int>(data['labelId']),
        name: data['name'] as String?,
        color: data['color'] as String?,
        userId: data['userId'] as String?,
        createdAt: data['createdAt'] as DateTime?,
      );

  static LabelStruct? maybeFromMap(dynamic data) =>
      data is Map ? LabelStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'labelId': _labelId,
        'name': _name,
        'color': _color,
        'userId': _userId,
        'createdAt': _createdAt,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'labelId': serializeParam(
          _labelId,
          ParamType.int,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'color': serializeParam(
          _color,
          ParamType.String,
        ),
        'userId': serializeParam(
          _userId,
          ParamType.String,
        ),
        'createdAt': serializeParam(
          _createdAt,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static LabelStruct fromSerializableMap(Map<String, dynamic> data) =>
      LabelStruct(
        labelId: deserializeParam(
          data['labelId'],
          ParamType.int,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        color: deserializeParam(
          data['color'],
          ParamType.String,
          false,
        ),
        userId: deserializeParam(
          data['userId'],
          ParamType.String,
          false,
        ),
        createdAt: deserializeParam(
          data['createdAt'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'LabelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is LabelStruct &&
        labelId == other.labelId &&
        name == other.name &&
        color == other.color &&
        userId == other.userId &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([labelId, name, color, userId, createdAt]);
}

LabelStruct createLabelStruct({
  int? labelId,
  String? name,
  String? color,
  String? userId,
  DateTime? createdAt,
}) =>
    LabelStruct(
      labelId: labelId,
      name: name,
      color: color,
      userId: userId,
      createdAt: createdAt,
    );
