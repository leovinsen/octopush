import 'dart:async';
import 'dart:io';
import 'package:octopush/model/challenge.dart' show challengeJson;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

const DB_NAME = "octopush.db";

const TABLE_HISTORY = "transaction_history";

const COL_ID = "id";
const COL_DATE_CREATED = "date_created";
const COL_TIME_INTERVAL = "time_interval";
const COL_TITLE = "title";
const COL_AMOUNT = "amount";

const TABLE_CHALLENGE = "challenge";

const COL_DESCRIPTION = "description";
const COL_LOWEST_REWARD = "lowest_reward";
const COL_HIGHEST_REWARD = "highest_reward";
const COL_DONE = "done";

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
        version: 2, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  Future onUpgrade(Database database, int oldVersion, int newVersion) async {
    print('oldVersion: $oldVersion, newVersion: $newVersion');
    if (newVersion > oldVersion) {
      await deleteDB();
      await initDB(database, newVersion);
    }
  }

  Future initDB(Database database, int version) async {
    await database.execute("CREATE TABLE $TABLE_HISTORY ("
        "$COL_ID INTEGER PRIMARY KEY, "
        "$COL_DATE_CREATED TEXT NOT NULL, "
        "$COL_TIME_INTERVAL INTEGER, "
        "$COL_TITLE TEXT, "
        "$COL_AMOUNT DECIMAL(10,2) "
        ")");

    await database.execute("CREATE TABLE $TABLE_CHALLENGE ("
        "$COL_TIME_INTERVAL INTEGER PRIMARY KEY, "
        "$COL_TITLE TEXT NOT NULL, "
        "$COL_DESCRIPTION TEXT NOT NULL, "
        "$COL_LOWEST_REWARD INTEGER NOT NULL, "
        "$COL_HIGHEST_REWARD INTEGER NOT NULL, "
        "$COL_DONE INTEGER DEFAULT 0 "
        ")");
  
    ///Feed initial data
    challengeJson.forEach((map) async => await database.insert(TABLE_CHALLENGE, map));
  }

  Future<void> deleteDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    await deleteDatabase(path);
  }
}
