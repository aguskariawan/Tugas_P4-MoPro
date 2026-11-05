import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:isar/isar.dart';

part 'database_helper.g.dart'; // File ini digenerate otomatis oleh build_runner

@collection
class Catatan {
  Id id = Isar.autoIncrement; // Berfungsi seperti PRIMARY KEY AUTOINCREMENT

  late String judul;
  late String deskripsi;
}

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('catatan.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE notes (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      description TEXT NOT NULL
    )
    ''');
  }

  // 1. Create (Menambah data)
  Future<int> insertNote(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('notes', row);
  }

  // 2. Read (Membaca semua data)
  Future<List> getNotes() async {
    Database db = await instance.database;
    return await db.query('notes');
  }

  // 3. Update (Mengubah data)
  Future<int> updateNote(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row['id'];
    return await db.update('notes', row, where: 'id = ?', whereArgs: [id]);
  }

  // 4. Delete (Menghapus data)
  Future<int> deleteNote(int id) async {
    Database db = await instance.database;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
