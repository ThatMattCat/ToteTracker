import '/backend/sqlite/queries/sqlite_row.dart';
import 'package:sqflite/sqflite.dart';

Future<List<T>> _readQuery<T>(
  Database database,
  String query,
  T Function(Map<String, dynamic>) create,
) =>
    database.rawQuery(query).then((r) => r.map((e) => create(e)).toList());

/// BEGIN GET ALL USER CONTAINER IDS
Future<List<GetAllUserContainerIDsRow>> performGetAllUserContainerIDs(
  Database database, {
  String? userId,
}) {
  final query = '''
SELECT container_id FROM containers where user_id = '${userId}'
''';
  return _readQuery(database, query, (d) => GetAllUserContainerIDsRow(d));
}

class GetAllUserContainerIDsRow extends SqliteRow {
  GetAllUserContainerIDsRow(Map<String, dynamic> data) : super(data);

  String? get containerId => data['container_id'] as String?;
}

/// END GET ALL USER CONTAINER IDS

/// BEGIN GET DETAILS FOR CONTAINER WIDGETS
Future<List<GetDetailsForContainerWidgetsRow>>
    performGetDetailsForContainerWidgets(
  Database database, {
  String? userId,
}) {
  final query = '''
SELECT 
    c.container_id,
    c.name AS container_name,
    l.name AS location_name,
    COALESCE(SUM(i.quantity), 0) AS total_quantity
FROM containers c
LEFT JOIN locations l ON c.location_id = l.location_id
LEFT JOIN items i ON c.container_id = i.container_id
WHERE c.user_id = '${userId}'
GROUP BY c.container_id, c.name, l.name
ORDER BY c.container_id;
''';
  return _readQuery(
      database, query, (d) => GetDetailsForContainerWidgetsRow(d));
}

class GetDetailsForContainerWidgetsRow extends SqliteRow {
  GetDetailsForContainerWidgetsRow(Map<String, dynamic> data) : super(data);

  String? get containerName => data['container_name'] as String?;
  String? get locationName => data['location_name'] as String?;
  int? get totalQuantity => data['total_quantity'] as int?;
  String? get containerId => data['container_id'] as String?;
}

/// END GET DETAILS FOR CONTAINER WIDGETS

/// BEGIN GET RECENTLY ADDED ITEMS
Future<List<GetRecentlyAddedItemsRow>> performGetRecentlyAddedItems(
  Database database, {
  String? userId,
}) {
  final query = '''
SELECT 
    i.item_id,
    i.name,
    i.quantity,
    c.name as container_name,
    datetime(i.created_at, 'localtime') as created_at
FROM items i
JOIN containers c ON i.container_id = c.container_id
WHERE c.user_id = '${userId}'
ORDER BY i.created_at DESC
LIMIT 20;
''';
  return _readQuery(database, query, (d) => GetRecentlyAddedItemsRow(d));
}

class GetRecentlyAddedItemsRow extends SqliteRow {
  GetRecentlyAddedItemsRow(Map<String, dynamic> data) : super(data);

  int get itemId => data['item_id'] as int;
  String get name => data['name'] as String;
  int? get quantity => data['quantity'] as int?;
  String get containerName => data['container_name'] as String;
  DateTime get createdAt => data['created_at'] as DateTime;
}

/// END GET RECENTLY ADDED ITEMS

/// BEGIN GET NEXT AVAILABLE CONTAINER NUMBER
Future<List<GetNextAvailableContainerNumberRow>>
    performGetNextAvailableContainerNumber(
  Database database, {
  String? userId,
}) {
  final query = '''
SELECT 
  CAST(COALESCE(MAX(CAST(container_number AS INTEGER)), 0) + 1 AS TEXT) AS next_container_number,
  PRINTF('%05d', COALESCE(MAX(CAST(container_number AS INTEGER)), 0) + 1) AS padded_container_number
FROM containers 
WHERE user_id = '${userId}';
''';
  return _readQuery(
      database, query, (d) => GetNextAvailableContainerNumberRow(d));
}

class GetNextAvailableContainerNumberRow extends SqliteRow {
  GetNextAvailableContainerNumberRow(Map<String, dynamic> data) : super(data);

  String? get nextContainerNumber => data['next_container_number'] as String?;
  String? get paddedContainerNumber =>
      data['padded_container_number'] as String?;
}

/// END GET NEXT AVAILABLE CONTAINER NUMBER

/// BEGIN GET LAST LOGGEDIN USER
Future<List<GetLastLoggedInUserRow>> performGetLastLoggedInUser(
  Database database,
) {
  final query = '''
SELECT user_id as userId FROM last_login
WHERE id = 1;
''';
  return _readQuery(database, query, (d) => GetLastLoggedInUserRow(d));
}

class GetLastLoggedInUserRow extends SqliteRow {
  GetLastLoggedInUserRow(Map<String, dynamic> data) : super(data);

  String? get userId => data['userId'] as String?;
}

/// END GET LAST LOGGEDIN USER

/// BEGIN GET LOCATIONID BY LOCATIONNAME
Future<List<GetLocationIdByLocationNameRow>> performGetLocationIdByLocationName(
  Database database, {
  String? locationName,
}) {
  final query = '''
SELECT 
    location_id
FROM locations
WHERE name = '${locationName}'
LIMIT 1;
''';
  return _readQuery(database, query, (d) => GetLocationIdByLocationNameRow(d));
}

class GetLocationIdByLocationNameRow extends SqliteRow {
  GetLocationIdByLocationNameRow(Map<String, dynamic> data) : super(data);

  int get locationId => data['location_id'] as int;
}

/// END GET LOCATIONID BY LOCATIONNAME

/// BEGIN GET ITEM DETAILS BY ITEMID
Future<List<GetItemDetailsByItemIDRow>> performGetItemDetailsByItemID(
  Database database, {
  int? itemId,
}) {
  final query = '''
SELECT container_id, name, description, quantity, category, value, purchase_date, expiry_date, created_at, updated_at
FROM items
WHERE item_id = ${itemId}
''';
  return _readQuery(database, query, (d) => GetItemDetailsByItemIDRow(d));
}

class GetItemDetailsByItemIDRow extends SqliteRow {
  GetItemDetailsByItemIDRow(Map<String, dynamic> data) : super(data);

  String get containerId => data['container_id'] as String;
  String? get name => data['name'] as String?;
  String? get description => data['description'] as String?;
  int? get quantity => data['quantity'] as int?;
  int? get category => data['category'] as int?;
}

/// END GET ITEM DETAILS BY ITEMID

/// BEGIN GET ALL USER LOCATION NAMES
Future<List<GetAllUserLocationNamesRow>> performGetAllUserLocationNames(
  Database database, {
  String? userId,
}) {
  final query = '''
SELECT name FROM locations WHERE user_id = '${userId}'
''';
  return _readQuery(database, query, (d) => GetAllUserLocationNamesRow(d));
}

class GetAllUserLocationNamesRow extends SqliteRow {
  GetAllUserLocationNamesRow(Map<String, dynamic> data) : super(data);

  String? get name => data['name'] as String?;
}

/// END GET ALL USER LOCATION NAMES

/// BEGIN GET CONTAINER DETAILS
Future<List<GetContainerDetailsRow>> performGetContainerDetails(
  Database database, {
  String? containerId,
}) {
  final query = '''
SELECT 
    c.container_id,
    c.name AS container_name,
    c.parent_container_id as parent_container_id,
    c.description as container_description,
    l.name AS location_name,
    COALESCE(SUM(i.quantity), 0) AS total_quantity
FROM containers c
LEFT JOIN locations l ON c.location_id = l.location_id
LEFT JOIN items i ON c.container_id = i.container_id
WHERE c.container_id = '${containerId}'
GROUP BY c.container_id, c.name, l.name
ORDER BY c.container_id;
''';
  return _readQuery(database, query, (d) => GetContainerDetailsRow(d));
}

class GetContainerDetailsRow extends SqliteRow {
  GetContainerDetailsRow(Map<String, dynamic> data) : super(data);

  String? get containerName => data['container_name'] as String?;
  String? get locationName => data['location_name'] as String?;
  int? get totalQuantity => data['total_quantity'] as int?;
  String? get containerDescription => data['container_description'] as String?;
  String? get parentContainerId => data['parent_container_id'] as String?;
}

/// END GET CONTAINER DETAILS

/// BEGIN GET DETAILS FOR CONTAINER ITEM WIDGETS
Future<List<GetDetailsForContainerItemWidgetsRow>>
    performGetDetailsForContainerItemWidgets(
  Database database, {
  String? containerId,
}) {
  final query = '''
WITH RECURSIVE container_hierarchy AS (
    -- Base case: start with the target container
    SELECT container_id
    FROM containers
    WHERE container_id = '${containerId}'
    
    UNION ALL
    
    -- Recursive case: find all children of containers in the hierarchy
    SELECT c.container_id
    FROM containers c
    INNER JOIN container_hierarchy ch ON c.parent_container_id = ch.container_id
)
SELECT 
    i.item_id as item_id, 
    i.container_id as container_id, 
    i.name as name, 
    i.quantity as quantity, 
    img.base64 as image_base64, 
    c.name as category_name
FROM items i
INNER JOIN container_hierarchy ch ON i.container_id = ch.container_id
LEFT JOIN images img ON i.item_id = img.image_id
LEFT JOIN categories c ON i.category = c.id
''';
  return _readQuery(
      database, query, (d) => GetDetailsForContainerItemWidgetsRow(d));
}

class GetDetailsForContainerItemWidgetsRow extends SqliteRow {
  GetDetailsForContainerItemWidgetsRow(Map<String, dynamic> data) : super(data);

  int get itemId => data['item_id'] as int;
  String get containerId => data['container_id'] as String;
  String get name => data['name'] as String;
  int? get quantity => data['quantity'] as int?;
  String? get imageBase64 => data['image_base64'] as String?;
  String? get categoryName => data['category_name'] as String?;
}

/// END GET DETAILS FOR CONTAINER ITEM WIDGETS

/// BEGIN GET USER NAME BY ID
Future<List<GetUserNameByIDRow>> performGetUserNameByID(
  Database database, {
  String? userId,
}) {
  final query = '''
SELECT user_name FROM users WHERE user_id = '${userId}'
''';
  return _readQuery(database, query, (d) => GetUserNameByIDRow(d));
}

class GetUserNameByIDRow extends SqliteRow {
  GetUserNameByIDRow(Map<String, dynamic> data) : super(data);

  String get userName => data['user_name'] as String;
}

/// END GET USER NAME BY ID

/// BEGIN GET ALL USER CONTAINER NAMES
Future<List<GetAllUserContainerNamesRow>> performGetAllUserContainerNames(
  Database database, {
  String? userId,
}) {
  final query = '''
SELECT name AS container_name FROM containers WHERE user_id = '${userId}'
''';
  return _readQuery(database, query, (d) => GetAllUserContainerNamesRow(d));
}

class GetAllUserContainerNamesRow extends SqliteRow {
  GetAllUserContainerNamesRow(Map<String, dynamic> data) : super(data);

  String? get containerName => data['container_name'] as String?;
}

/// END GET ALL USER CONTAINER NAMES

/// BEGIN GET CONTAINER ID FROM CONTAINER NAME
Future<List<GetContainerIDFromContainerNameRow>>
    performGetContainerIDFromContainerName(
  Database database, {
  String? containerName,
}) {
  final query = '''
SELECT container_id FROM containers WHERE name = '${containerName}';
''';
  return _readQuery(
      database, query, (d) => GetContainerIDFromContainerNameRow(d));
}

class GetContainerIDFromContainerNameRow extends SqliteRow {
  GetContainerIDFromContainerNameRow(Map<String, dynamic> data) : super(data);

  String get containerId => data['container_id'] as String;
}

/// END GET CONTAINER ID FROM CONTAINER NAME

/// BEGIN GET IMAGE BASE64
Future<List<GetImageBase64Row>> performGetImageBase64(
  Database database, {
  int? imageId,
}) {
  final query = '''
SELECT base64 FROM images WHERE image_id = ${imageId};
''';
  return _readQuery(database, query, (d) => GetImageBase64Row(d));
}

class GetImageBase64Row extends SqliteRow {
  GetImageBase64Row(Map<String, dynamic> data) : super(data);

  String? get base64 => data['base64'] as String?;
}

/// END GET IMAGE BASE64

/// BEGIN GET LAST CREATED ITEMID
Future<List<GetLastCreatedItemIDRow>> performGetLastCreatedItemID(
  Database database,
) {
  final query = '''
SELECT item_id FROM items ORDER BY item_id DESC LIMIT 1;
''';
  return _readQuery(database, query, (d) => GetLastCreatedItemIDRow(d));
}

class GetLastCreatedItemIDRow extends SqliteRow {
  GetLastCreatedItemIDRow(Map<String, dynamic> data) : super(data);

  int get itemId => data['item_id'] as int;
}

/// END GET LAST CREATED ITEMID

/// BEGIN GET DETAILS FOR ALL USER ITEM WIDGETS
Future<List<GetDetailsForAllUserItemWidgetsRow>>
    performGetDetailsForAllUserItemWidgets(
  Database database, {
  String? userId,
}) {
  final query = '''
SELECT 
    i.item_id as item_id, 
    i.container_id as container_id, 
    i.name as name, 
    i.quantity as quantity, 
    img.base64 as image_base64,
    c.name as category_name
FROM items i
LEFT JOIN images img ON i.item_id = img.image_id
LEFT JOIN categories c ON i.category = c.id
WHERE i.user_id = '${userId}'
''';
  return _readQuery(
      database, query, (d) => GetDetailsForAllUserItemWidgetsRow(d));
}

class GetDetailsForAllUserItemWidgetsRow extends SqliteRow {
  GetDetailsForAllUserItemWidgetsRow(Map<String, dynamic> data) : super(data);

  int get itemId => data['item_id'] as int;
  String get containerId => data['container_id'] as String;
  String get name => data['name'] as String;
  int? get quantity => data['quantity'] as int?;
  String? get imageBase64 => data['image_base64'] as String?;
  String? get categoryName => data['category_name'] as String?;
}

/// END GET DETAILS FOR ALL USER ITEM WIDGETS

/// BEGIN GET CATEGORY ID FROM NAME
Future<List<GetCategoryIDFromNameRow>> performGetCategoryIDFromName(
  Database database, {
  String? name,
}) {
  final query = '''
SELECT id as categoryId FROM categories WHERE name = '${name}'
''';
  return _readQuery(database, query, (d) => GetCategoryIDFromNameRow(d));
}

class GetCategoryIDFromNameRow extends SqliteRow {
  GetCategoryIDFromNameRow(Map<String, dynamic> data) : super(data);

  int? get categoryId => data['categoryId'] as int?;
}

/// END GET CATEGORY ID FROM NAME

/// BEGIN GET CHILDREN FOR PARENT CATEGORY ID
Future<List<GetChildrenForParentCategoryIDRow>>
    performGetChildrenForParentCategoryID(
  Database database, {
  int? parentId,
}) {
  final query = '''
SELECT name as childName, id as childId FROM categories WHERE parent_id = ${parentId}
''';
  return _readQuery(
      database, query, (d) => GetChildrenForParentCategoryIDRow(d));
}

class GetChildrenForParentCategoryIDRow extends SqliteRow {
  GetChildrenForParentCategoryIDRow(Map<String, dynamic> data) : super(data);

  String? get childName => data['childName'] as String?;
  int? get childId => data['childId'] as int?;
}

/// END GET CHILDREN FOR PARENT CATEGORY ID

/// BEGIN GET ALL PARENT CATEGORIES
Future<List<GetAllParentCategoriesRow>> performGetAllParentCategories(
  Database database,
) {
  final query = '''
SELECT id as parentId, name as parentName FROM categories WHERE parent_id is null;
''';
  return _readQuery(database, query, (d) => GetAllParentCategoriesRow(d));
}

class GetAllParentCategoriesRow extends SqliteRow {
  GetAllParentCategoriesRow(Map<String, dynamic> data) : super(data);

  int get parentId => data['parentId'] as int;
  String? get parentName => data['parentName'] as String?;
}

/// END GET ALL PARENT CATEGORIES

/// BEGIN GET CATEGORY NAME BY ID
Future<List<GetCategoryNameByIDRow>> performGetCategoryNameByID(
  Database database, {
  int? categoryId,
}) {
  final query = '''
SELECT name as categoryName FROM categories WHERE id = ${categoryId};
''';
  return _readQuery(database, query, (d) => GetCategoryNameByIDRow(d));
}

class GetCategoryNameByIDRow extends SqliteRow {
  GetCategoryNameByIDRow(Map<String, dynamic> data) : super(data);

  String? get categoryName => data['categoryName'] as String?;
}

/// END GET CATEGORY NAME BY ID

/// BEGIN SEARCH ALL ITEM FIELDS BY TEXT
Future<List<SearchAllItemFieldsByTextRow>> performSearchAllItemFieldsByText(
  Database database, {
  String? searchString,
  String? userId,
}) {
  final query = '''
WITH search_term AS (
    SELECT LOWER('${searchString}') AS query
),
search_words AS (
    -- Split the search query into individual words
    SELECT TRIM(value) AS word 
    FROM search_term, json_each('["' || REPLACE(query, ' ', '","') || '"]')
    WHERE LENGTH(TRIM(value)) > 0
)
SELECT DISTINCT
    i.item_id,
    i.container_id,
    i.user_id,
    i.name,
    i.description,
    i.quantity,
    c.name AS category_name,
    c.id as category_id,
    i.value,
    i.purchase_date,
    i.expiry_date,
    i.created_at,
    i.updated_at,
    img.base64 AS image_base64,
    img.thumbnail_base64,
    img.mime_type AS image_mime_type,
    img.size_bytes AS image_size_bytes,
    img.width AS image_width,
    img.height AS image_height,
    CASE 
        WHEN img.base64 IS NOT NULL THEN 1 
        ELSE 0 
    END AS has_image,
    MAX(score) AS relevance_score
FROM (
    -- 1. Full phrase match in item name (highest priority)
    SELECT item_id, 100 AS score
    FROM items, search_term
    WHERE LOWER(name) LIKE '%' || query || '%'
    
    UNION ALL
    
    -- 2. Full phrase match in item description
    SELECT item_id, 90 AS score
    FROM items, search_term
    WHERE LOWER(description) LIKE '%' || query || '%'
    
    UNION ALL
    
    -- 3. Full phrase match in category name
    SELECT i.item_id, 80 AS score
    FROM items i
    JOIN categories c ON i.category = c.id
    JOIN search_term
    WHERE LOWER(c.name) LIKE '%' || query || '%'
    
    UNION ALL
    
    -- 4. Full phrase match in label name
    SELECT il.item_id, 80 AS score
    FROM item_labels il
    JOIN labels l ON il.label_id = l.label_id
    JOIN search_term
    WHERE LOWER(l.name) LIKE '%' || query || '%'
    
    UNION ALL
    
    -- 5. Individual word matches in item name
    SELECT DISTINCT i.item_id, 50 AS score
    FROM items i, search_words sw
    WHERE LOWER(i.name) LIKE '%' || sw.word || '%'
    
    UNION ALL
    
    -- 6. Individual word matches in item description
    SELECT DISTINCT i.item_id, 40 AS score
    FROM items i, search_words sw
    WHERE LOWER(i.description) LIKE '%' || sw.word || '%'
    
    UNION ALL
    
    -- 7. Individual word matches in category name
    SELECT DISTINCT i.item_id, 30 AS score
    FROM items i
    JOIN categories c ON i.category = c.id
    JOIN search_words sw
    WHERE LOWER(c.name) LIKE '%' || sw.word || '%'
    
    UNION ALL
    
    -- 8. Individual word matches in label name
    SELECT DISTINCT il.item_id, 30 AS score
    FROM item_labels il
    JOIN labels l ON il.label_id = l.label_id
    JOIN search_words sw
    WHERE LOWER(l.name) LIKE '%' || sw.word || '%'
    
) AS matches
JOIN items i ON matches.item_id = i.item_id
LEFT JOIN categories c ON i.category = c.id
LEFT JOIN images img ON i.item_id = img.image_id
WHERE i.user_id = '${userId}'
GROUP BY i.item_id
ORDER BY relevance_score DESC, i.name ASC;
''';
  return _readQuery(database, query, (d) => SearchAllItemFieldsByTextRow(d));
}

class SearchAllItemFieldsByTextRow extends SqliteRow {
  SearchAllItemFieldsByTextRow(Map<String, dynamic> data) : super(data);

  String? get name => data['name'] as String?;
  String? get description => data['description'] as String?;
  int? get quantity => data['quantity'] as int?;
  String? get categoryName => data['category_name'] as String?;
  int? get categoryId => data['category_id'] as int?;
  int? get itemId => data['item_id'] as int?;
  String? get containerId => data['container_id'] as String?;
  String? get imageBase64 => data['image_base64'] as String?;
}

/// END SEARCH ALL ITEM FIELDS BY TEXT

/// BEGIN GET ALL LABELS FOR ITEM ID
Future<List<GetAllLabelsForItemIDRow>> performGetAllLabelsForItemID(
  Database database, {
  int? itemId,
}) {
  final query = '''
SELECT l.name AS label_name
FROM item_labels il
JOIN labels l ON il.label_id = l.label_id
WHERE il.item_id = ${itemId};
''';
  return _readQuery(database, query, (d) => GetAllLabelsForItemIDRow(d));
}

class GetAllLabelsForItemIDRow extends SqliteRow {
  GetAllLabelsForItemIDRow(Map<String, dynamic> data) : super(data);

  String? get labelName => data['label_name'] as String?;
}

/// END GET ALL LABELS FOR ITEM ID

/// BEGIN GET ALL INUSE LABELS
Future<List<GetAllInUseLabelsRow>> performGetAllInUseLabels(
  Database database, {
  String? userId,
}) {
  final query = '''
SELECT DISTINCT l.name AS label_name
FROM labels l
INNER JOIN item_labels il ON l.label_id = il.label_id
WHERE l.user_id = '${userId}';
''';
  return _readQuery(database, query, (d) => GetAllInUseLabelsRow(d));
}

class GetAllInUseLabelsRow extends SqliteRow {
  GetAllInUseLabelsRow(Map<String, dynamic> data) : super(data);

  String? get labelName => data['label_name'] as String?;
}

/// END GET ALL INUSE LABELS
