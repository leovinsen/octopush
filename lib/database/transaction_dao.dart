import 'package:octopush/model/transaction.dart';

import 'database.dart';

class TransactionDao {
  final _dbProvider = DatabaseProvider.instance;

  _getDb() async {
    return _dbProvider.db;
  }

  Future<int> add(Transaction t) async {
    var db = await _getDb();
    var result = await db.insert(TABLE_NAME, t.toDB());
    return result;
  }

  Future<List<Transaction>> getAll() async {
    var db = await  _getDb();
    var result = await db.query(TABLE_NAME);
    return result.isNotEmpty 
        ? result.map((item) => Transaction.fromDB(item)).toList()
        : [];
  }

  Future<int> update(Transaction t) async {
    var db = await  _getDb();
    var result = await db.update(TABLE_NAME, t.toDB(),
        where: 'id = ?', whereArgs: [t.id] );

    return result;
  }

  Future<int> delete(Transaction t) async {
    var db = await  _getDb();
    var result = await db.delete(TABLE_NAME,
        where: 'id = ?', whereArgs: [t.id]);

    return result;
  }
}