import '/components/header/header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'x_item_details_widget.dart' show XItemDetailsWidget;
import 'package:flutter/material.dart';

class XItemDetailsModel extends FlutterFlowModel<XItemDetailsWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for header component.
  late HeaderModel headerModel;

  @override
  void initState(BuildContext context) {
    headerModel = createModel(context, () => HeaderModel());
  }

  @override
  void dispose() {
    headerModel.dispose();
  }
}
