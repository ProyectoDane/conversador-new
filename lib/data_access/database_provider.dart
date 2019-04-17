import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Database provider for handling the database instance
class DatabaseProvider {
  /// Factory constructor for the class
  factory DatabaseProvider() => _provider;
  DatabaseProvider._internal();

  static final DatabaseProvider _provider = DatabaseProvider._internal();
  static Database _db;
  final String _dbName = 'syntactic-sorter.db';
  bool _isInitialized = false;

  /// Closes the database
  Future<void> close() async => _db.close();

  /// Initializes and returns the database object
  Future<Database> db() async {
    if (!_isInitialized) {
      await _initDb();
    }
    return _db;
  }

  /// Initializes a new database from the assets folder
  Future<void> _initDb() async {
    final String databasesPath = await getDatabasesPath();
    final String path = join(databasesPath, _dbName);

// delete existing if any
    await deleteDatabase(path);

// Copy from asset
    final ByteData data = await rootBundle.load(join('assets', _dbName));
    final List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(path).writeAsBytes(bytes);

    Future<void> _onOpen(Database db) async {
      print('db version ${await db.getVersion()}');
      _isInitialized = true;
    }

    // open the database
    _db = await openDatabase(
      path,
      version: 1,
      onOpen: _onOpen,
    );
  }
}
