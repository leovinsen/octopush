import 'package:flutter_test/flutter_test.dart';
import 'package:octopush/database/database.dart';
import 'package:octopush/model/challenge.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_ffi_test/sqflite_ffi_test.dart';

void main() {
  // Set sqflite ffi support in test
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiTestInit();

  test('simple sqflite example', () async {
    var db = await openDatabase(inMemoryDatabasePath);
    expect(await db.getVersion(), 0);

    await db.execute("CREATE TABLE $TABLE_CHALLENGE ("
        "$COL_TIME_INTERVAL INTEGER PRIMARY KEY, "
        "$COL_TITLE TEXT NOT NULL, "
        "$COL_DESCRIPTION TEXT NOT NULL, "
        "$COL_LOWEST_REWARD INTEGER NOT NULL, "
        "$COL_HIGHEST_REWARD INTEGER NOT NULL, "
        "$COL_DONE INTEGER DEFAULT 0, "
        "$COL_MOOD INTEGER NOT NULL "
        ")");

    challengeJson.forEach((map) async => await db.insert(TABLE_CHALLENGE, map));

    List result = await db.query(TABLE_CHALLENGE);
    print(result[0]);
    print(result[11]);
    print(result[23]);
    expect(result.length, 24);
    await db.close();
  });
}