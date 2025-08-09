import 'package:sqflite/sqflite.dart';

/// BEGIN UPDATE ITEM QUANTITY
Future performUpdateItemQuantity(
  Database database, {
  int? newQuantity,
  int? itemId,
}) {
  final query = '''
UPDATE items 
SET quantity = ${newQuantity}
WHERE item_id = ${itemId};
''';
  return database.rawQuery(query);
}

/// END UPDATE ITEM QUANTITY

/// BEGIN UPDATE ITEM TO DIFFERENT CONTAINER
Future performUpdateItemToDifferentContainer(
  Database database, {
  int? itemId,
  String? newContainerId,
}) {
  final query = '''
UPDATE items 
SET container_id = '${newContainerId}'
WHERE item_id = ${itemId};
''';
  return database.rawQuery(query);
}

/// END UPDATE ITEM TO DIFFERENT CONTAINER

/// BEGIN UPDATE CONTAINER LOCATION
Future performUpdateContainerLocation(
  Database database, {
  String? containerId,
  int? newLocationId,
}) {
  final query = '''
UPDATE containers 
SET location_id = ${newLocationId}
WHERE container_id = '${containerId}';
''';
  return database.rawQuery(query);
}

/// END UPDATE CONTAINER LOCATION

/// BEGIN UPDATE ITEM DETAILS
Future performUpdateItemDetails(
  Database database, {
  int? itemId,
  String? itemDescription,
  String? itemName,
  String? containerId,
  int? quantity,
  int? category,
}) {
  final query = '''
UPDATE items 
SET name = '${itemName}',
    description = '${itemDescription}',
    container_id = '${containerId}',
    quantity  = ${quantity},
    category = ${category}
WHERE item_id = ${itemId};
''';
  return database.rawQuery(query);
}

/// END UPDATE ITEM DETAILS

/// BEGIN UPDATE OR CREATE CONTAINER ALL DETAILS
Future performUpdateOrCreateContainerAllDetails(
  Database database, {
  String? containerId,
  String? containerType,
  String? containerSize,
  String? containerColor,
  String? containerDescription,
  String? containerName,
  int? containerLocationId,
}) {
  final query = '''
INSERT INTO containers (container_id, name, description, color, storage_volume, container_type, location_id)
VALUES ('${containerId}', '${containerName}', '${containerDescription}', 
        '${containerColor}', '${containerSize}', '${containerType}', ${containerLocationId})
ON CONFLICT(container_id) DO UPDATE SET
    name = excluded.name,
    description = excluded.description,
    color = excluded.color,
    size = excluded.size,
    container_type = excluded.container_type;
''';
  return database.rawQuery(query);
}

/// END UPDATE OR CREATE CONTAINER ALL DETAILS

/// BEGIN UPDATE LOCATION NAME DESCRIPTION
Future performUpdateLocationNameDescription(
  Database database, {
  int? locationId,
  String? locationDescription,
  String? locationName,
}) {
  final query = '''
UPDATE locations 
SET name = '${locationName}',
    description = '${locationDescription}'
WHERE location_id = ${locationId};
''';
  return database.rawQuery(query);
}

/// END UPDATE LOCATION NAME DESCRIPTION

/// BEGIN UPDATE USERNAME
Future performUpdateUsername(
  Database database, {
  String? userId,
  String? userName,
}) {
  final query = '''
UPDATE users 
SET user_name = '${userName}'
WHERE user_id = '${userId}';
''';
  return database.rawQuery(query);
}

/// END UPDATE USERNAME

/// BEGIN UPDATE INCREMENT ITEM QUANTITY
Future performUpdateIncrementItemQuantity(
  Database database, {
  int? itemId,
  int? quantityToAdd,
}) {
  final query = '''
UPDATE items 
SET quantity = quantity + ${quantityToAdd}
WHERE item_id = ${itemId};
''';
  return database.rawQuery(query);
}

/// END UPDATE INCREMENT ITEM QUANTITY

/// BEGIN CREATE NEW USER
Future performCreateNewUser(
  Database database, {
  String? userName,
  String? customUserId,
}) {
  final query = '''
  INSERT INTO users (user_id, name)
VALUES (
    COALESCE('${customUserId}', lower(hex(randomblob(3)))),
    '${userName}'
);
''';
  return database.rawQuery(query);
}

/// END CREATE NEW USER

/// BEGIN CREATE NEW LOCATION
Future performCreateNewLocation(
  Database database, {
  String? userId,
  String? locationName,
}) {
  final query = '''
INSERT INTO locations (user_id, name)
VALUES ('${userId}', '${locationName}');
''';
  return database.rawQuery(query);
}

/// END CREATE NEW LOCATION

/// BEGIN CREATE OR UPDATE CONTAINER
Future performCreateOrUpdateContainer(
  Database database, {
  String? containerName,
  String? containerDescription,
  int? locationId,
  String? containerId,
  String? parentContainerId,
}) {
  final query = '''
INSERT INTO containers (container_id, name, description, location_id, parent_container_id)
VALUES ('${containerId}', '${containerName}', '${containerDescription}', ${locationId}, NULLIF('${parentContainerId}', 'null'))
ON CONFLICT(container_id) DO UPDATE SET
    name = excluded.name,
    description = excluded.description,
    location_id = excluded.location_id,
    parent_container_id = excluded.parent_container_id;
''';
  return database.rawQuery(query);
}

/// END CREATE OR UPDATE CONTAINER

/// BEGIN CREATE NEW ITEM
Future performCreateNewItem(
  Database database, {
  String? containerId,
  String? itemName,
  String? itemDescription,
  int? quantity,
  int? category,
}) {
  final query = '''
INSERT INTO items (
    container_id,
    name,
    description,
    quantity,
    category
)
VALUES (
    '${containerId}',
    '${itemName}',
    '${itemDescription}',
    ${quantity},
    ${category}
);
''';
  return database.rawQuery(query);
}

/// END CREATE NEW ITEM

/// BEGIN CREATE SEARCH HISTORY ENTRY
Future performCreateSearchHistoryEntry(
  Database database, {
  String? userId,
  String? searchQuery,
  String? searchType,
}) {
  final query = '''
INSERT INTO search_history (user_id, search_query, search_type)
VALUES ('${userId}', '${searchQuery}', '${searchType}');
''';
  return database.rawQuery(query);
}

/// END CREATE SEARCH HISTORY ENTRY

/// BEGIN DELETE ITEM
Future performDeleteItem(
  Database database, {
  int? itemId,
}) {
  final query = '''
DELETE FROM items WHERE item_id = ${itemId};
''';
  return database.rawQuery(query);
}

/// END DELETE ITEM

/// BEGIN DELETE LABEL AND REMOVE ASSOCIATIONS
Future performDeleteLabelAndRemoveAssociations(
  Database database, {
  int? labelId,
}) {
  final query = '''
DELETE FROM item_labels WHERE label_id = ${labelId};
DELETE FROM container_labels WHERE label_id = ${labelId};
DELETE FROM labels 
WHERE label_id = ${labelId};
''';
  return database.rawQuery(query);
}

/// END DELETE LABEL AND REMOVE ASSOCIATIONS

/// BEGIN DELETE IMAGE RECORD
Future performDeleteImageRecord(
  Database database, {
  int? imageId,
}) {
  final query = '''
DELETE FROM images WHERE image_id = ${imageId};
''';
  return database.rawQuery(query);
}

/// END DELETE IMAGE RECORD

/// BEGIN DELETE SEARCH HISTORY OLDER 30 DAYS
Future performDeleteSearchHistoryOlder30Days(
  Database database, {
  String? userId,
}) {
  final query = '''
DELETE FROM search_history 
WHERE user_id = '${userId}'
  AND searched_at < datetime('now', '-30 days');
''';
  return database.rawQuery(query);
}

/// END DELETE SEARCH HISTORY OLDER 30 DAYS

/// BEGIN UPDATE LASTACCESSED USER
Future performUpdateLastAccessedUser(
  Database database, {
  String? userId,
}) {
  final query = '''
INSERT OR REPLACE INTO last_login (id, user_id) VALUES (1, '${userId}');
''';
  return database.rawQuery(query);
}

/// END UPDATE LASTACCESSED USER

/// BEGIN UPDATE OR CREATE ITEM ALL DETAILS
Future performUpdateOrCreateItemAllDetails(
  Database database, {
  String? containerId,
  String? itemName,
  String? description,
  int? quantity,
}) {
  final query = '''
INSERT INTO items (container_id, name, description, quantity)
VALUES (
    '${containerId}', 
   '${itemName}',
    '${description}', 
    ${quantity}
)
ON CONFLICT (container_id, name) 
DO UPDATE SET 
    description = excluded.description,
    quantity = excluded.quantity;

''';
  return database.rawQuery(query);
}

/// END UPDATE OR CREATE ITEM ALL DETAILS

/// BEGIN DELETE CONTAINER AND MOVE ITEMS TO NULL CONTAINER
Future performDeleteContainerAndMoveItemsToNULLContainer(
  Database database, {
  String? containerId,
}) {
  final query = '''
DELETE FROM containers 
WHERE container_id = '${containerId}';
''';
  return database.rawQuery(query);
}

/// END DELETE CONTAINER AND MOVE ITEMS TO NULL CONTAINER

/// BEGIN DELETE ALL ITEMS IN CONTAINER
Future performDeleteAllItemsInContainer(
  Database database, {
  String? containerId,
}) {
  final query = '''
DELETE FROM items WHERE container_id = '${containerId}';
''';
  return database.rawQuery(query);
}

/// END DELETE ALL ITEMS IN CONTAINER

/// BEGIN UPDATE IMAGE BASE64
Future performUpdateImageBase64(
  Database database, {
  String? base64,
  int? imageId,
}) {
  final query = '''
UPDATE images SET base64 = '${base64}' WHERE image_id = ${imageId};
''';
  return database.rawQuery(query);
}

/// END UPDATE IMAGE BASE64

/// BEGIN CREATE LABEL
Future performCreateLabel(
  Database database, {
  String? labelName,
  String? userId,
}) {
  final query = '''
INSERT INTO labels (user_id,name) VALUES ('${labelName}','${userId}')
''';
  return database.rawQuery(query);
}

/// END CREATE LABEL

/// BEGIN CREATE ITEMLABEL BY LABEL NAME AND ITEM ID
Future performCreateItemLabelByLabelNameAndItemID(
  Database database, {
  String? userId,
  String? labelName,
}) {
  final query = '''
INSERT INTO item_labels (item_id, label_id)
VALUES ('${userId}', (SELECT label_id FROM labels WHERE name = '${labelName}'));
''';
  return database.rawQuery(query);
}

/// END CREATE ITEMLABEL BY LABEL NAME AND ITEM ID
