import 'package:octopush/database/database.dart';
import 'package:octopush/model/time_interval.dart';
import 'package:octopush/utils/sqlite_data_converter.dart';

import 'mood.dart';

class Challenge {
  final TimeInterval timeInterval;
  final String title;
  final String description;
  final int lowestReward;
  final int highestReward;
  final bool done;
  final Mood mood;

  const Challenge(this.timeInterval, this.title, this.description,
      this.lowestReward, this.highestReward, this.done, this.mood);

  Challenge.fromDB(Map<String, dynamic> map)
      : timeInterval = TimeInterval.values[map[COL_TIME_INTERVAL]],
        title = map[COL_TITLE],
        description = map[COL_DESCRIPTION],
        lowestReward = map[COL_LOWEST_REWARD],
        highestReward = map[COL_HIGHEST_REWARD],
        done = SQLiteDataConverter.readBool(map[COL_DONE]),
        mood = Mood.values[map[COL_MOOD]];

  Map<String, dynamic> toDB() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[COL_TIME_INTERVAL] = this.timeInterval.index;
    data[COL_TITLE] = this.title;
    data[COL_DESCRIPTION] = this.description;
    data[COL_LOWEST_REWARD] = this.lowestReward;
    data[COL_HIGHEST_REWARD] = this.highestReward;
    data[COL_DONE] = this.done;
    data[COL_MOOD] = this.mood.index;
    return data;
  }

  @override
  String toString() {
    return "$timeInterval, $title, $description, $lowestReward, $highestReward, $done, $mood";
  }
}

/// mood 0 = sad 
/// mood 1 = happy
final List<Map<String,dynamic>> challengeJson = [
  {
    "time_interval": 0,
    "title": "Tutorial",
    "description": "Hi, it's nice to see you here! Now let me give you a tour",
    "lowest_reward": 0,
    "highest_reward": 0,
    "mood": 1
  },
  {
    "time_interval": 1,
    "title": "Games (Minesweeper)",
    "description":
        "Rise and shine! It's your lucky day! It's your chance to get a prize. Uncover all the squares that do not contain mines without being 'blown up' by clicking on a square with a mine underneath. You've only got one chance, so do it right! And goodluck! :)",
    "lowest_reward": 0,
    "highest_reward": 0,
    "mood": 1
  },
  {
    "time_interval": 2,
    "title": "Bonus From Your Boss",
    "description":
        "Congratulations, you're given a bonus from your boss! You've worked hard these past years and your boss highly appreciate what you've done. Keep up the good work!",
    "lowest_reward": 100,
    "highest_reward": 120,
    "mood": 1
  },
  {
    "time_interval": 3,
    "title": "Buy a Car",
    "description":
        "Congratulations on your first four wheel! You've been doing well and you decided to buy your own car.    Choose one of the auto-loan installment options.",
    "lowest_reward": -500,
    "highest_reward": -500,
    "mood": 1
  },
  {
    "time_interval": 4,
    "title": "Married",
    "description":
        "Congratulations! It's Valentine's day and you're getting married! Octo is so happy to see you finally able to find the one.    You need to pay for your wedding ceremony & reception.",
    "lowest_reward": -200,
    "highest_reward": -200,
    "mood": 1
  },
  {
    "time_interval": 5,
    "title": "Won a Lottery",
    "description":
        "During your honeymoon, you buy a lottery ticket. Luckily you're given a chance to win a prize up to 100 mio !Choose wisely, aim for the best!",
    "lowest_reward": 20,
    "highest_reward": 100,
    "mood": 1
  },
  {
    "time_interval": 6,
    "title": "QR Treasure hunt",
    "description":
        "Lucky, you've got a friend! Your friend invited you to a treasure hunt. Legend said that historical site contains hidden gems are found in the place that we all know now as DigitalLounge@Campus ITB. Quick! Come and go to the place and scan the hidden QR!",
    "lowest_reward": 0,
    "highest_reward": 200,
    "mood": 1
  },
  {
    "time_interval": 7,
    "title": "First Labor",
    "description":
        "What a beautiful life! Your wife is about to labor your first child! Unfortunately, you need to pay for the medical fee, baby supplies, and needs",
    "lowest_reward": -100,
    "highest_reward": -100,
    "mood": 1
  },
  {
    "time_interval": 8,
    "title": "Buy a House",
    "description":
        "Lil' fam needs its own house. Your child is getting bigger and at some point you need to buy your own house. Choose one of the mortgage installment options.",
    "lowest_reward": -1000,
    "highest_reward": -1000,
    "mood": 1
  },
  {
    "time_interval": 9,
    "title": "Second Labor",
    "description":
        "What a beautiful life! Your wife is about to labor your second child! Unfortunately, you need to pay for the medical fee, baby supplies, and needs",
    "lowest_reward": -100,
    "highest_reward": -100,
    "mood": 1
  },
  {
    "time_interval": 10,
    "title": "Parents got sick",
    "description": "Challenge #11",
    "lowest_reward": -150,
    "highest_reward": -150,
    "mood": 0
  },
  {
    "time_interval": 11,
    "title": "Inheritance",
    "description": "Challenge #12",
    "lowest_reward": 120,
    "highest_reward": 120,
    "mood": 1
  },
  {
    "time_interval": 12,
    "title": "Family Vacation",
    "description": "Challenge #13",
    "lowest_reward": -100,
    "highest_reward": -100,
    "mood": 1
  },
  {
    "time_interval": 13,
    "title": "Change Car",
    "description": "Challenge #14",
    "lowest_reward": -250,
    "highest_reward": -250,
    "mood": 1
  },
  {
    "time_interval": 14,
    "title": "Bonus From Boss + Friends Referral",
    "description": "Challenge #15",
    "lowest_reward": 250,
    "highest_reward": 250,
    "mood": 1
  },
  {
    "time_interval": 15,
    "title": "First Child School Fee",
    "description": "Challenge #16",
    "lowest_reward": -300,
    "highest_reward": -300,
    "mood": 1
  },
  {
    "time_interval": 16,
    "title": "Second Child School Fee",
    "description": "Challenge #17",
    "lowest_reward": -300,
    "highest_reward": -300,
    "mood": 1
  },
  {
    "time_interval": 17,
    "title": "College Friends Reunion",
    "description": "Challenge #18",
    "lowest_reward": -50,
    "highest_reward": -50,
    "mood": 1
  },
  {
    "time_interval": 18,
    "title": "Wife Got Sick",
    "description": "Challenge #19",
    "lowest_reward": -300,
    "highest_reward": -300,
    "mood": 0
  },
  {
    "time_interval": 19,
    "title": "Anniversary Party",
    "description": "Challenge #20",
    "lowest_reward": -50,
    "highest_reward": -50,
    "mood": 1
  },
  {
    "time_interval": 20,
    "title": "You Got Sick!",
    "description": "Challenge #21",
    "lowest_reward": -200,
    "highest_reward": -200,
    "mood": 0
  },
  {
    "time_interval": 21,
    "title": "Who Wants To Be A Jutawan?",
    "description": "Yay! You got invited to the most popular Quiz game show on national TV channel!",
    "lowest_reward": 0,
    "highest_reward": 0,
    "mood": 0
  },
  {
    "time_interval": 22,
    "title": "Challenge #23",
    "description": "Challenge #23",
    "lowest_reward": 0,
    "highest_reward": 0,
    "mood": 0
  },
  {
    "time_interval": 23,
    "title": "End of Journey",
    "description": "Challenge #24",
    "lowest_reward": 0,
    "highest_reward": 0,
    "mood": 0
  }
];
