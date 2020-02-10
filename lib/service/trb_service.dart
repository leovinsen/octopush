import 'package:octopush/model/transaction.dart';
import 'package:octopush/repository/transaction_repository.dart';

class TrbService {
  final TransactionRepository _transactionRepository = TransactionRepository();

  Future<double> getTrb() async {
    List<Transaction> transactions =
        await _transactionRepository.getAllTranscation();
    var trb = 0.0;

    transactions.forEach((t) => trb += t.amount);

    return trb;
  }

  Future<bool> canPurchase(double amount) async {
    return await getTrb() > amount;
  }
}
