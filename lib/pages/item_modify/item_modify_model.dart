import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/backend/sqlite/sqlite_manager.dart';
import '/components/header/header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'item_modify_widget.dart' show ItemModifyWidget;
import 'package:flutter/material.dart';

class ItemModifyModel extends FlutterFlowModel<ItemModifyWidget> {
  ///  Local state fields for this page.

  String? selectedContainer;

  String? imageB64;

  String pageTitle = 'New Item';

  String? origContainerName;

  List<String> contListChoices = [];
  void addToContListChoices(String item) => contListChoices.add(item);
  void removeFromContListChoices(String item) => contListChoices.remove(item);
  void removeAtIndexFromContListChoices(int index) =>
      contListChoices.removeAt(index);
  void insertAtIndexInContListChoices(int index, String item) =>
      contListChoices.insert(index, item);
  void updateContListChoicesAtIndex(int index, Function(String) updateFn) =>
      contListChoices[index] = updateFn(contListChoices[index]);

  int? selectedCategoryId;

  String selectedCategoryName = ' ';

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - SQLite (Get All User Container Names)] action in ItemModify widget.
  List<GetAllUserContainerNamesRow>? userContainerNamesList;
  // Stores action output result for [Backend Call - SQLite (Get Item Details by ItemID)] action in ItemModify widget.
  List<GetItemDetailsByItemIDRow>? itemDetails;
  // Stores action output result for [Backend Call - SQLite (Get Container Details)] action in ItemModify widget.
  List<GetContainerDetailsRow>? containerDeets2;
  // Stores action output result for [Backend Call - SQLite (Get Image Base64)] action in ItemModify widget.
  List<GetImageBase64Row>? sqlmageBase64;
  // Stores action output result for [Backend Call - SQLite (Get Category Name By ID)] action in ItemModify widget.
  List<GetCategoryNameByIDRow>? sqlOrigCategoryName;
  // Stores action output result for [Backend Call - SQLite (Get Container Details)] action in ItemModify widget.
  List<GetContainerDetailsRow>? containerDeets;
  // Model for header component.
  late HeaderModel headerModel;
  bool isDataUploading_itemImage = false;
  FFUploadedFile uploadedLocalFile_itemImage =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // Stores action output result for [Custom Action - analyzeImageWithGemini] action in Icon widget.
  String? customGeminiApiResponse;
  // Stores action output result for [Custom Action - aiResponseToItemData] action in Icon widget.
  AiImageResponseStruct? aiGeneratedItemData;
  // Stores action output result for [Backend Call - SQLite (Get Category ID From Name)] action in Icon widget.
  List<GetCategoryIDFromNameRow>? aiSelectedCategoryID;
  // Stores action output result for [Custom Action - fileToBase64] action in Icon widget.
  String? imageBase64Copy;
  var scannedBarcode = '';
  // Stores action output result for [Backend Call - API (UPC Item DB)] action in scanBarcodeButton widget.
  ApiCallResponse? upcApiResult;
  // State field(s) for scannedBarcodeTextField widget.
  FocusNode? scannedBarcodeTextFieldFocusNode;
  TextEditingController? scannedBarcodeTextFieldTextController;
  String? Function(BuildContext, String?)?
      scannedBarcodeTextFieldTextControllerValidator;
  // State field(s) for itemNameTextField widget.
  FocusNode? itemNameTextFieldFocusNode;
  TextEditingController? itemNameTextFieldTextController;
  String? Function(BuildContext, String?)?
      itemNameTextFieldTextControllerValidator;
  // State field(s) for itemCounter widget.
  int? itemCounterValue;
  // State field(s) for itemDescTextField widget.
  FocusNode? itemDescTextFieldFocusNode;
  TextEditingController? itemDescTextFieldTextController;
  String? Function(BuildContext, String?)?
      itemDescTextFieldTextControllerValidator;
  // State field(s) for itemContainerDropdown widget.
  String? itemContainerDropdownValue;
  FormFieldController<String>? itemContainerDropdownValueController;
  // Stores action output result for [Backend Call - SQLite (Get Container ID from Container Name)] action in itemContainerDropdown widget.
  List<GetContainerIDFromContainerNameRow>? selectedContainerId;
  // Stores action output result for [Backend Call - SQLite (Get Last Created ItemID)] action in Button widget.
  List<GetLastCreatedItemIDRow>? newItemId;

  @override
  void initState(BuildContext context) {
    headerModel = createModel(context, () => HeaderModel());
  }

  @override
  void dispose() {
    headerModel.dispose();
    scannedBarcodeTextFieldFocusNode?.dispose();
    scannedBarcodeTextFieldTextController?.dispose();

    itemNameTextFieldFocusNode?.dispose();
    itemNameTextFieldTextController?.dispose();

    itemDescTextFieldFocusNode?.dispose();
    itemDescTextFieldTextController?.dispose();
  }
}
