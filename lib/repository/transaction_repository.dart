import 'package:octopush/database/transaction_dao.dart';
import 'package:octopush/model/transaction.dart';

class TransactionRepository {
  final _dao = TransactionDao();

  Future<List<Transaction>> getAllTranscation() async => await _dao.getAll();

  Future<int> addTranscation(Transaction transcation) async => await _dao.add(transcation);

  Future<bool> updateTranscation(Transaction transcation) async => await _dao.update(transcation) == 1 ? true : false;

  Future<bool> deleteTranscation(Transaction transcation) async => await _dao.delete(transcation) == 1 ? true : false;
}