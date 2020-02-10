import 'package:octopush/model/mutual_funds_history.dart';
import 'package:octopush/model/mutual_funds_product.dart';
import 'package:octopush/repository/mutual_funds_history_repository.dart';
import 'package:octopush/service/interval_service.dart';
import 'package:octopush/service/transaction_service.dart';

class MutualFundsService {
  final MutualFundsHistoryRepository _repo;
  final IntervalService _intervalService;
  final TransactionService _transactionService;
  const MutualFundsService(
      this._repo, this._intervalService, this._transactionService);

  Future<bool> buyMutualFunds(MutualFundsProduct product, double amount) async {
    bool success = await _transactionService.purchase("Bought ${product.name}",
        _intervalService.getCurrentInterval(), amount);

    if (!success) return false;

    await _addRecord(product, amount);

    return true;
  }

  Future<void> _addRecord(MutualFundsProduct product, double amount) async {
    var mf = MutualFundsHistory.newDBRecord(
      product.id,
      _intervalService.getCurrentInterval().index,
      amount,
    );

    await _repo.add(mf);
  }
}
