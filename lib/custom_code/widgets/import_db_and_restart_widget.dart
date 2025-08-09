// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:restart_app/restart_app.dart';

class ImportDbAndRestartWidget extends StatefulWidget {
  const ImportDbAndRestartWidget({
    Key? key,
    this.width,
    this.height,
    this.onImportSuccess,
    this.onImportError,
    this.restartApp = false,
  }) : super(key: key);

  final double? width;
  final double? height;
  final Future<dynamic> Function()? onImportSuccess;
  final Future<dynamic> Function()? onImportError;
  final bool restartApp;

  @override
  _ImportDbAndRestartWidgetState createState() =>
      _ImportDbAndRestartWidgetState();
}

class _ImportDbAndRestartWidgetState extends State<ImportDbAndRestartWidget> {
  bool _isImporting = false;

  Future<void> _ImportDbAndRestart() async {
    setState(() {
      _isImporting = true;
    });

    try {
      // Open file picker
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        // Get the picked file
        File pickedFile = File(result.files.single.path!);

        // Get the databases directory
        final String dbPath = await getDatabasesPath();

        // Define the destination path
        final String destinationPath = path.join(dbPath, 'totetracker.db');
        final File destinationFile = File(destinationPath);

        // Delete existing database if it exists
        if (await destinationFile.exists()) {
          await destinationFile.delete();
        }

        // Copy the picked file to the destination
        await pickedFile.copy(destinationPath);

        // Call success callback if provided
        if (widget.onImportSuccess != null) {
          await widget.onImportSuccess!();
        }

        // Show success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Database imported successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        }

        // Restart app if requested
        if (widget.restartApp) {
          await Future.delayed(
              const Duration(seconds: 1)); // Give time for snackbar
          Restart.restartApp();
        }
      }
    } catch (e) {
      // Call error callback if provided
      if (widget.onImportError != null) {
        await widget.onImportError!();
      }

      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error importing database: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isImporting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton(
        onPressed: _isImporting ? null : _ImportDbAndRestart,
        style: ElevatedButton.styleFrom(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: _isImporting
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primaryBackground,
                  ),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.download,
                    color: FlutterFlowTheme.of(context).primaryText,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Import Database',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                  ),
                ],
              ),
      ),
    );
  }
}
// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!
