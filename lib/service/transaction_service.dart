import 'package:octopush/model/time_interval.dart';
import 'package:octopush/model/transaction.dart';
import 'package:octopush/repository/transaction_repository.dart';
import 'package:octopush/service/trb_service.dart';

class TransactionService {
  final TransactionRepository _repo;
  final TrbService trbService;

  TransactionService(this._repo, this.trbService);

  Future<bool> purchase(String title, TimeInterval interval, double amount) async {
    bool canPurchase = await trbService.canPurchase(amount);

    if (!canPurchase) return false;

    var transaction = Transaction.newDBRecord(interval.index, title, amount);

    await _repo.addTranscation(transaction);

    return true;
  }
}
