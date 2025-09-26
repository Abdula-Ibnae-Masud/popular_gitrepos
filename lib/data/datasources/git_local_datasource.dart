import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/repository_model.dart';

class GitLocalDataSource {
  static const _dbName = 'popular_gitrepos.db';
  static const _table = 'repositories';
  Database? _db;

  Future<void> init() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _dbName);
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
            CREATE TABLE $_table (
              id INTEGER PRIMARY KEY,
              name TEXT,
              description TEXT,
              owner_name TEXT,
              owner_avatar TEXT,
              stars INTEGER,
              html_url TEXT,
              updated_at TEXT
            )
        ''');
      },
    );
  }

  Future<void> upsertRepos(List<RepositoryModel> repos) async {
    final db = _db!;
    final batch = db.batch();
    for (final r in repos) {
      batch.insert(
        _table,
        r.toDb(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<List<RepositoryModel>> getAllRepos() async {
    final db = _db!;
    final rows = await db.query(_table, orderBy: 'stars DESC');
    return rows.map((r) => RepositoryModel.fromDb(r)).toList();
  }

  Future<RepositoryModel?> getRepoById(int id) async {
    final db = _db!;
    final rows = await db.query(_table, where: 'id = ?', whereArgs: [id]);
    if (rows.isEmpty) return null;
    return RepositoryModel.fromDb(rows.first);
  }
}
