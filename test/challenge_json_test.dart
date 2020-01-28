import 'package:flutter_test/flutter_test.dart';
import 'package:octopush/model/challenge.dart';

void main() {
  test('Testing Object mapping from $challengeJson in $Challenge', () async {
    final result = challengeJson.map((map) => Challenge.fromDB(map)).toList();
    expect(result.length, 24);

    result.forEach((result) {
      expect(result.description, isNotNull);
      expect(result.title, isNotNull);
      expect(result.timeInterval, isNotNull);
      expect(result.lowestReward, isNotNull);
      expect(result.highestReward, isNotNull);
      expect(result.done, isNotNull);
    });
  });
}
