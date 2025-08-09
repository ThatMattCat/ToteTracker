import 'package:flutter/foundation.dart';

import '/backend/sqlite/init.dart';
import 'queries/read.dart';
import 'queries/update.dart';

import 'package:sqflite/sqflite.dart';
export 'queries/read.dart';
export 'queries/update.dart';

class SQLiteManager {
  SQLiteManager._();

  static SQLiteManager? _instance;
  static SQLiteManager get instance => _instance ??= SQLiteManager._();

  static late Database _database;
  Database get database => _database;

  static Future initialize() async {
    if (kIsWeb) {
      return;
    }
    _database = await initializeDatabaseFromDbFile(
      'totetracker',
      'totetracker.db',
    );
  }

  /// START READ QUERY CALLS

  Future<List<GetAllUserContainerIDsRow>> getAllUserContainerIDs({
    String? userId,
  }) =>
      performGetAllUserContainerIDs(
        _database,
        userId: userId,
      );

  Future<List<GetDetailsForContainerWidgetsRow>> getDetailsForContainerWidgets({
    String? userId,
  }) =>
      performGetDetailsForContainerWidgets(
        _database,
        userId: userId,
      );

  Future<List<GetRecentlyAddedItemsRow>> getRecentlyAddedItems({
    String? userId,
  }) =>
      performGetRecentlyAddedItems(
        _database,
        userId: userId,
      );

  Future<List<GetNextAvailableContainerNumberRow>>
      getNextAvailableContainerNumber({
    String? userId,
  }) =>
          performGetNextAvailableContainerNumber(
            _database,
            userId: userId,
          );

  Future<List<GetLastLoggedInUserRow>> getLastLoggedInUser() =>
      performGetLastLoggedInUser(
        _database,
      );

  Future<List<GetLocationIdByLocationNameRow>> getLocationIdByLocationName({
    String? locationName,
  }) =>
      performGetLocationIdByLocationName(
        _database,
        locationName: locationName,
      );

  Future<List<GetItemDetailsByItemIDRow>> getItemDetailsByItemID({
    int? itemId,
  }) =>
      performGetItemDetailsByItemID(
        _database,
        itemId: itemId,
      );

  Future<List<GetAllUserLocationNamesRow>> getAllUserLocationNames({
    String? userId,
  }) =>
      performGetAllUserLocationNames(
        _database,
        userId: userId,
      );

  Future<List<GetContainerDetailsRow>> getContainerDetails({
    String? containerId,
  }) =>
      performGetContainerDetails(
        _database,
        containerId: containerId,
      );

  Future<List<GetDetailsForContainerItemWidgetsRow>>
      getDetailsForContainerItemWidgets({
    String? containerId,
  }) =>
          performGetDetailsForContainerItemWidgets(
            _database,
            containerId: containerId,
          );

  Future<List<GetUserNameByIDRow>> getUserNameByID({
    String? userId,
  }) =>
      performGetUserNameByID(
        _database,
        userId: userId,
      );

  Future<List<GetAllUserContainerNamesRow>> getAllUserContainerNames({
    String? userId,
  }) =>
      performGetAllUserContainerNames(
        _database,
        userId: userId,
      );

  Future<List<GetContainerIDFromContainerNameRow>>
      getContainerIDFromContainerName({
    String? containerName,
  }) =>
          performGetContainerIDFromContainerName(
            _database,
            containerName: containerName,
          );

  Future<List<GetImageBase64Row>> getImageBase64({
    int? imageId,
  }) =>
      performGetImageBase64(
        _database,
        imageId: imageId,
      );

  Future<List<GetLastCreatedItemIDRow>> getLastCreatedItemID() =>
      performGetLastCreatedItemID(
        _database,
      );

  Future<List<GetDetailsForAllUserItemWidgetsRow>>
      getDetailsForAllUserItemWidgets({
    String? userId,
  }) =>
          performGetDetailsForAllUserItemWidgets(
            _database,
            userId: userId,
          );

  Future<List<GetCategoryIDFromNameRow>> getCategoryIDFromName({
    String? name,
  }) =>
      performGetCategoryIDFromName(
        _database,
        name: name,
      );

  Future<List<GetChildrenForParentCategoryIDRow>>
      getChildrenForParentCategoryID({
    int? parentId,
  }) =>
          performGetChildrenForParentCategoryID(
            _database,
            parentId: parentId,
          );

  Future<List<GetAllParentCategoriesRow>> getAllParentCategories() =>
      performGetAllParentCategories(
        _database,
      );

  Future<List<GetCategoryNameByIDRow>> getCategoryNameByID({
    int? categoryId,
  }) =>
      performGetCategoryNameByID(
        _database,
        categoryId: categoryId,
      );

  Future<List<SearchAllItemFieldsByTextRow>> searchAllItemFieldsByText({
    String? searchString,
    String? userId,
  }) =>
      performSearchAllItemFieldsByText(
        _database,
        searchString: searchString,
        userId: userId,
      );

  Future<List<GetAllLabelsForItemIDRow>> getAllLabelsForItemID({
    int? itemId,
  }) =>
      performGetAllLabelsForItemID(
        _database,
        itemId: itemId,
      );

  Future<List<GetAllInUseLabelsRow>> getAllInUseLabels({
    String? userId,
  }) =>
      performGetAllInUseLabels(
        _database,
        userId: userId,
      );

  /// END READ QUERY CALLS

  /// START UPDATE QUERY CALLS

  Future updateItemQuantity({
    int? newQuantity,
    int? itemId,
  }) =>
      performUpdateItemQuantity(
        _database,
        newQuantity: newQuantity,
        itemId: itemId,
      );

  Future updateItemToDifferentContainer({
    int? itemId,
    String? newContainerId,
  }) =>
      performUpdateItemToDifferentContainer(
        _database,
        itemId: itemId,
        newContainerId: newContainerId,
      );

  Future updateContainerLocation({
    String? containerId,
    int? newLocationId,
  }) =>
      performUpdateContainerLocation(
        _database,
        containerId: containerId,
        newLocationId: newLocationId,
      );

  Future updateItemDetails({
    int? itemId,
    String? itemDescription,
    String? itemName,
    String? containerId,
    int? quantity,
    int? category,
  }) =>
      performUpdateItemDetails(
        _database,
        itemId: itemId,
        itemDescription: itemDescription,
        itemName: itemName,
        containerId: containerId,
        quantity: quantity,
        category: category,
      );

  Future updateOrCreateContainerAllDetails({
    String? containerId,
    String? containerType,
    String? containerSize,
    String? containerColor,
    String? containerDescription,
    String? containerName,
    int? containerLocationId,
  }) =>
      performUpdateOrCreateContainerAllDetails(
        _database,
        containerId: containerId,
        containerType: containerType,
        containerSize: containerSize,
        containerColor: containerColor,
        containerDescription: containerDescription,
        containerName: containerName,
        containerLocationId: containerLocationId,
      );

  Future updateLocationNameDescription({
    int? locationId,
    String? locationDescription,
    String? locationName,
  }) =>
      performUpdateLocationNameDescription(
        _database,
        locationId: locationId,
        locationDescription: locationDescription,
        locationName: locationName,
      );

  Future updateUsername({
    String? userId,
    String? userName,
  }) =>
      performUpdateUsername(
        _database,
        userId: userId,
        userName: userName,
      );

  Future updateIncrementItemQuantity({
    int? itemId,
    int? quantityToAdd,
  }) =>
      performUpdateIncrementItemQuantity(
        _database,
        itemId: itemId,
        quantityToAdd: quantityToAdd,
      );

  Future createNewUser({
    String? userName,
    String? customUserId,
  }) =>
      performCreateNewUser(
        _database,
        userName: userName,
        customUserId: customUserId,
      );

  Future createNewLocation({
    String? userId,
    String? locationName,
  }) =>
      performCreateNewLocation(
        _database,
        userId: userId,
        locationName: locationName,
      );

  Future createOrUpdateContainer({
    String? containerName,
    String? containerDescription,
    int? locationId,
    String? containerId,
    String? parentContainerId,
  }) =>
      performCreateOrUpdateContainer(
        _database,
        containerName: containerName,
        containerDescription: containerDescription,
        locationId: locationId,
        containerId: containerId,
        parentContainerId: parentContainerId,
      );

  Future createNewItem({
    String? containerId,
    String? itemName,
    String? itemDescription,
    int? quantity,
    int? category,
  }) =>
      performCreateNewItem(
        _database,
        containerId: containerId,
        itemName: itemName,
        itemDescription: itemDescription,
        quantity: quantity,
        category: category,
      );

  Future createSearchHistoryEntry({
    String? userId,
    String? searchQuery,
    String? searchType,
  }) =>
      performCreateSearchHistoryEntry(
        _database,
        userId: userId,
        searchQuery: searchQuery,
        searchType: searchType,
      );

  Future deleteItem({
    int? itemId,
  }) =>
      performDeleteItem(
        _database,
        itemId: itemId,
      );

  Future deleteLabelAndRemoveAssociations({
    int? labelId,
  }) =>
      performDeleteLabelAndRemoveAssociations(
        _database,
        labelId: labelId,
      );

  Future deleteImageRecord({
    int? imageId,
  }) =>
      performDeleteImageRecord(
        _database,
        imageId: imageId,
      );

  Future deleteSearchHistoryOlder30Days({
    String? userId,
  }) =>
      performDeleteSearchHistoryOlder30Days(
        _database,
        userId: userId,
      );

  Future updateLastAccessedUser({
    String? userId,
  }) =>
      performUpdateLastAccessedUser(
        _database,
        userId: userId,
      );

  Future updateOrCreateItemAllDetails({
    String? containerId,
    String? itemName,
    String? description,
    int? quantity,
  }) =>
      performUpdateOrCreateItemAllDetails(
        _database,
        containerId: containerId,
        itemName: itemName,
        description: description,
        quantity: quantity,
      );

  Future deleteContainerAndMoveItemsToNULLContainer({
    String? containerId,
  }) =>
      performDeleteContainerAndMoveItemsToNULLContainer(
        _database,
        containerId: containerId,
      );

  Future deleteAllItemsInContainer({
    String? containerId,
  }) =>
      performDeleteAllItemsInContainer(
        _database,
        containerId: containerId,
      );

  Future updateImageBase64({
    String? base64,
    int? imageId,
  }) =>
      performUpdateImageBase64(
        _database,
        base64: base64,
        imageId: imageId,
      );

  Future createLabel({
    String? labelName,
    String? userId,
  }) =>
      performCreateLabel(
        _database,
        labelName: labelName,
        userId: userId,
      );

  Future createItemLabelByLabelNameAndItemID({
    String? userId,
    String? labelName,
  }) =>
      performCreateItemLabelByLabelNameAndItemID(
        _database,
        userId: userId,
        labelName: labelName,
      );

  /// END UPDATE QUERY CALLS
}
