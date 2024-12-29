import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;

  static Database? _database;

  DBHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'django.db');
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE Users(
            id INTEGER PRIMARY KEY,
            firstName TEXT,
            lastName TEXT,
            email TEXT,
            avatar TEXT,
            localImagePath TEXT
          )
          ''',
        );
      },
    );
  }

  Future<void> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    await db.insert('Users', user,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> fetchUsers() async {
    final db = await database;
    return await db.query('Users');
  }

  Future<void> updateUserImage(int id, String imagePath) async {
    final db = await database;
    await db.update(
      'Users',
      {'localImagePath': imagePath},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}
