// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LocationStruct extends BaseStruct {
  LocationStruct({
    int? locationId,
    String? userId,
    String? name,
    String? description,
    int? parentLocationId,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : _locationId = locationId,
        _userId = userId,
        _name = name,
        _description = description,
        _parentLocationId = parentLocationId,
        _createdAt = createdAt,
        _updatedAt = updatedAt;

  // "locationId" field.
  int? _locationId;
  int get locationId => _locationId ?? 0;
  set locationId(int? val) => _locationId = val;

  void incrementLocationId(int amount) => locationId = locationId + amount;

  bool hasLocationId() => _locationId != null;

  // "userId" field.
  String? _userId;
  String get userId => _userId ?? '';
  set userId(String? val) => _userId = val;

  bool hasUserId() => _userId != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "parentLocationId" field.
  int? _parentLocationId;
  int get parentLocationId => _parentLocationId ?? 0;
  set parentLocationId(int? val) => _parentLocationId = val;

  void incrementParentLocationId(int amount) =>
      parentLocationId = parentLocationId + amount;

  bool hasParentLocationId() => _parentLocationId != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  set createdAt(DateTime? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "updatedAt" field.
  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;
  set updatedAt(DateTime? val) => _updatedAt = val;

  bool hasUpdatedAt() => _updatedAt != null;

  static LocationStruct fromMap(Map<String, dynamic> data) => LocationStruct(
        locationId: castToType<int>(data['locationId']),
        userId: data['userId'] as String?,
        name: data['name'] as String?,
        description: data['description'] as String?,
        parentLocationId: castToType<int>(data['parentLocationId']),
        createdAt: data['createdAt'] as DateTime?,
        updatedAt: data['updatedAt'] as DateTime?,
      );

  static LocationStruct? maybeFromMap(dynamic data) =>
      data is Map ? LocationStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'locationId': _locationId,
        'userId': _userId,
        'name': _name,
        'description': _description,
        'parentLocationId': _parentLocationId,
        'createdAt': _createdAt,
        'updatedAt': _updatedAt,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'locationId': serializeParam(
          _locationId,
          ParamType.int,
        ),
        'userId': serializeParam(
          _userId,
          ParamType.String,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'parentLocationId': serializeParam(
          _parentLocationId,
          ParamType.int,
        ),
        'createdAt': serializeParam(
          _createdAt,
          ParamType.DateTime,
        ),
        'updatedAt': serializeParam(
          _updatedAt,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static LocationStruct fromSerializableMap(Map<String, dynamic> data) =>
      LocationStruct(
        locationId: deserializeParam(
          data['locationId'],
          ParamType.int,
          false,
        ),
        userId: deserializeParam(
          data['userId'],
          ParamType.String,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        parentLocationId: deserializeParam(
          data['parentLocationId'],
          ParamType.int,
          false,
        ),
        createdAt: deserializeParam(
          data['createdAt'],
          ParamType.DateTime,
          false,
        ),
        updatedAt: deserializeParam(
          data['updatedAt'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'LocationStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is LocationStruct &&
        locationId == other.locationId &&
        userId == other.userId &&
        name == other.name &&
        description == other.description &&
        parentLocationId == other.parentLocationId &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode => const ListEquality().hash([
        locationId,
        userId,
        name,
        description,
        parentLocationId,
        createdAt,
        updatedAt
      ]);
}

LocationStruct createLocationStruct({
  int? locationId,
  String? userId,
  String? name,
  String? description,
  int? parentLocationId,
  DateTime? createdAt,
  DateTime? updatedAt,
}) =>
    LocationStruct(
      locationId: locationId,
      userId: userId,
      name: name,
      description: description,
      parentLocationId: parentLocationId,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
