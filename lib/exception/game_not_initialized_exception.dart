class GameNotInitializedException implements Exception {
  String msg;

  GameNotInitializedException(GameNotInitialized type) {
    switch (type) {
      case GameNotInitialized.interval:
        msg =
            "Could not find 'interval' in SharedPrefs; have you initialized it?";
        break;
      case GameNotInitialized.job:
        msg = "Could not find 'job' in SharedPrefs; have you initialized it?";
        break;
    }
  }
}

enum GameNotInitialized { interval, job }
