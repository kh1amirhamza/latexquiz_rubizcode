// leaderboard_db.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LeaderboardDB {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    final path = join(await getDatabasesPath(), 'quiz_leaderboard.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE leaderboard(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          category TEXT,
          score INTEGER
        )
      ''');
      },
    );
    return _db!;
  }

  static Future<void> insertScore(
    String name,
    String category,
    int score,
  ) async {
    final db = await database;
    await db.insert('leaderboard', {
      'name': name,
      'category': category,
      'score': score,
    });
  }

  static Future<List<Map<String, dynamic>>> getAllScores({
    String? category,
  }) async {
    final db = await database;
    if (category != null) {
      return db.query(
        'leaderboard',
        where: 'category = ?',
        whereArgs: [category],
        orderBy: 'score DESC',
      );
    }
    return db.query('leaderboard', orderBy: 'score DESC');
  }

  static Future<void> deleteDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'quiz_leaderboard.db');
    await deleteDatabase(path);
  }
}
