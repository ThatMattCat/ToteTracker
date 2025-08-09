import '/backend/sqlite/sqlite_manager.dart';
import '/components/header/header_widget.dart';
import '/components/item_widget/item_widget_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'container_modify_widget.dart' show ContainerModifyWidget;
import 'package:flutter/material.dart';

class ContainerModifyModel extends FlutterFlowModel<ContainerModifyWidget> {
  ///  Local state fields for this page.

  List<String> parentContainerChoices = [];
  void addToParentContainerChoices(String item) =>
      parentContainerChoices.add(item);
  void removeFromParentContainerChoices(String item) =>
      parentContainerChoices.remove(item);
  void removeAtIndexFromParentContainerChoices(int index) =>
      parentContainerChoices.removeAt(index);
  void insertAtIndexInParentContainerChoices(int index, String item) =>
      parentContainerChoices.insert(index, item);
  void updateParentContainerChoicesAtIndex(
          int index, Function(String) updateFn) =>
      parentContainerChoices[index] = updateFn(parentContainerChoices[index]);

  String? selectedParentId;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - SQLite (Get All User Container IDs)] action in ContainerModify widget.
  List<GetAllUserContainerIDsRow>? sqlAllContainersList;
  // Stores action output result for [Backend Call - SQLite (Get Container Details)] action in ContainerModify widget.
  List<GetContainerDetailsRow>? containerDetails;
  // Stores action output result for [Backend Call - SQLite (Get Next Available Container Number)] action in ContainerModify widget.
  List<GetNextAvailableContainerNumberRow>? nextContainerNumber;
  // Model for header component.
  late HeaderModel headerModel;
  var containerQrCode = '';
  // State field(s) for containerQrCodeText widget.
  FocusNode? containerQrCodeTextFocusNode;
  TextEditingController? containerQrCodeTextTextController;
  String? Function(BuildContext, String?)?
      containerQrCodeTextTextControllerValidator;
  // State field(s) for containerName widget.
  FocusNode? containerNameFocusNode;
  TextEditingController? containerNameTextController;
  String? Function(BuildContext, String?)? containerNameTextControllerValidator;
  // State field(s) for containerDescription widget.
  FocusNode? containerDescriptionFocusNode;
  TextEditingController? containerDescriptionTextController;
  String? Function(BuildContext, String?)?
      containerDescriptionTextControllerValidator;
  // State field(s) for containerParentDropdown widget.
  String? containerParentDropdownValue;
  FormFieldController<String>? containerParentDropdownValueController;
  // Models for itemWidget dynamic component.
  late FlutterFlowDynamicModels<ItemWidgetModel> itemWidgetModels;

  @override
  void initState(BuildContext context) {
    headerModel = createModel(context, () => HeaderModel());
    itemWidgetModels = FlutterFlowDynamicModels(() => ItemWidgetModel());
  }

  @override
  void dispose() {
    headerModel.dispose();
    containerQrCodeTextFocusNode?.dispose();
    containerQrCodeTextTextController?.dispose();

    containerNameFocusNode?.dispose();
    containerNameTextController?.dispose();

    containerDescriptionFocusNode?.dispose();
    containerDescriptionTextController?.dispose();

    itemWidgetModels.dispose();
  }
}
