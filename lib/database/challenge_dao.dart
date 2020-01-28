import 'package:octopush/exception/query_set_exception.dart';
import 'package:octopush/model/challenge.dart';
import 'package:sqflite/sqlite_api.dart';

import 'database.dart';

class ChallengeDao {
  final _dbProvider = DatabaseProvider.instance;

  Future<Database> _getDb() async {
    return _dbProvider.db;
  }

  Future<Challenge> getOne(int timeInterval) async {
    var db = await _getDb();
    var result = await db.query(TABLE_CHALLENGE,
        where: 'time_interval =?', whereArgs: [timeInterval]);

    if (result.length > 1) throw QuerySetException("$ChallengeDao.$getOne");

    return Challenge.fromDB(result[0]);
  }

  Future<List<Challenge>> getAll() async {
    var db = await _getDb();
    var result = await db.query(TABLE_CHALLENGE);

    return result.map((map) => Challenge.fromDB(map)).toList();
  }

  Future<int> update(Challenge c) async {
    var db = await _getDb();
    var result = await db.update(TABLE_CHALLENGE, c.toDB(),
        where: 'time_interval = ?', whereArgs: [c.timeInterval.index]);

    return result;
  }

  Future<int> add(Challenge c) async {
    var db = await _getDb();
    var result = await db.insert(TABLE_CHALLENGE, c.toDB());

    return result;
  }
}
