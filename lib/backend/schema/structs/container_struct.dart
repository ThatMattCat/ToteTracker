// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ContainerStruct extends BaseStruct {
  ContainerStruct({
    String? containerId,
    String? userId,
    String? containerNumber,
    String? name,
    String? description,
    int? locationId,
    String? color,
    String? size,
    String? containerType,
    String? qrCode,
    String? imagePath,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : _containerId = containerId,
        _userId = userId,
        _containerNumber = containerNumber,
        _name = name,
        _description = description,
        _locationId = locationId,
        _color = color,
        _size = size,
        _containerType = containerType,
        _qrCode = qrCode,
        _imagePath = imagePath,
        _createdAt = createdAt,
        _updatedAt = updatedAt;

  // "containerId" field.
  String? _containerId;
  String get containerId => _containerId ?? '';
  set containerId(String? val) => _containerId = val;

  bool hasContainerId() => _containerId != null;

  // "userId" field.
  String? _userId;
  String get userId => _userId ?? '';
  set userId(String? val) => _userId = val;

  bool hasUserId() => _userId != null;

  // "containerNumber" field.
  String? _containerNumber;
  String get containerNumber => _containerNumber ?? '';
  set containerNumber(String? val) => _containerNumber = val;

  bool hasContainerNumber() => _containerNumber != null;

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

  // "locationId" field.
  int? _locationId;
  int get locationId => _locationId ?? 0;
  set locationId(int? val) => _locationId = val;

  void incrementLocationId(int amount) => locationId = locationId + amount;

  bool hasLocationId() => _locationId != null;

  // "color" field.
  String? _color;
  String get color => _color ?? '';
  set color(String? val) => _color = val;

  bool hasColor() => _color != null;

  // "size" field.
  String? _size;
  String get size => _size ?? '';
  set size(String? val) => _size = val;

  bool hasSize() => _size != null;

  // "containerType" field.
  String? _containerType;
  String get containerType => _containerType ?? '';
  set containerType(String? val) => _containerType = val;

  bool hasContainerType() => _containerType != null;

  // "qrCode" field.
  String? _qrCode;
  String get qrCode => _qrCode ?? '';
  set qrCode(String? val) => _qrCode = val;

  bool hasQrCode() => _qrCode != null;

  // "imagePath" field.
  String? _imagePath;
  String get imagePath => _imagePath ?? '';
  set imagePath(String? val) => _imagePath = val;

  bool hasImagePath() => _imagePath != null;

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

  static ContainerStruct fromMap(Map<String, dynamic> data) => ContainerStruct(
        containerId: data['containerId'] as String?,
        userId: data['userId'] as String?,
        containerNumber: data['containerNumber'] as String?,
        name: data['name'] as String?,
        description: data['description'] as String?,
        locationId: castToType<int>(data['locationId']),
        color: data['color'] as String?,
        size: data['size'] as String?,
        containerType: data['containerType'] as String?,
        qrCode: data['qrCode'] as String?,
        imagePath: data['imagePath'] as String?,
        createdAt: data['createdAt'] as DateTime?,
        updatedAt: data['updatedAt'] as DateTime?,
      );

  static ContainerStruct? maybeFromMap(dynamic data) => data is Map
      ? ContainerStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'containerId': _containerId,
        'userId': _userId,
        'containerNumber': _containerNumber,
        'name': _name,
        'description': _description,
        'locationId': _locationId,
        'color': _color,
        'size': _size,
        'containerType': _containerType,
        'qrCode': _qrCode,
        'imagePath': _imagePath,
        'createdAt': _createdAt,
        'updatedAt': _updatedAt,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'containerId': serializeParam(
          _containerId,
          ParamType.String,
        ),
        'userId': serializeParam(
          _userId,
          ParamType.String,
        ),
        'containerNumber': serializeParam(
          _containerNumber,
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
        'locationId': serializeParam(
          _locationId,
          ParamType.int,
        ),
        'color': serializeParam(
          _color,
          ParamType.String,
        ),
        'size': serializeParam(
          _size,
          ParamType.String,
        ),
        'containerType': serializeParam(
          _containerType,
          ParamType.String,
        ),
        'qrCode': serializeParam(
          _qrCode,
          ParamType.String,
        ),
        'imagePath': serializeParam(
          _imagePath,
          ParamType.String,
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

  static ContainerStruct fromSerializableMap(Map<String, dynamic> data) =>
      ContainerStruct(
        containerId: deserializeParam(
          data['containerId'],
          ParamType.String,
          false,
        ),
        userId: deserializeParam(
          data['userId'],
          ParamType.String,
          false,
        ),
        containerNumber: deserializeParam(
          data['containerNumber'],
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
        locationId: deserializeParam(
          data['locationId'],
          ParamType.int,
          false,
        ),
        color: deserializeParam(
          data['color'],
          ParamType.String,
          false,
        ),
        size: deserializeParam(
          data['size'],
          ParamType.String,
          false,
        ),
        containerType: deserializeParam(
          data['containerType'],
          ParamType.String,
          false,
        ),
        qrCode: deserializeParam(
          data['qrCode'],
          ParamType.String,
          false,
        ),
        imagePath: deserializeParam(
          data['imagePath'],
          ParamType.String,
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
  String toString() => 'ContainerStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ContainerStruct &&
        containerId == other.containerId &&
        userId == other.userId &&
        containerNumber == other.containerNumber &&
        name == other.name &&
        description == other.description &&
        locationId == other.locationId &&
        color == other.color &&
        size == other.size &&
        containerType == other.containerType &&
        qrCode == other.qrCode &&
        imagePath == other.imagePath &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode => const ListEquality().hash([
        containerId,
        userId,
        containerNumber,
        name,
        description,
        locationId,
        color,
        size,
        containerType,
        qrCode,
        imagePath,
        createdAt,
        updatedAt
      ]);
}

ContainerStruct createContainerStruct({
  String? containerId,
  String? userId,
  String? containerNumber,
  String? name,
  String? description,
  int? locationId,
  String? color,
  String? size,
  String? containerType,
  String? qrCode,
  String? imagePath,
  DateTime? createdAt,
  DateTime? updatedAt,
}) =>
    ContainerStruct(
      containerId: containerId,
      userId: userId,
      containerNumber: containerNumber,
      name: name,
      description: description,
      locationId: locationId,
      color: color,
      size: size,
      containerType: containerType,
      qrCode: qrCode,
      imagePath: imagePath,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
