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
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DatabaseBackupWidget extends StatefulWidget {
  const DatabaseBackupWidget({
    Key? key,
    this.width,
    this.height,
    this.buttonText,
    this.buttonColor,
    this.textColor,
    this.iconColor,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String? buttonText;
  final Color? buttonColor;
  final Color? textColor;
  final Color? iconColor;

  @override
  _DatabaseBackupWidgetState createState() => _DatabaseBackupWidgetState();
}

class _DatabaseBackupWidgetState extends State<DatabaseBackupWidget> {
  bool _isSharing = false;

  Future<void> _shareDatabase() async {
    setState(() {
      _isSharing = true;
    });

    try {
      // Search for database in multiple locations
      File? dbFile;
      String? dbPath;

      // List of directories to check
      final List<Future<Directory?>> directoryFutures = [
        getDatabasesPath().then((path) => Directory(path)),
        getApplicationDocumentsDirectory(),
        getApplicationSupportDirectory(),
        getExternalStorageDirectory(),
      ];

      // Check each directory
      for (final Future<Directory?> dirFuture in directoryFutures) {
        try {
          final Directory? dir = await dirFuture;
          if (dir != null) {
            final String testPath = path.join(dir.path, 'totetracker.db');
            final File testFile = File(testPath);
            if (await testFile.exists()) {
              dbFile = testFile;
              dbPath = testPath;
              break;
            }
          }
        } catch (e) {
          // Continue to next directory if this one fails
        }
      }

      // If not found in standard locations, check app-specific database directory
      if (dbFile == null) {
        try {
          final String databasesPath = await getDatabasesPath();
          final String testPath = path.join(databasesPath, 'totetracker.db');
          final File testFile = File(testPath);
          if (await testFile.exists()) {
            dbFile = testFile;
            dbPath = testPath;
          }
        } catch (e) {
          // Ignore errors
        }
      }

      if (dbFile == null || !await dbFile.exists()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Database not found in any standard location'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Create a temporary directory for the backup
      final Directory tempDir = await getTemporaryDirectory();
      final String timestamp = DateTime.now()
          .toIso8601String()
          .replaceAll(':', '-')
          .replaceAll('.', '-');
      final String backupFileName = 'totetracker_backup_$timestamp.db';
      final String backupPath = path.join(tempDir.path, backupFileName);

      // Copy the database to the temporary location
      await dbFile.copy(backupPath);

      // Share the file
      final XFile xFile = XFile(backupPath);
      await Share.shareXFiles(
        [xFile],
        subject: 'ToteTracker Database Backup.sqlite',
        text: 'Backup created on ${DateTime.now().toString()}',
      );

      // Clean up the temporary file after a delay
      Future.delayed(const Duration(minutes: 5), () async {
        try {
          final File tempFile = File(backupPath);
          if (await tempFile.exists()) {
            await tempFile.delete();
          }
        } catch (e) {
          // Ignore cleanup errors
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to backup database: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isSharing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton.icon(
        onPressed: _isSharing ? null : _shareDatabase,
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.buttonColor ?? Theme.of(context).primaryColor,
          foregroundColor: widget.textColor ?? Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        icon: _isSharing
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    widget.iconColor ?? Colors.white,
                  ),
                ),
              )
            : Icon(
                Icons.backup,
                color: widget.iconColor ?? Colors.white,
              ),
        label: Text(
          _isSharing ? 'Sharing...' : (widget.buttonText ?? 'Backup Database'),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
// END OF CUSTOM WIDGET CODE
