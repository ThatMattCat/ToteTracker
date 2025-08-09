import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'expandable_category_option_model.dart';
export 'expandable_category_option_model.dart';

/// eg: Top-level "Category" that expands to show nested category options
class ExpandableCategoryOptionWidget extends StatefulWidget {
  const ExpandableCategoryOptionWidget({
    super.key,
    String? categoryName,
    String? categoryDescription,
    this.categoryId,
    required this.callbackAction,
  })  : this.categoryName = categoryName ?? 'A Category',
        this.categoryDescription = categoryDescription ?? ' ';

  /// Top-Level Option Name
  final String categoryName;

  /// Optional Option Description
  final String categoryDescription;

  /// Top-Level Category ID
  final int? categoryId;

  final Future Function(int chosenCategoryID, String chosenCategoryName)?
      callbackAction;

  @override
  State<ExpandableCategoryOptionWidget> createState() =>
      _ExpandableCategoryOptionWidgetState();
}

class _ExpandableCategoryOptionWidgetState
    extends State<ExpandableCategoryOptionWidget> {
  late ExpandableCategoryOptionModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ExpandableCategoryOptionModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if ((widget.categoryId == null) || (widget.categoryId! < 1)) {
        _model.sqlCategoryId =
            await SQLiteManager.instance.getCategoryIDFromName(
          name: widget.categoryName,
        );
        _model.stateCategoryID = _model.sqlCategoryId?.firstOrNull?.categoryId;
        safeSetState(() {});
      } else {
        _model.stateCategoryID = widget.categoryId;
        safeSetState(() {});
      }
    });

    _model.expandableExpandableController =
        ExpandableController(initialExpanded: false);
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Container(
        width: double.infinity,
        color: Color(0x00000000),
        child: ExpandableNotifier(
          controller: _model.expandableExpandableController,
          child: ExpandablePanel(
            header: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 8.0, 12.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.categoryName,
                    style: FlutterFlowTheme.of(context).titleLarge.override(
                          font: GoogleFonts.urbanist(
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleLarge
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleLarge
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleLarge
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleLarge.fontStyle,
                        ),
                  ),
                ],
              ),
            ),
            collapsed: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    widget.categoryDescription,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.plusJakartaSans(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).secondaryText,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                ],
              ),
            ),
            expanded: FutureBuilder<List<GetChildrenForParentCategoryIDRow>>(
              future: SQLiteManager.instance.getChildrenForParentCategoryID(
                parentId: valueOrDefault<int>(
                  _model.stateCategoryID,
                  0,
                ),
              ),
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
                final listViewGetChildrenForParentCategoryIDRowList =
                    snapshot.data!;

                return ListView.builder(
                  padding: EdgeInsets.zero,
                  primary: false,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount:
                      listViewGetChildrenForParentCategoryIDRowList.length,
                  itemBuilder: (context, listViewIndex) {
                    final listViewGetChildrenForParentCategoryIDRow =
                        listViewGetChildrenForParentCategoryIDRowList[
                            listViewIndex];
                    return InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        await widget.callbackAction?.call(
                          listViewGetChildrenForParentCategoryIDRow.childId!,
                          listViewGetChildrenForParentCategoryIDRow.childName!,
                        );
                      },
                      child: Material(
                        color: Colors.transparent,
                        child: ListTile(
                          title: Text(
                            listViewGetChildrenForParentCategoryIDRow.childName!
                                .maybeHandleOverflow(
                              maxChars: 30,
                              replacement: '…',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .titleLarge
                                .override(
                                  font: GoogleFonts.urbanist(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontStyle,
                                  ),
                                  fontSize: 20.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .fontStyle,
                                ),
                          ),
                          tileColor: FlutterFlowTheme.of(context).alternate,
                          dense: false,
                          contentPadding: EdgeInsetsDirectional.fromSTEB(
                              28.0, 0.0, 12.0, 0.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            theme: ExpandableThemeData(
              tapHeaderToExpand: true,
              tapBodyToExpand: true,
              tapBodyToCollapse: false,
              headerAlignment: ExpandablePanelHeaderAlignment.center,
              hasIcon: true,
              expandIcon: Icons.keyboard_arrow_right,
              collapseIcon: Icons.keyboard_arrow_down,
              iconSize: 33.0,
              iconColor: FlutterFlowTheme.of(context).primaryText,
            ),
          ),
        ),
      ),
    );
  }
}
