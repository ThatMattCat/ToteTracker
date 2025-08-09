import '/backend/sqlite/sqlite_manager.dart';
import '/components/header/header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'search_items_widget.dart' show SearchItemsWidget;
import 'package:flutter/material.dart';

class SearchItemsModel extends FlutterFlowModel<SearchItemsWidget> {
  ///  Local state fields for this page.
  /// Search Results saved to the page state
  List<SearchAllItemFieldsByTextRow> pageSearchResults = [];
  void addToPageSearchResults(SearchAllItemFieldsByTextRow item) =>
      pageSearchResults.add(item);
  void removeFromPageSearchResults(SearchAllItemFieldsByTextRow item) =>
      pageSearchResults.remove(item);
  void removeAtIndexFromPageSearchResults(int index) =>
      pageSearchResults.removeAt(index);
  void insertAtIndexInPageSearchResults(
          int index, SearchAllItemFieldsByTextRow item) =>
      pageSearchResults.insert(index, item);
  void updatePageSearchResultsAtIndex(
          int index, Function(SearchAllItemFieldsByTextRow) updateFn) =>
      pageSearchResults[index] = updateFn(pageSearchResults[index]);

  ///  State fields for stateful widgets in this page.

  // Model for header component.
  late HeaderModel headerModel;
  // State field(s) for searchTextField widget.
  FocusNode? searchTextFieldFocusNode;
  TextEditingController? searchTextFieldTextController;
  String? Function(BuildContext, String?)?
      searchTextFieldTextControllerValidator;
  // Stores action output result for [Backend Call - SQLite (Search All Item Fields By Text)] action in searchTextField widget.
  List<SearchAllItemFieldsByTextRow>? sqlSearchResults;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  List<String>? get choiceChipsValues => choiceChipsValueController?.value;
  set choiceChipsValues(List<String>? val) =>
      choiceChipsValueController?.value = val;

  @override
  void initState(BuildContext context) {
    headerModel = createModel(context, () => HeaderModel());
  }

  @override
  void dispose() {
    headerModel.dispose();
    searchTextFieldFocusNode?.dispose();
    searchTextFieldTextController?.dispose();
  }
}
