import '/components/header/header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'settings_widget.dart' show SettingsWidget;
import 'package:flutter/material.dart';

class SettingsModel extends FlutterFlowModel<SettingsWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for header component.
  late HeaderModel headerModel;
  // State field(s) for geminiApiTextField widget.
  FocusNode? geminiApiTextFieldFocusNode;
  TextEditingController? geminiApiTextFieldTextController;
  String? Function(BuildContext, String?)?
      geminiApiTextFieldTextControllerValidator;

  @override
  void initState(BuildContext context) {
    headerModel = createModel(context, () => HeaderModel());
  }

  @override
  void dispose() {
    headerModel.dispose();
    geminiApiTextFieldFocusNode?.dispose();
    geminiApiTextFieldTextController?.dispose();
  }
}
