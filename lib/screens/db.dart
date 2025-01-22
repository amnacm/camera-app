import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseFunction {
  final _databaseName = 'image_function.db';
  final _version = 1;

  final table = 'images';

  final columnId = '_id';
  final columnImagePath = 'image_path';

  DatabaseFunction._privateConstructor();
  static final DatabaseFunction instance =
      DatabaseFunction._privateConstructor();

  static Database? _database;

  // Get the database instance
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);

    return await openDatabase(path, version: _version, onCreate: _onCreate);
  }

  // Create the table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnImagePath TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertImage(String imagePath) async {
    Database? db = await database;
    Map<String, dynamic> row = {
      columnImagePath: imagePath,
    };
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> getAllImages() async {
    Database? db = await database;
    return await db.query(table);
  }
}
