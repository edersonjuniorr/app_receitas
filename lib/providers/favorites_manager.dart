import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FavoritesManager {
  static final FavoritesManager _instance = FavoritesManager._internal();
  List<String> _favorites = [];
  Database? _database;

  factory FavoritesManager() {
    return _instance;
  }

  FavoritesManager._internal();

  List<String> get favorites => _favorites;

  Future<void> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'favorites.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE favorites(id INTEGER PRIMARY KEY, recipe TEXT)',
        );
      },
    );
  }

  Future<void> addFavorite(String favorite) async {
    _favorites.add(favorite);
    if (_database == null) {
      await _initDatabase();
    }
    await _database?.insert(
      'favorites',
      {'recipe': favorite},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeFavorite(String favorite) async {
    _favorites.remove(favorite);
    if (_database == null) {
      await _initDatabase();
    }
    await _database?.delete(
      'favorites',
      where: 'recipe = ?',
      whereArgs: [favorite],
    );
  }

  Future<void> loadFavorites() async {
    if (_database == null) {
      await _initDatabase();
    }
    final List<Map<String, dynamic>> maps = await _database!.query('favorites');

    _favorites = List.generate(maps.length, (i) {
      return maps[i]['recipe'];
    });
  }
}
