import '/backend/sqlite/sqlite_manager.dart';
import '/components/expandable_category_option/expandable_category_option_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'nested_list_options_model.dart';
export 'nested_list_options_model.dart';

/// Used for nested options such as Categories and possibly labels
class NestedListOptionsWidget extends StatefulWidget {
  const NestedListOptionsWidget({
    super.key,
    required this.callback,
  });

  final Future Function(String finalChosenName, int finalChosenId)? callback;

  @override
  State<NestedListOptionsWidget> createState() =>
      _NestedListOptionsWidgetState();
}

class _NestedListOptionsWidgetState extends State<NestedListOptionsWidget> {
  late NestedListOptionsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NestedListOptionsModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 40.0),
      child: Material(
        color: Colors.transparent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            width: MediaQuery.sizeOf(context).width * 0.8,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Choose Category',
                          style: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .override(
                                font: GoogleFonts.urbanist(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .fontStyle,
                                ),
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .fontStyle,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 32.0),
                    child: FutureBuilder<List<GetAllParentCategoriesRow>>(
                      future: SQLiteManager.instance.getAllParentCategories(),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                            ),
                          );
                        }
                        final listViewGetAllParentCategoriesRowList =
                            snapshot.data!;

                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount:
                              listViewGetAllParentCategoriesRowList.length,
                          itemBuilder: (context, listViewIndex) {
                            final listViewGetAllParentCategoriesRow =
                                listViewGetAllParentCategoriesRowList[
                                    listViewIndex];
                            return wrapWithModel(
                              model: _model.expandableCategoryOptionModels
                                  .getModel(
                                listViewGetAllParentCategoriesRow.parentId
                                    .toString(),
                                listViewIndex,
                              ),
                              updateCallback: () => safeSetState(() {}),
                              child: ExpandableCategoryOptionWidget(
                                key: Key(
                                  'Keymkc_${listViewGetAllParentCategoriesRow.parentId.toString()}',
                                ),
                                categoryName: listViewGetAllParentCategoriesRow
                                    .parentName!,
                                categoryId:
                                    listViewGetAllParentCategoriesRow.parentId,
                                callbackAction: (chosenCategoryID,
                                    chosenCategoryName) async {
                                  await widget.callback?.call(
                                    chosenCategoryName,
                                    chosenCategoryID,
                                  );
                                  Navigator.pop(context);
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
