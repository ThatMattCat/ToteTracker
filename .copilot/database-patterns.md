# Database Operations & SQLite Patterns

This file provides GitHub Copilot with specific context about ToteTracker's database architecture, patterns, and SQLite integration.

## Database Architecture

### Core Entities
ToteTracker uses a local SQLite database with the following main entities:

1. **Users** - User accounts and preferences
2. **Containers** - Storage containers (boxes, totes, etc.)
3. **Items** - Individual items stored in containers
4. **Labels** - Categorization tags for items
5. **Locations** - Physical locations where containers are stored
6. **Images** - Base64-encoded image data

### Database Schema Structure

#### Containers Table
```sql
-- Core container information
Containers {
  containerId: String (Primary Key)
  userId: String (Foreign Key)
  containerNumber: String
  name: String
  description: String
  locationId: String
  color: String
  size: String
  containerType: String
  qrCode: String (Unique)
  imagePath: String
  createdAt: DateTime
  updatedAt: DateTime
}
```

#### Items Table
```sql
-- Items stored in containers
Items {
  itemId: Integer (Primary Key, Auto-increment)
  name: String
  containerId: String (Foreign Key)
  description: String
  quantity: Integer
  category: String
  value: Double
  purchaseDate: DateTime
  expiryDate: DateTime
  imagePath: String (Base64 encoded)
  createdAt: DateTime
  updatedAt: DateTime
}
```

#### Labels Table
```sql
-- Categorization labels
Labels {
  labelId: Integer (Primary Key)
  name: String
  color: String
  userId: String
  createdAt: DateTime
}
```

## SQLite Manager Pattern

### Singleton Pattern
```dart
// SQLiteManager follows singleton pattern
class SQLiteManager {
  SQLiteManager._();
  
  static SQLiteManager? _instance;
  static SQLiteManager get instance => _instance ??= SQLiteManager._();
  
  static late Database _database;
  Database get database => _database;
  
  static Future initialize() async {
    if (kIsWeb) return;
    _database = await initializeDatabaseFromDbFile(
      'totetracker',
      'totetracker.db',
    );
  }
}
```

### Query Organization
Queries are organized in separate files:
- `queries/read.dart` - SELECT operations
- `queries/update.dart` - INSERT, UPDATE, DELETE operations

## Data Structure Patterns

### Struct Definition Pattern
```dart
class EntityStruct extends BaseStruct {
  EntityStruct({
    String? field1,
    int? field2,
    DateTime? field3,
  }) : _field1 = field1,
       _field2 = field2,
       _field3 = field3;

  // Private field with getter/setter pattern
  String? _field1;
  String get field1 => _field1 ?? '';
  set field1(String? val) => _field1 = val;
  bool hasField1() => _field1 != null;

  // Integer field with increment support
  int? _field2;
  int get field2 => _field2 ?? 0;
  set field2(int? val) => _field2 = val;
  void incrementField2(int amount) => field2 = field2 + amount;
  bool hasField2() => _field2 != null;

  // DateTime field
  DateTime? _field3;
  DateTime? get field3 => _field3;
  set field3(DateTime? val) => _field3 = val;
  bool hasField3() => _field3 != null;
}
```

### Serialization Pattern
```dart
// From Map (Database → Struct)
static EntityStruct fromMap(Map<String, dynamic> data) => EntityStruct(
  field1: data['field1'] as String?,
  field2: data['field2'] as int?,
  field3: data['field3'] != null 
    ? DateTime.fromMillisecondsSinceEpoch(data['field3']) 
    : null,
);

// To Map (Struct → Database)
Map<String, dynamic> toMap() => {
  'field1': _field1,
  'field2': _field2,
  'field3': _field3?.millisecondsSinceEpoch,
}.withoutNulls;

// Equality and hashCode
@override
bool operator ==(Object other) {
  return other is EntityStruct &&
    field1 == other.field1 &&
    field2 == other.field2 &&
    field3 == other.field3;
}

@override
int get hashCode => const ListEquality().hash([field1, field2, field3]);
```

## Common Query Patterns

### Read Operations
```dart
// Get all containers for a user
Future<List<GetAllUserContainerIDsRow>> getAllUserContainerIDs({
  String? userId,
}) => performGetAllUserContainerIDs(_database, userId: userId);

// Get items in a container
Future<List<GetItemsInContainerRow>> getItemsInContainer({
  String? containerId,
}) => performGetItemsInContainer(_database, containerId: containerId);

// Search items by name/description
Future<List<SearchItemsRow>> searchItems({
  String? query,
  String? userId,
}) => performSearchItems(_database, query: query, userId: userId);
```

### Write Operations
```dart
// Insert new item
Future<void> insertItem({
  required String name,
  required String containerId,
  String? description,
  int? quantity,
  String? category,
  String? imagePath,
}) => performInsertItem(
  _database,
  name: name,
  containerId: containerId,
  description: description,
  quantity: quantity,
  category: category,
  imagePath: imagePath,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

// Update existing item
Future<void> updateItem({
  required int itemId,
  String? name,
  String? description,
  int? quantity,
  String? category,
}) => performUpdateItem(
  _database,
  itemId: itemId,
  name: name,
  description: description,
  quantity: quantity,
  category: category,
  updatedAt: DateTime.now(),
);

// Delete item
Future<void> deleteItem({
  required int itemId,
}) => performDeleteItem(_database, itemId: itemId);
```

## Error Handling Patterns

### Database Operation Error Handling
```dart
Future<void> safeDatabaseOperation() async {
  try {
    await SQLiteManager.instance.insertItem(
      name: 'Item Name',
      containerId: 'container-123',
    );
    
    // Show success feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Item added successfully'),
        backgroundColor: FlutterFlowTheme.of(context).success,
      ),
    );
  } catch (e) {
    // Log error for debugging
    print('Database error: $e');
    
    // Show user-friendly error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to add item. Please try again.'),
        backgroundColor: FlutterFlowTheme.of(context).error,
      ),
    );
  }
}
```

### Transaction Patterns
```dart
// Use transactions for multiple related operations
Future<void> moveItemToContainer({
  required int itemId,
  required String newContainerId,
}) async {
  final db = SQLiteManager.instance.database;
  
  await db.transaction((txn) async {
    // Update item's container
    await txn.update(
      'Items',
      {
        'containerId': newContainerId,
        'updatedAt': DateTime.now().millisecondsSinceEpoch,
      },
      where: 'itemId = ?',
      whereArgs: [itemId],
    );
    
    // Log the move operation
    await txn.insert('MovementHistory', {
      'itemId': itemId,
      'newContainerId': newContainerId,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  });
}
```

## Image Storage Patterns

### Base64 Image Handling
```dart
// Convert image to base64 for database storage
Future<String?> imageToBase64(XFile imageFile) async {
  try {
    final bytes = await imageFile.readAsBytes();
    return base64Encode(bytes);
  } catch (e) {
    print('Error converting image to base64: $e');
    return null;
  }
}

// Convert base64 back to image for display
Widget base64ToImage(String? base64String) {
  if (base64String == null || base64String.isEmpty) {
    return Icon(Icons.image_not_supported);
  }
  
  try {
    final bytes = base64Decode(base64String);
    return Image.memory(
      bytes,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Icon(Icons.broken_image);
      },
    );
  } catch (e) {
    return Icon(Icons.broken_image);
  }
}
```

## Query Performance Patterns

### Efficient Querying
```dart
// Use appropriate WHERE clauses and LIMIT for large datasets
Future<List<ItemRow>> getRecentItems({
  String? userId,
  int limit = 20,
}) async {
  return await performQuery(
    '''
    SELECT * FROM Items i
    JOIN Containers c ON i.containerId = c.containerId
    WHERE c.userId = ?
    ORDER BY i.createdAt DESC
    LIMIT ?
    ''',
    [userId, limit],
  );
}

// Use indexes for frequently queried fields
// (Defined in database initialization)
```

### Pagination Support
```dart
Future<List<ItemRow>> getItemsPaginated({
  String? userId,
  int offset = 0,
  int limit = 20,
}) async {
  return await performQuery(
    '''
    SELECT * FROM Items i
    JOIN Containers c ON i.containerId = c.containerId
    WHERE c.userId = ?
    ORDER BY i.createdAt DESC
    LIMIT ? OFFSET ?
    ''',
    [userId, limit, offset],
  );
}
```

## Data Migration Patterns

### Version Handling
```dart
// Handle database schema migrations
Future<void> handleDatabaseMigration(int oldVersion, int newVersion) async {
  if (oldVersion < 2) {
    // Add new column
    await database.execute(
      'ALTER TABLE Items ADD COLUMN expiryDate INTEGER'
    );
  }
  
  if (oldVersion < 3) {
    // Create new table
    await database.execute('''
      CREATE TABLE Labels (
        labelId INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        color TEXT,
        userId TEXT,
        createdAt INTEGER
      )
    ''');
  }
}
```

## Backup & Restore Patterns

### Database Export
```dart
Future<String> exportDatabase() async {
  final dbPath = await getDatabasesPath();
  final dbFile = File('$dbPath/totetracker.db');
  
  if (await dbFile.exists()) {
    final bytes = await dbFile.readAsBytes();
    return base64Encode(bytes);
  }
  
  throw Exception('Database file not found');
}
```

### Database Import
```dart
Future<void> importDatabase(String base64Data) async {
  try {
    final bytes = base64Decode(base64Data);
    final dbPath = await getDatabasesPath();
    final dbFile = File('$dbPath/totetracker.db');
    
    // Close current database
    await SQLiteManager.instance.database.close();
    
    // Write new database file
    await dbFile.writeAsBytes(bytes);
    
    // Reinitialize database
    await SQLiteManager.initialize();
    
  } catch (e) {
    throw Exception('Failed to import database: $e');
  }
}
```

## Common Database Gotchas

1. **DateTime Storage**: Store as milliseconds since epoch (INTEGER)
2. **Base64 Images**: Can significantly increase database size
3. **Foreign Key Constraints**: Ensure proper relationship handling
4. **Transaction Rollback**: Always use transactions for multi-step operations
5. **Connection Management**: SQLite handles concurrency, but be mindful of long operations
6. **Null Safety**: Always check for null values when deserializing
7. **Index Usage**: Create indexes for frequently queried columns
8. **Backup Strategy**: Regular database exports for user data safety