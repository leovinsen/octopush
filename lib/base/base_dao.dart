import 'package:octopush/base/base_entity.dart';
import 'package:octopush/database/database.dart';
import 'package:octopush/exception/query_set_exception.dart';
import 'package:sqflite/sqlite_api.dart';

abstract class BaseDao<T extends BaseEntity> {
  final _dbProvider = DatabaseProvider.instance;

  Future<Database> _getDb() async {
    return _dbProvider.db;
  }

  String tableNameInDB();

  ///return the Entity.fromDB named constructor
  T entityFromDB(Map<String, dynamic> map);

  ///Define the primary key clause for [findByPrimaryKey] to work
  String primaryKeyWhereClause();

  ///Return the primary key
  int primaryKeyWhereArgs(T entity);

  ///The error message returned when [findByPrimaryKey] finds more than 1 record for that given primary key
  String querySetExceptionMsg();

  Future<T> findByPrimaryKey(int pk) async {
    var result = await query(where: 'time_interval =?', whereArgs: [pk]);

    if (result.length == 0) return null;

    if (result.length > 1) throw QuerySetException(querySetExceptionMsg());

    return entityFromDB(result[0]);
  }

  Future<List<T>> getAll() async {
    var result = await query();

    return result.map((map) => entityFromDB(map)).toList();
  }

  ///Convenience method for querying the DB
  Future<List<Map<String, dynamic>>> query(
      {String where, List<dynamic> whereArgs}) async {
    var db = await _getDb();
    return await db.query(tableNameInDB(), where: where, whereArgs: whereArgs);
  }

  Map<String, dynamic> entityToDB(T entity);

  Future<int> update(T entity) async {
    var db = await _getDb();
    var result = await db.update(tableNameInDB(), entityToDB(entity),
        where: primaryKeyWhereClause(),
        whereArgs: [primaryKeyWhereArgs(entity)]);

    return result;
  }

  Future<int> add(T entity) async {
    var db = await _getDb();
    var result = await db.insert(tableNameInDB(), entityToDB(entity));

    return result;
  }
}
