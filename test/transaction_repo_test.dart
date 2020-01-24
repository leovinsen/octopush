import 'package:flutter_test/flutter_test.dart';
import 'package:octopush/model/transaction.dart';
import 'package:octopush/repository/transaction_repository.dart';

///TODO: Test is not working because it depends on path_provider -- find a workaround
void main(){
  test('TransactionRepository should work', () async {
    TestWidgetsFlutterBinding.ensureInitialized();

    var repository = TransactionRepository();
    repository.addTranscation(Transaction(
      0,
      DateTime.now(),
      0,
      "Test",
      100000
    ));

    List<Transaction> t = await repository.getAllTranscation();
    expect(t.length, 1);
    expect(t[0].id, 0);
  });
}