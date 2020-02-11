import 'package:octopush/model/time_interval.dart';
import 'package:octopush/model/transaction.dart';
import 'package:octopush/repository/transaction_repository.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class QrService {
  final _transactionRepository = TransactionRepository();

  Future<void> scan() async {
    String cameraScanResult = await scanner.scan();
    print(cameraScanResult);

    //We are not using the QR scan result, simply give the rewards 
    await _saveQrReward();
  }

  Future<void> _saveQrReward() async {
    var t = Transaction.newDBRecord(
        TimeInterval.DAY4_A.index, "QR Code Challenge Reward", 1000000.0);
    await _transactionRepository.addTranscation(t);
  }
}
