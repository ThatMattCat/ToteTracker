import '/components/expandable_category_option/expandable_category_option_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'nested_list_options_widget.dart' show NestedListOptionsWidget;
import 'package:flutter/material.dart';

class NestedListOptionsModel extends FlutterFlowModel<NestedListOptionsWidget> {
  ///  State fields for stateful widgets in this component.

  // Models for expandableCategoryOption dynamic component.
  late FlutterFlowDynamicModels<ExpandableCategoryOptionModel>
      expandableCategoryOptionModels;

  @override
  void initState(BuildContext context) {
    expandableCategoryOptionModels =
        FlutterFlowDynamicModels(() => ExpandableCategoryOptionModel());
  }

  @override
  void dispose() {
    expandableCategoryOptionModels.dispose();
  }
}
