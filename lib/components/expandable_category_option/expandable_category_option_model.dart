import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'expandable_category_option_widget.dart'
    show ExpandableCategoryOptionWidget;
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class ExpandableCategoryOptionModel
    extends FlutterFlowModel<ExpandableCategoryOptionWidget> {
  ///  Local state fields for this component.

  int? stateCategoryID = 0;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - SQLite (Get Category ID From Name)] action in expandableCategoryOption widget.
  List<GetCategoryIDFromNameRow>? sqlCategoryId;
  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    expandableExpandableController.dispose();
  }
}
