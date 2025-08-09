// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class HistoricQueryStruct extends BaseStruct {
  HistoricQueryStruct({
    int? searchId,
    String? userId,
    String? searchQuery,
    String? searchType,
    DateTime? searchedAt,
  })  : _searchId = searchId,
        _userId = userId,
        _searchQuery = searchQuery,
        _searchType = searchType,
        _searchedAt = searchedAt;

  // "searchId" field.
  int? _searchId;
  int get searchId => _searchId ?? 0;
  set searchId(int? val) => _searchId = val;

  void incrementSearchId(int amount) => searchId = searchId + amount;

  bool hasSearchId() => _searchId != null;

  // "userId" field.
  String? _userId;
  String get userId => _userId ?? '';
  set userId(String? val) => _userId = val;

  bool hasUserId() => _userId != null;

  // "searchQuery" field.
  String? _searchQuery;
  String get searchQuery => _searchQuery ?? '';
  set searchQuery(String? val) => _searchQuery = val;

  bool hasSearchQuery() => _searchQuery != null;

  // "searchType" field.
  String? _searchType;
  String get searchType => _searchType ?? '';
  set searchType(String? val) => _searchType = val;

  bool hasSearchType() => _searchType != null;

  // "searchedAt" field.
  DateTime? _searchedAt;
  DateTime? get searchedAt => _searchedAt;
  set searchedAt(DateTime? val) => _searchedAt = val;

  bool hasSearchedAt() => _searchedAt != null;

  static HistoricQueryStruct fromMap(Map<String, dynamic> data) =>
      HistoricQueryStruct(
        searchId: castToType<int>(data['searchId']),
        userId: data['userId'] as String?,
        searchQuery: data['searchQuery'] as String?,
        searchType: data['searchType'] as String?,
        searchedAt: data['searchedAt'] as DateTime?,
      );

  static HistoricQueryStruct? maybeFromMap(dynamic data) => data is Map
      ? HistoricQueryStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'searchId': _searchId,
        'userId': _userId,
        'searchQuery': _searchQuery,
        'searchType': _searchType,
        'searchedAt': _searchedAt,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'searchId': serializeParam(
          _searchId,
          ParamType.int,
        ),
        'userId': serializeParam(
          _userId,
          ParamType.String,
        ),
        'searchQuery': serializeParam(
          _searchQuery,
          ParamType.String,
        ),
        'searchType': serializeParam(
          _searchType,
          ParamType.String,
        ),
        'searchedAt': serializeParam(
          _searchedAt,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static HistoricQueryStruct fromSerializableMap(Map<String, dynamic> data) =>
      HistoricQueryStruct(
        searchId: deserializeParam(
          data['searchId'],
          ParamType.int,
          false,
        ),
        userId: deserializeParam(
          data['userId'],
          ParamType.String,
          false,
        ),
        searchQuery: deserializeParam(
          data['searchQuery'],
          ParamType.String,
          false,
        ),
        searchType: deserializeParam(
          data['searchType'],
          ParamType.String,
          false,
        ),
        searchedAt: deserializeParam(
          data['searchedAt'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'HistoricQueryStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is HistoricQueryStruct &&
        searchId == other.searchId &&
        userId == other.userId &&
        searchQuery == other.searchQuery &&
        searchType == other.searchType &&
        searchedAt == other.searchedAt;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([searchId, userId, searchQuery, searchType, searchedAt]);
}

HistoricQueryStruct createHistoricQueryStruct({
  int? searchId,
  String? userId,
  String? searchQuery,
  String? searchType,
  DateTime? searchedAt,
}) =>
    HistoricQueryStruct(
      searchId: searchId,
      userId: userId,
      searchQuery: searchQuery,
      searchType: searchType,
      searchedAt: searchedAt,
    );
