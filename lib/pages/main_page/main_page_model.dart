import '/backend/sqlite/sqlite_manager.dart';
import '/components/container_widget/container_widget_widget.dart';
import '/components/header/header_widget.dart';
import '/components/item_widget/item_widget_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'main_page_widget.dart' show MainPageWidget;
import 'package:flutter/material.dart';

class MainPageModel extends FlutterFlowModel<MainPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - SQLite (Get Last LoggedIn User)] action in MainPage widget.
  List<GetLastLoggedInUserRow>? lastLoggedUserID;
  // Stores action output result for [Backend Call - SQLite (Get User Name By ID)] action in MainPage widget.
  List<GetUserNameByIDRow>? lastLoggedUserName;
  // Model for header component.
  late HeaderModel headerModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Models for containerWidget dynamic component.
  late FlutterFlowDynamicModels<ContainerWidgetModel> containerWidgetModels;
  // Models for itemWidget dynamic component.
  late FlutterFlowDynamicModels<ItemWidgetModel> itemWidgetModels;

  @override
  void initState(BuildContext context) {
    headerModel = createModel(context, () => HeaderModel());
    containerWidgetModels =
        FlutterFlowDynamicModels(() => ContainerWidgetModel());
    itemWidgetModels = FlutterFlowDynamicModels(() => ItemWidgetModel());
  }

  @override
  void dispose() {
    headerModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();

    containerWidgetModels.dispose();
    itemWidgetModels.dispose();
  }
}
