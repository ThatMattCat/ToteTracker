// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ItemStruct extends BaseStruct {
  ItemStruct({
    String? name,
    int? itemId,
    String? containerId,
    String? description,
    int? quantity,
    String? category,
    double? value,
    DateTime? purchaseDate,
    DateTime? expiryDate,
    String? imagePath,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : _name = name,
        _itemId = itemId,
        _containerId = containerId,
        _description = description,
        _quantity = quantity,
        _category = category,
        _value = value,
        _purchaseDate = purchaseDate,
        _expiryDate = expiryDate,
        _imagePath = imagePath,
        _createdAt = createdAt,
        _updatedAt = updatedAt;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "itemId" field.
  int? _itemId;
  int get itemId => _itemId ?? 0;
  set itemId(int? val) => _itemId = val;

  void incrementItemId(int amount) => itemId = itemId + amount;

  bool hasItemId() => _itemId != null;

  // "containerId" field.
  String? _containerId;
  String get containerId => _containerId ?? '';
  set containerId(String? val) => _containerId = val;

  bool hasContainerId() => _containerId != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "quantity" field.
  int? _quantity;
  int get quantity => _quantity ?? 0;
  set quantity(int? val) => _quantity = val;

  void incrementQuantity(int amount) => quantity = quantity + amount;

  bool hasQuantity() => _quantity != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  set category(String? val) => _category = val;

  bool hasCategory() => _category != null;

  // "value" field.
  double? _value;
  double get value => _value ?? 0.0;
  set value(double? val) => _value = val;

  void incrementValue(double amount) => value = value + amount;

  bool hasValue() => _value != null;

  // "purchaseDate" field.
  DateTime? _purchaseDate;
  DateTime? get purchaseDate => _purchaseDate;
  set purchaseDate(DateTime? val) => _purchaseDate = val;

  bool hasPurchaseDate() => _purchaseDate != null;

  // "expiryDate" field.
  DateTime? _expiryDate;
  DateTime? get expiryDate => _expiryDate;
  set expiryDate(DateTime? val) => _expiryDate = val;

  bool hasExpiryDate() => _expiryDate != null;

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

  static ItemStruct fromMap(Map<String, dynamic> data) => ItemStruct(
        name: data['name'] as String?,
        itemId: castToType<int>(data['itemId']),
        containerId: data['containerId'] as String?,
        description: data['description'] as String?,
        quantity: castToType<int>(data['quantity']),
        category: data['category'] as String?,
        value: castToType<double>(data['value']),
        purchaseDate: data['purchaseDate'] as DateTime?,
        expiryDate: data['expiryDate'] as DateTime?,
        imagePath: data['imagePath'] as String?,
        createdAt: data['createdAt'] as DateTime?,
        updatedAt: data['updatedAt'] as DateTime?,
      );

  static ItemStruct? maybeFromMap(dynamic data) =>
      data is Map ? ItemStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'itemId': _itemId,
        'containerId': _containerId,
        'description': _description,
        'quantity': _quantity,
        'category': _category,
        'value': _value,
        'purchaseDate': _purchaseDate,
        'expiryDate': _expiryDate,
        'imagePath': _imagePath,
        'createdAt': _createdAt,
        'updatedAt': _updatedAt,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'itemId': serializeParam(
          _itemId,
          ParamType.int,
        ),
        'containerId': serializeParam(
          _containerId,
          ParamType.String,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'quantity': serializeParam(
          _quantity,
          ParamType.int,
        ),
        'category': serializeParam(
          _category,
          ParamType.String,
        ),
        'value': serializeParam(
          _value,
          ParamType.double,
        ),
        'purchaseDate': serializeParam(
          _purchaseDate,
          ParamType.DateTime,
        ),
        'expiryDate': serializeParam(
          _expiryDate,
          ParamType.DateTime,
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

  static ItemStruct fromSerializableMap(Map<String, dynamic> data) =>
      ItemStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        itemId: deserializeParam(
          data['itemId'],
          ParamType.int,
          false,
        ),
        containerId: deserializeParam(
          data['containerId'],
          ParamType.String,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        quantity: deserializeParam(
          data['quantity'],
          ParamType.int,
          false,
        ),
        category: deserializeParam(
          data['category'],
          ParamType.String,
          false,
        ),
        value: deserializeParam(
          data['value'],
          ParamType.double,
          false,
        ),
        purchaseDate: deserializeParam(
          data['purchaseDate'],
          ParamType.DateTime,
          false,
        ),
        expiryDate: deserializeParam(
          data['expiryDate'],
          ParamType.DateTime,
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
  String toString() => 'ItemStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ItemStruct &&
        name == other.name &&
        itemId == other.itemId &&
        containerId == other.containerId &&
        description == other.description &&
        quantity == other.quantity &&
        category == other.category &&
        value == other.value &&
        purchaseDate == other.purchaseDate &&
        expiryDate == other.expiryDate &&
        imagePath == other.imagePath &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode => const ListEquality().hash([
        name,
        itemId,
        containerId,
        description,
        quantity,
        category,
        value,
        purchaseDate,
        expiryDate,
        imagePath,
        createdAt,
        updatedAt
      ]);
}

ItemStruct createItemStruct({
  String? name,
  int? itemId,
  String? containerId,
  String? description,
  int? quantity,
  String? category,
  double? value,
  DateTime? purchaseDate,
  DateTime? expiryDate,
  String? imagePath,
  DateTime? createdAt,
  DateTime? updatedAt,
}) =>
    ItemStruct(
      name: name,
      itemId: itemId,
      containerId: containerId,
      description: description,
      quantity: quantity,
      category: category,
      value: value,
      purchaseDate: purchaseDate,
      expiryDate: expiryDate,
      imagePath: imagePath,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
