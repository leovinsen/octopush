import 'package:octopush/database/database.dart';
import 'package:octopush/model/time_interval.dart';

class Challenge {
  final TimeInterval timeInterval;
  final String title;
  final String description;
  final int lowestReward;
  final int highestReward;
  final bool done;

  const Challenge(this.timeInterval, this.title, this.description,
      this.lowestReward, this.highestReward, this.done);

  Challenge.fromDB(Map<String, dynamic> map)
      : timeInterval = TimeInterval.values[map[COL_TIME_INTERVAL]],
        title = map[COL_TITLE],
        description = map[COL_DESCRIPTION],
        lowestReward = map[COL_LOWEST_REWARD],
        highestReward = map[COL_HIGHEST_REWARD],
        done = map[COL_DONE] ?? false;

  Map<String, dynamic> toDB() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[COL_TIME_INTERVAL] = this.timeInterval.index;
    data[COL_TITLE] = this.title;
    data[COL_DESCRIPTION] = this.description;
    data[COL_LOWEST_REWARD] = this.lowestReward;
    data[COL_HIGHEST_REWARD] = this.highestReward;
    data[COL_DONE] = this.done;
    return data;
  }

  @override
  String toString() {
    return "$timeInterval, $title, $description, $lowestReward, $highestReward, $done";
  }
}
