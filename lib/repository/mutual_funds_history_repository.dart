import 'package:octopush/base/base_repository.dart';
import 'package:octopush/database/dao/mutual_funds_history_dao.dart';
import 'package:octopush/model/mutual_funds_history.dart';

class MutualFundsHistoryRepository
    extends BaseRepository<MutualFundsHistory, MutualFundsHistoryDao> {
  MutualFundsHistoryRepository(MutualFundsHistoryDao dao) : super(dao);
}
