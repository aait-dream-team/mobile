import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDB {
  static const _dbName = 'myDatabase.db';
  static const _dbVersion = 1;

  // ignore: constant_identifier_names
  static const _table_history = 'RouteHistory';
  static const _table_recent = 'RecentRoutes';

  LocalDB._privateConstructor();
  static final LocalDB instance = LocalDB._privateConstructor();

  // static Database _database;
  // ignore: prefer_typing_uninitialized_variables
  var _database;

  Future get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $_table_history(id INTEGER PRIMARY KEY, startPoint TEXT, endPoint TEXT, date INT )");
    await db.execute(
        "CREATE TABLE $_table_recent(id INTEGER PRIMARY KEY, name TEXT, lat STRING, long STRING, date INT )");
  }

  // Fetch all routes
  Future getRoutes() async {
    Database db = await instance.database;

    var routes = await db.rawQuery("select * from $_table_history;"); 
    return routes;
  }

  Future getRecentRoutes() async {
    Database db = await instance.database;

    var routes = await db.rawQuery("select * from $_table_recent;");
    return routes;
  }

  Future insertRoute(dynamic route) async {
    Database db = await instance.database;

    await db.insert(_table_history, route);
  }

  Future insertRecentRoute(dynamic recentRoute) async {
    Database db = await instance.database;
    var routes = await db.rawQuery("select * from $_table_recent;");
    await db.insert(_table_recent, recentRoute);
  }
}
