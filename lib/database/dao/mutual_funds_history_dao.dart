import 'package:octopush/base/base_dao.dart';
import 'package:octopush/database/schema/schema_mutual_funds_history.dart';
import 'package:octopush/model/mutual_funds_history.dart';
import 'package:sqflite/sqlite_api.dart';

class MutualFundsHistoryDao extends BaseDao<MutualFundsHistory> {
  MutualFundsHistoryDao(Database db) : super(db);

  @override
  MutualFundsHistory entityFromDB(Map<String, dynamic> map) {
    return MutualFundsHistory.fromDB(map);
  }

  @override
  Map<String, dynamic> entityToDB(MutualFundsHistory entity) {
    return entity.toDB();
  }

  @override
  int primaryKeyWhereArgs(MutualFundsHistory entity) {
    return entity.id;
  }

  @override
  String primaryKeyWhereClause() {
    return 'id = ?';
  }

  @override
  String querySetExceptionMsg() {
    return '$MutualFundsHistoryDao.$findByPrimaryKey';
  }

  @override
  String tableNameInDB() {
    return MF_HISTORY;
  }
}
