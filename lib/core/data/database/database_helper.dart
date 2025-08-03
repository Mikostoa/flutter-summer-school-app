import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static const _databaseName = 'places_database.db';
  static const _databaseVersion = 1;

  // Singleton pattern
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE places (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        placeType TEXT NOT NULL,
        lat REAL NOT NULL,
        lon REAL NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE place_images (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        placeId INTEGER NOT NULL,
        url TEXT NOT NULL,
        FOREIGN KEY (placeId) REFERENCES places (id) ON DELETE CASCADE
      )
    ''');
  }

  Future<void> clearDatabase() async {
    final db = await database;
    await db.delete('places');
    await db.delete('place_images');
  }
}