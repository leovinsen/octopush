import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

const DB_NAME = "octopush.db";

const TABLE_NAME = "transaction_history";

const COL_ID = "id";
const COL_DATE_CREATED = "date_created";
const COL_TIME_INTERVAL = "time_interval";
const COL_TITLE = "title";
const COL_AMOUNT = "amount";

class DatabaseProvider {
  static final DatabaseProvider instance = DatabaseProvider();
  Database _db;
  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await createDatabase();
    return _db;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentsDirectory.path, DB_NAME);

    var database = await openDatabase(path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  Future onUpgrade(Database database, int oldVersion, int newVersion) async {
    print('oldVersion: $oldVersion, newVersion: $newVersion');
    if (newVersion > oldVersion) {
      
    }
  }

  Future initDB(Database database, int version) async {
    await database.execute("CREATE TABLE $TABLE_NAME ("
        "$COL_ID INTEGER PRIMARY KEY, "
        "$COL_DATE_CREATED TEXT NOT NULL, "
        "$COL_TIME_INTERVAL INTEGER, "
        "$COL_TITLE TEXT, "
        "$COL_AMOUNT DECIMAL(10,2) " 
        ")");
  }
}
