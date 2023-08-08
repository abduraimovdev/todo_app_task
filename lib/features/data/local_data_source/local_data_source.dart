import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Interface
sealed class LocalDataSource {
  const LocalDataSource();

  // Add Data
  Future<void> insert({
    required SqlTable table,
    required Map<String, Object?> data,
  });

  // UpdateData
  Future<void> update({
    required SqlTable table,
    required Map<String, Object?> data,
    required int id,
  });

  // Get All Data
  Future<List<Map<String, dynamic>>> readAll({required SqlTable table});

  // Get All Data Filtered
  Future<List<Map<String, dynamic>>> readAllFilteredDay({
    required SqlTable table,
    required DateTime time,
  });

  // Get Data
  Future<Map<String, dynamic>> read({
    required SqlTable table,
    required int id,
  });

  // Delete Data
  Future<void> delete({required SqlTable table, required int id});

  //Delete All Data
  Future<void> deleteAll({required SqlTable table});
}

// Implementation
class LocalDataSourceImpl extends LocalDataSource {
  const LocalDataSourceImpl();

  static const dbName = 'todo_database.db';
  static late final Future<Database> database;

  static Future<void> init() async {
    String pathDirectory = await getDatabasesPath();
    String path = join(pathDirectory, dbName);

    database = openDatabase(path, onCreate: _onCreate, version: 1);
  }

  static Future<void> _onCreate(Database db, int version) {
    return db.execute(
      '''CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT,
      eventName TEXT, 
      eventTitle TEXT, 
      eventDescription TEXT, 
      eventLocation TEXT, 
      time TEXT,
      priorityColor INTEGER, 
      remainder INTEGER)''',
    );
  }

  @override
  Future<void> insert({
    required SqlTable table,
    required Map<String, Object?> data,
  }) async {
    final db = await database;

    await db.insert(
      table.name,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> update({
    required SqlTable table,
    required Map<String, Object?> data,
    required int id,
  }) async {
    final db = await database;

    await db.update(
      table.name,
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<Map<String, dynamic>>> readAll({required SqlTable table}) async {
    final db = await database;
    return await db.query(table.name);
  }

  @override
  Future<List<Map<String, dynamic>>> readAllFilteredDay(
      {required SqlTable table, required DateTime time}) async {
    final db = await database;
    final year = time.year.toString();
    final month = time.month.toString().padLeft(2,"0");
    final day = time.day.toString().padLeft(2,"0");
    return await db.rawQuery("SELECT * FROM `${table.name}` WHERE `time` LIKE '%$year-$month-$day%'");
  }

  @override
  Future<void> delete({required SqlTable table, required int id}) async {
    final db = await database;

    await db.delete(
      table.name,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<Map<String, dynamic>> read({
    required SqlTable table,
    required int id,
  }) async {
    final db = await database;

    List<Map<String, Object?>> query = await db.query(
      table.name,
      where: 'id = ?',
      whereArgs: [id],
    );
    return query[0];
  }

  @override
  Future<void> deleteAll({required SqlTable table}) async {
    final db = await database;

    await db.execute("DELETE FROM ${table.name}");
  }
}

enum SqlTable {
  todos,
}
