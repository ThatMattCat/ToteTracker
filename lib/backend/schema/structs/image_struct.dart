// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ImageStruct extends BaseStruct {
  ImageStruct({
    int? imageId,
    String? filePath,
    String? thumbnailPath,
    String? mimeType,
    int? sizeBytes,
    int? width,
    int? height,
    DateTime? createdAt,
  })  : _imageId = imageId,
        _filePath = filePath,
        _thumbnailPath = thumbnailPath,
        _mimeType = mimeType,
        _sizeBytes = sizeBytes,
        _width = width,
        _height = height,
        _createdAt = createdAt;

  // "imageId" field.
  int? _imageId;
  int get imageId => _imageId ?? 0;
  set imageId(int? val) => _imageId = val;

  void incrementImageId(int amount) => imageId = imageId + amount;

  bool hasImageId() => _imageId != null;

  // "filePath" field.
  String? _filePath;
  String get filePath => _filePath ?? '';
  set filePath(String? val) => _filePath = val;

  bool hasFilePath() => _filePath != null;

  // "thumbnailPath" field.
  String? _thumbnailPath;
  String get thumbnailPath => _thumbnailPath ?? '';
  set thumbnailPath(String? val) => _thumbnailPath = val;

  bool hasThumbnailPath() => _thumbnailPath != null;

  // "mimeType" field.
  String? _mimeType;
  String get mimeType => _mimeType ?? '';
  set mimeType(String? val) => _mimeType = val;

  bool hasMimeType() => _mimeType != null;

  // "sizeBytes" field.
  int? _sizeBytes;
  int get sizeBytes => _sizeBytes ?? 0;
  set sizeBytes(int? val) => _sizeBytes = val;

  void incrementSizeBytes(int amount) => sizeBytes = sizeBytes + amount;

  bool hasSizeBytes() => _sizeBytes != null;

  // "width" field.
  int? _width;
  int get width => _width ?? 0;
  set width(int? val) => _width = val;

  void incrementWidth(int amount) => width = width + amount;

  bool hasWidth() => _width != null;

  // "height" field.
  int? _height;
  int get height => _height ?? 0;
  set height(int? val) => _height = val;

  void incrementHeight(int amount) => height = height + amount;

  bool hasHeight() => _height != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  set createdAt(DateTime? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  static ImageStruct fromMap(Map<String, dynamic> data) => ImageStruct(
        imageId: castToType<int>(data['imageId']),
        filePath: data['filePath'] as String?,
        thumbnailPath: data['thumbnailPath'] as String?,
        mimeType: data['mimeType'] as String?,
        sizeBytes: castToType<int>(data['sizeBytes']),
        width: castToType<int>(data['width']),
        height: castToType<int>(data['height']),
        createdAt: data['createdAt'] as DateTime?,
      );

  static ImageStruct? maybeFromMap(dynamic data) =>
      data is Map ? ImageStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'imageId': _imageId,
        'filePath': _filePath,
        'thumbnailPath': _thumbnailPath,
        'mimeType': _mimeType,
        'sizeBytes': _sizeBytes,
        'width': _width,
        'height': _height,
        'createdAt': _createdAt,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'imageId': serializeParam(
          _imageId,
          ParamType.int,
        ),
        'filePath': serializeParam(
          _filePath,
          ParamType.String,
        ),
        'thumbnailPath': serializeParam(
          _thumbnailPath,
          ParamType.String,
        ),
        'mimeType': serializeParam(
          _mimeType,
          ParamType.String,
        ),
        'sizeBytes': serializeParam(
          _sizeBytes,
          ParamType.int,
        ),
        'width': serializeParam(
          _width,
          ParamType.int,
        ),
        'height': serializeParam(
          _height,
          ParamType.int,
        ),
        'createdAt': serializeParam(
          _createdAt,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static ImageStruct fromSerializableMap(Map<String, dynamic> data) =>
      ImageStruct(
        imageId: deserializeParam(
          data['imageId'],
          ParamType.int,
          false,
        ),
        filePath: deserializeParam(
          data['filePath'],
          ParamType.String,
          false,
        ),
        thumbnailPath: deserializeParam(
          data['thumbnailPath'],
          ParamType.String,
          false,
        ),
        mimeType: deserializeParam(
          data['mimeType'],
          ParamType.String,
          false,
        ),
        sizeBytes: deserializeParam(
          data['sizeBytes'],
          ParamType.int,
          false,
        ),
        width: deserializeParam(
          data['width'],
          ParamType.int,
          false,
        ),
        height: deserializeParam(
          data['height'],
          ParamType.int,
          false,
        ),
        createdAt: deserializeParam(
          data['createdAt'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'ImageStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ImageStruct &&
        imageId == other.imageId &&
        filePath == other.filePath &&
        thumbnailPath == other.thumbnailPath &&
        mimeType == other.mimeType &&
        sizeBytes == other.sizeBytes &&
        width == other.width &&
        height == other.height &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode => const ListEquality().hash([
        imageId,
        filePath,
        thumbnailPath,
        mimeType,
        sizeBytes,
        width,
        height,
        createdAt
      ]);
}

ImageStruct createImageStruct({
  int? imageId,
  String? filePath,
  String? thumbnailPath,
  String? mimeType,
  int? sizeBytes,
  int? width,
  int? height,
  DateTime? createdAt,
}) =>
    ImageStruct(
      imageId: imageId,
      filePath: filePath,
      thumbnailPath: thumbnailPath,
      mimeType: mimeType,
      sizeBytes: sizeBytes,
      width: width,
      height: height,
      createdAt: createdAt,
    );
