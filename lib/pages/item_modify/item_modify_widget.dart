import '/backend/api_requests/api_calls.dart';
import '/backend/sqlite/sqlite_manager.dart';
import '/components/header/header_widget.dart';
import '/components/nested_list_options/nested_list_options_widget.dart';
import '/flutter_flow/flutter_flow_count_controller.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'item_modify_model.dart';
export 'item_modify_model.dart';

class ItemModifyWidget extends StatefulWidget {
  const ItemModifyWidget({
    super.key,
    this.itemId,
    this.containerId,
  });

  final int? itemId;
  final String? containerId;

  static String routeName = 'ItemModify';
  static String routePath = '/itemModify';

  @override
  State<ItemModifyWidget> createState() => _ItemModifyWidgetState();
}

class _ItemModifyWidgetState extends State<ItemModifyWidget> {
  late ItemModifyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ItemModifyModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      // Get Container Names
      _model.userContainerNamesList =
          await SQLiteManager.instance.getAllUserContainerNames(
        userId: FFAppState().userId,
      );
      _model.contListChoices = _model.userContainerNamesList!
          .map((e) => e.containerName)
          .withoutNulls
          .toList()
          .toList()
          .cast<String>();
      safeSetState(() {});
      if ((widget.itemId != null) && (widget.itemId != 0)) {
        // Get Item Details
        _model.itemDetails =
            await SQLiteManager.instance.getItemDetailsByItemID(
          itemId: widget.itemId!,
        );
        _model.containerDeets2 =
            await SQLiteManager.instance.getContainerDetails(
          containerId: _model.itemDetails?.firstOrNull?.containerId,
        );
        _model.origContainerName =
            _model.containerDeets2?.firstOrNull?.containerName;
        safeSetState(() {});
        // Set Container Dropdown Choice
        safeSetState(() {
          _model.itemContainerDropdownValueController?.value =
              _model.containerDeets2!.firstOrNull!.containerName!;
        });
        // Set Selected Container to Original
        _model.selectedContainer = _model.itemDetails?.firstOrNull?.containerId;
        safeSetState(() {});
        // Set Name Text
        safeSetState(() {
          _model.itemNameTextFieldTextController?.text =
              _model.itemDetails!.firstOrNull!.name!;
        });
        // Set Page Title
        _model.pageTitle = valueOrDefault<String>(
          _model.itemDetails?.firstOrNull?.name,
          'NoNameFoundException',
        );
        safeSetState(() {});
        // Set Quantity
        safeSetState(() {
          _model.itemCounterValue = valueOrDefault<int>(
            _model.itemDetails?.firstOrNull?.quantity,
            1,
          );
        });
        // Set Description Text
        safeSetState(() {
          _model.itemDescTextFieldTextController?.text =
              _model.itemDetails!.firstOrNull!.description!;
        });
        _model.sqlmageBase64 = await SQLiteManager.instance.getImageBase64(
          imageId: widget.itemId!,
        );
        if (_model.sqlmageBase64?.firstOrNull?.base64 != null &&
            _model.sqlmageBase64?.firstOrNull?.base64 != '') {
          _model.imageB64 = _model.sqlmageBase64?.firstOrNull?.base64;
          safeSetState(() {});
        }
        if (_model.itemDetails?.firstOrNull?.category != null) {
          _model.sqlOrigCategoryName =
              await SQLiteManager.instance.getCategoryNameByID(
            categoryId: _model.itemDetails?.firstOrNull?.category,
          );
          _model.selectedCategoryId = _model.itemDetails?.firstOrNull?.category;
          _model.selectedCategoryName =
              _model.sqlOrigCategoryName!.firstOrNull!.categoryName!;
          safeSetState(() {});
        }
      } else {
        if (widget.containerId != null && widget.containerId != '') {
          _model.containerDeets =
              await SQLiteManager.instance.getContainerDetails(
            containerId: widget.containerId,
          );
          _model.origContainerName =
              _model.containerDeets?.firstOrNull?.containerName;
          safeSetState(() {});
          // Set Container Dropdown Choice
          safeSetState(() {
            _model.itemContainerDropdownValueController?.value =
                _model.containerDeets!.firstOrNull!.containerName!;
          });
          // Set Selected Container to Original
          _model.selectedContainer = widget.containerId;
          safeSetState(() {});
        }
      }
    });

    _model.scannedBarcodeTextFieldTextController ??= TextEditingController();
    _model.scannedBarcodeTextFieldFocusNode ??= FocusNode();

    _model.itemNameTextFieldTextController ??= TextEditingController();
    _model.itemNameTextFieldFocusNode ??= FocusNode();

    _model.itemDescTextFieldTextController ??= TextEditingController();
    _model.itemDescTextFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  wrapWithModel(
                    model: _model.headerModel,
                    updateCallback: () => safeSetState(() {}),
                    child: HeaderWidget(
                      title: valueOrDefault<String>(
                        _model.pageTitle,
                        'New Item',
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5.0,
                          color: Color(0x20000000),
                          offset: Offset(
                            0.0,
                            2.0,
                          ),
                        )
                      ],
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(14.0, 0.0, 14.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 200.0,
                            height: 200.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).alternate,
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 1.0,
                              ),
                            ),
                            child: Stack(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              children: [
                                Container(
                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                  height: double.infinity,
                                  child: custom_widgets.Base64Image(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    height: double.infinity,
                                    base64: _model.imageB64,
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(1.0, -1.0),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        final selectedMedia = await selectMedia(
                                          maxWidth: 500.00,
                                          maxHeight: 500.00,
                                          imageQuality: 30,
                                          includeDimensions: true,
                                          multiImage: false,
                                        );
                                        if (selectedMedia != null &&
                                            selectedMedia.every((m) =>
                                                validateFileFormat(
                                                    m.storagePath, context))) {
                                          safeSetState(() =>
                                              _model.isDataUploading_itemImage =
                                                  true);
                                          var selectedUploadedFiles =
                                              <FFUploadedFile>[];

                                          try {
                                            selectedUploadedFiles =
                                                selectedMedia
                                                    .map((m) => FFUploadedFile(
                                                          name: m.storagePath
                                                              .split('/')
                                                              .last,
                                                          bytes: m.bytes,
                                                          height: m.dimensions
                                                              ?.height,
                                                          width: m.dimensions
                                                              ?.width,
                                                          blurHash: m.blurHash,
                                                        ))
                                                    .toList();
                                          } finally {
                                            _model.isDataUploading_itemImage =
                                                false;
                                          }
                                          if (selectedUploadedFiles.length ==
                                              selectedMedia.length) {
                                            safeSetState(() {
                                              _model.uploadedLocalFile_itemImage =
                                                  selectedUploadedFiles.first;
                                            });
                                          } else {
                                            safeSetState(() {});
                                            return;
                                          }
                                        }

                                        _model.customGeminiApiResponse =
                                            await actions
                                                .analyzeImageWithGemini(
                                          FFAppState().geminiApiKey,
                                          _model.uploadedLocalFile_itemImage,
                                          'Focus on the subject of the photo. Generate a JSON object with two keys: \"name\" and \"category\" - Only return the JSON object. The \"name\" value should be under 40 characters. The \"category\" should be a single child from the following list:\\n\\n**Electronics**\\n- Components & Parts\\n- Cables & Connectors\\n- Computer Hardware\\n- Audio/Video Equipment\\n- Batteries & Chargers\\n- Smart Home Devices\\n- Phone & Tablet Accessories\\n- General Electronics\\n\\n**Hobby & Crafts**\\n- Art Supplies\\n- Sewing & Fabric\\n- Model Building\\n- Board Games & Puzzles\\n- Sports & Recreation\\n- Musical Equipment\\n- Photography Gear\\n- Collectibles\\n- General Hobby & Crafts\\n\\n**Household**\\n- Cleaning Supplies\\n- Kitchen Items\\n- Bathroom Supplies\\n- Linens & Bedding\\n- Home Decor\\n- Lighting\\n- Furniture Parts\\n- General Household\\n\\n**Tools & Hardware**\\n- Hand Tools\\n- Power Tools\\n- Fasteners & Screws\\n- Adhesives & Tape\\n- Measuring Tools\\n- Safety Equipment\\n- Tool Accessories\\n- Plumbing Parts\\n- Electrical Supplies\\n- General Tools & Hardware\\n\\n**Office & School**\\n- Writing Supplies\\n- Paper Products\\n- Filing & Organization\\n- Books & References\\n- Computer Accessories\\n- Packaging & Shipping\\n- General Office & School\\n\\n**Clothing & Personal**\\n- Seasonal Clothing\\n- Accessories\\n- Shoes & Footwear\\n- Personal Care Items\\n- Jewelry\\n- Bags & Luggage\\n- Adult\\n- General Clothing & Personal\\n\\n**Outdoor & Garden**\\n- Garden Tools\\n- Seeds & Planting\\n- Camping Equipment\\n- Patio & Outdoor\\n- Pool Supplies\\n- Grilling Accessories\\n- General Outdoor & Garden\\n\\n**Automotive**\\n- Maintenance Items\\n- Car Care Products\\n- Tools & Equipment\\n- Replacement Parts\\n- Emergency Supplies\\n- General Automotive\\n\\n**Health & Safety**\\n- First Aid Supplies\\n- Medications\\n- Health Devices\\n- Supplements\\n- General Health & Safety\\n\\n**Food & Consumables**\\n- Non-perishable Food\\n- Spices & Seasonings\\n- Baking Supplies\\n- Pet Supplies\\n- Disposables\\n- General Food & Consumables\\n\\n**Documents & Media**\\n- Important Papers\\n- Photos & Albums\\n- Digital Media\\n- Backup Storage\\n- Manuals & Guides\\n- General Documents & Media\\n\\n**Seasonal & Holiday**\\n- Christmas Items\\n- Halloween Decorations\\n- Holiday Decor\\n- Party Supplies\\n- Seasonal Equipment',
                                        );
                                        _model.aiGeneratedItemData =
                                            await actions.aiResponseToItemData(
                                          _model.customGeminiApiResponse!,
                                        );
                                        // Set Name From AI
                                        safeSetState(() {
                                          _model.itemNameTextFieldTextController
                                              ?.text = valueOrDefault<String>(
                                            _model.aiGeneratedItemData?.name,
                                            'AiGenNameFailedError',
                                          );
                                        });
                                        // Set Desc to AI Category
                                        safeSetState(() {
                                          _model.itemDescTextFieldTextController
                                              ?.text = valueOrDefault<String>(
                                            _model
                                                .aiGeneratedItemData?.category,
                                            'AIGenCategoryFailedError',
                                          );
                                        });
                                        _model.aiSelectedCategoryID =
                                            await SQLiteManager.instance
                                                .getCategoryIDFromName(
                                          name: _model
                                              .aiGeneratedItemData?.category,
                                        );
                                        _model.selectedCategoryId = _model
                                            .aiSelectedCategoryID
                                            ?.firstOrNull
                                            ?.categoryId;
                                        _model.selectedCategoryName = _model
                                            .aiGeneratedItemData!.category;
                                        safeSetState(() {});
                                        _model.imageBase64Copy =
                                            await actions.fileToBase64(
                                          _model.uploadedLocalFile_itemImage,
                                        );
                                        _model.imageB64 =
                                            _model.imageBase64Copy;
                                        safeSetState(() {});

                                        safeSetState(() {});
                                      },
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 48.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              FFButtonWidget(
                                onPressed: () async {
                                  // Scan Barcode
                                  _model.scannedBarcode =
                                      await FlutterBarcodeScanner.scanBarcode(
                                    '#C62828', // scanning line color
                                    'Cancel', // cancel button text
                                    true, // whether to show the flash icon
                                    ScanMode.BARCODE,
                                  );

                                  if (_model.scannedBarcode != '-1') {
                                    safeSetState(() {
                                      _model
                                          .scannedBarcodeTextFieldTextController
                                          ?.text = _model.scannedBarcode;
                                    });
                                    _model.upcApiResult =
                                        await UPCItemDBCall.call(
                                      upc: _model.scannedBarcode,
                                    );

                                    if ((_model.upcApiResult?.succeeded ??
                                        true)) {
                                      safeSetState(() {
                                        _model.itemNameTextFieldTextController
                                            ?.text = UPCItemDBCall.name(
                                          (_model.upcApiResult?.jsonBody ?? ''),
                                        )!;
                                      });
                                      safeSetState(() {
                                        _model.itemDescTextFieldTextController
                                            ?.text = UPCItemDBCall.description(
                                          (_model.upcApiResult?.jsonBody ?? ''),
                                        )!;
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Successfully Called UPCItemDB for UPC: ${_model.scannedBarcode}',
                                            style: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                          ),
                                          duration:
                                              Duration(milliseconds: 4000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondary,
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'UPCItemDB API Call Failed For UPC: ${_model.scannedBarcode}',
                                            style: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                          ),
                                          duration:
                                              Duration(milliseconds: 4000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondary,
                                        ),
                                      );
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'No Barcode Scanned',
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 4000),
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .secondary,
                                      ),
                                    );
                                  }

                                  safeSetState(() {});
                                },
                                text: 'Scan',
                                icon: FaIcon(
                                  FontAwesomeIcons.barcode,
                                  size: 15.0,
                                ),
                                options: FFButtonOptions(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context).primary,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        font: GoogleFonts.plusJakartaSans(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                  elevation: 0.0,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width * 0.5,
                                  child: TextFormField(
                                    controller: _model
                                        .scannedBarcodeTextFieldTextController,
                                    focusNode:
                                        _model.scannedBarcodeTextFieldFocusNode,
                                    autofocus: false,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.plusJakartaSans(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            fontSize: 12.0,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                      hintText: 'Item Barcode',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            font: GoogleFonts.plusJakartaSans(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                            fontSize: 12.0,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      filled: true,
                                      fillColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.plusJakartaSans(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          fontSize: 12.0,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                    cursorColor: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    validator: _model
                                        .scannedBarcodeTextFieldTextControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 2.0,
                            color: FlutterFlowTheme.of(context).alternate,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  child: TextFormField(
                                    controller:
                                        _model.itemNameTextFieldTextController,
                                    focusNode:
                                        _model.itemNameTextFieldFocusNode,
                                    onChanged: (_) => EasyDebounce.debounce(
                                      '_model.itemNameTextFieldTextController',
                                      Duration(milliseconds: 2000),
                                      () => safeSetState(() {}),
                                    ),
                                    autofocus: false,
                                    textInputAction: TextInputAction.next,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: 'Item Name',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.plusJakartaSans(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      filled: true,
                                      fillColor: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              16.0, 12.0, 16.0, 12.0),
                                      suffixIcon: _model
                                              .itemNameTextFieldTextController!
                                              .text
                                              .isNotEmpty
                                          ? InkWell(
                                              onTap: () async {
                                                _model
                                                    .itemNameTextFieldTextController
                                                    ?.clear();
                                                safeSetState(() {});
                                              },
                                              child: Icon(
                                                Icons.clear,
                                                size: 22,
                                              ),
                                            )
                                          : null,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.plusJakartaSans(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                    validator: _model
                                        .itemNameTextFieldTextControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                              ),
                              Container(
                                width: 80.0,
                                height: 40.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(8.0),
                                  shape: BoxShape.rectangle,
                                ),
                                child: FlutterFlowCountController(
                                  decrementIconBuilder: (enabled) => Icon(
                                    Icons.remove_rounded,
                                    color: enabled
                                        ? FlutterFlowTheme.of(context)
                                            .secondaryText
                                        : FlutterFlowTheme.of(context)
                                            .alternate,
                                    size: 20.0,
                                  ),
                                  incrementIconBuilder: (enabled) => Icon(
                                    Icons.add_rounded,
                                    color: enabled
                                        ? FlutterFlowTheme.of(context).primary
                                        : FlutterFlowTheme.of(context)
                                            .alternate,
                                    size: 20.0,
                                  ),
                                  countBuilder: (count) => Text(
                                    count.toString(),
                                    style: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          font: GoogleFonts.plusJakartaSans(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontStyle,
                                        ),
                                  ),
                                  count: _model.itemCounterValue ??= 1,
                                  updateCount: (count) => safeSetState(
                                      () => _model.itemCounterValue = count),
                                  stepSize: 1,
                                  minimum: 0,
                                  contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          6.0, 0.0, 6.0, 0.0),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: double.infinity,
                            child: TextFormField(
                              controller:
                                  _model.itemDescTextFieldTextController,
                              focusNode: _model.itemDescTextFieldFocusNode,
                              onChanged: (_) => EasyDebounce.debounce(
                                '_model.itemDescTextFieldTextController',
                                Duration(milliseconds: 2000),
                                () => safeSetState(() {}),
                              ),
                              textInputAction: TextInputAction.next,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Description',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.plusJakartaSans(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).primary,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 12.0, 16.0, 12.0),
                                suffixIcon: _model
                                        .itemDescTextFieldTextController!
                                        .text
                                        .isNotEmpty
                                    ? InkWell(
                                        onTap: () async {
                                          _model.itemDescTextFieldTextController
                                              ?.clear();
                                          safeSetState(() {});
                                        },
                                        child: Icon(
                                          Icons.clear,
                                          size: 22,
                                        ),
                                      )
                                    : null,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.plusJakartaSans(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                              maxLines: 3,
                              minLines: 2,
                              validator: _model
                                  .itemDescTextFieldTextControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                          FlutterFlowDropDown<String>(
                            controller:
                                _model.itemContainerDropdownValueController ??=
                                    FormFieldController<String>(null),
                            options: _model.contListChoices,
                            onChanged: (val) async {
                              safeSetState(() =>
                                  _model.itemContainerDropdownValue = val);
                              _model.selectedContainerId = await SQLiteManager
                                  .instance
                                  .getContainerIDFromContainerName(
                                containerName:
                                    _model.itemContainerDropdownValue!,
                              );
                              _model.selectedContainer = _model
                                  .selectedContainerId
                                  ?.firstOrNull
                                  ?.containerId;
                              safeSetState(() {});

                              safeSetState(() {});
                            },
                            width: double.infinity,
                            height: 50.0,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.plusJakartaSans(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                            hintText: 'Select Container',
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                            fillColor:
                                FlutterFlowTheme.of(context).primaryBackground,
                            elevation: 2.0,
                            borderColor: FlutterFlowTheme.of(context).alternate,
                            borderWidth: 1.0,
                            borderRadius: 8.0,
                            margin: EdgeInsetsDirectional.fromSTEB(
                                10.0, 0.0, 0.0, 0.0),
                            hidesUnderline: true,
                            isOverButton: false,
                            isSearchable: false,
                            isMultiSelect: false,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                5.0, 0.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Category:',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.plusJakartaSans(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                                Text(
                                  _model.selectedCategoryName
                                      .maybeHandleOverflow(
                                    maxChars: 25,
                                    replacement: '…',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        font: GoogleFonts.plusJakartaSans(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .titleMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontStyle,
                                      ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(1.0, 0.0),
                                  child: Builder(
                                    builder: (context) => FlutterFlowIconButton(
                                      borderRadius: 8.0,
                                      buttonSize: 30.0,
                                      fillColor:
                                          FlutterFlowTheme.of(context).primary,
                                      icon: Icon(
                                        Icons.mode,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        size: 15.0,
                                      ),
                                      onPressed: () async {
                                        await showDialog(
                                          context: context,
                                          builder: (dialogContext) {
                                            return Dialog(
                                              elevation: 0,
                                              insetPadding: EdgeInsets.zero,
                                              backgroundColor:
                                                  Colors.transparent,
                                              alignment:
                                                  AlignmentDirectional(0.0, 0.0)
                                                      .resolve(
                                                          Directionality.of(
                                                              context)),
                                              child: GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(dialogContext)
                                                      .unfocus();
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();
                                                },
                                                child: NestedListOptionsWidget(
                                                  callback: (finalChosenName,
                                                      finalChosenId) async {
                                                    _model.selectedCategoryId =
                                                        finalChosenId;
                                                    _model.selectedCategoryName =
                                                        finalChosenName;
                                                    safeSetState(() {});
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ].divide(SizedBox(width: 10.0)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 5.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                FFButtonWidget(
                                  onPressed: () async {
                                    if (_model.selectedContainer == null ||
                                        _model.selectedContainer == '') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Please select a container',
                                            style: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                          ),
                                          duration:
                                              Duration(milliseconds: 4000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondary,
                                        ),
                                      );
                                    } else {
                                      if ((widget.itemId != null) &&
                                          (widget.itemId != 0)) {
                                        await SQLiteManager.instance
                                            .updateItemDetails(
                                          itemId: widget.itemId!,
                                          itemDescription: _model
                                              .itemDescTextFieldTextController
                                              .text,
                                          itemName: _model
                                              .itemNameTextFieldTextController
                                              .text,
                                          containerId:
                                              _model.selectedContainer!,
                                          quantity: _model.itemCounterValue,
                                          category: _model.selectedCategoryId,
                                        );
                                        if (_model.imageB64 != null &&
                                            _model.imageB64 != '') {
                                          await SQLiteManager.instance
                                              .updateImageBase64(
                                            base64: _model.imageB64!,
                                            imageId: widget.itemId!,
                                          );
                                        }
                                      } else {
                                        await SQLiteManager.instance
                                            .createNewItem(
                                          containerId:
                                              _model.selectedContainer!,
                                          itemName: _model
                                              .itemNameTextFieldTextController
                                              .text,
                                          itemDescription: _model
                                              .itemDescTextFieldTextController
                                              .text,
                                          quantity: _model.itemCounterValue,
                                          category: _model.selectedCategoryId,
                                        );
                                        _model.newItemId = await SQLiteManager
                                            .instance
                                            .getLastCreatedItemID();
                                        if (_model.imageB64 != null &&
                                            _model.imageB64 != '') {
                                          await SQLiteManager.instance
                                              .updateImageBase64(
                                            base64: _model.imageB64!,
                                            imageId: _model
                                                .newItemId!.firstOrNull!.itemId,
                                          );
                                        }
                                      }

                                      FFAppState().update(() {});
                                      context.safePop();
                                    }

                                    safeSetState(() {});
                                  },
                                  text: 'Save',
                                  options: FFButtonOptions(
                                    padding: EdgeInsets.all(10.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context).primary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          font: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          fontSize: 20.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontStyle,
                                        ),
                                    elevation: 2.0,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                FFButtonWidget(
                                  onPressed: () async {
                                    if ((widget.itemId != null) &&
                                        (widget.itemId != 0)) {
                                      await SQLiteManager.instance.deleteItem(
                                        itemId: widget.itemId!,
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Item Deleted',
                                            style: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                          ),
                                          duration:
                                              Duration(milliseconds: 4000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondary,
                                        ),
                                      );
                                      context.safePop();
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'New Item, Nothing To Delete',
                                            style: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                          ),
                                          duration:
                                              Duration(milliseconds: 4000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondary,
                                        ),
                                      );
                                    }
                                  },
                                  text: 'Delete',
                                  options: FFButtonOptions(
                                    padding: EdgeInsets.all(10.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context).primary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          font: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          fontSize: 20.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontStyle,
                                        ),
                                    elevation: 2.0,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]
                            .divide(SizedBox(height: 16.0))
                            .addToEnd(SizedBox(height: 20.0)),
                      ),
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
