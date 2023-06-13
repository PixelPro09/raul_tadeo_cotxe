import 'dart:io';

import 'package:dogs_db_pseb_bridge/models/cv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // database
  DatabaseHelper._privateConstructor(); // Name constructor to create instance of database
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  // getter for database
  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS
    // to store database
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/dogs.db';

    // open/create database at a given path
    var cvDatabase = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );

    return cvDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''
      CREATE TABLE tbl_cv (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        data INTEGER,
        km INTEGER,
        tipus TEXT,
        concepte INTEGER,
        quantitat INTEGER
      )
    ''');
  }

  // insert
  Future<int> insertCV(CV cv) async {
    // add cv to table
    Database db = await instance.database;
    int result = await db.insert('tbl_cv', cv.toMap());
    return result;
  }

  // read operation
  Future<List<CV>> getAllCVs() async {
    List<CV> cvs = [];
    Database db = await instance.database;

    // read data from table
    List<Map<String, dynamic>> listMap = await db.query('tbl_cv');

    for (var cvMap in listMap) {
      CV cv = CV.fromMap(cvMap);
      cvs.add(cv);
    }

    return cvs;
  }

  // delete
  Future<int> deleteCV(int id) async {
    Database db = await instance.database;
    int result = await db.delete('tbl_cv', where: 'id = ?', whereArgs: [id]);
    return result;
  }

  // update
  Future<int> updateCV(CV cv) async {
    Database db = await instance.database;
    int result = await db.update('tbl_cv', cv.toMap(), where: 'id = ?', whereArgs: [cv.id]);
    return result;
  }
}
