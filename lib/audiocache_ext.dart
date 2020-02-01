import 'package:audioplayers/audio_cache.dart';

extension Player on AudioCache {
  void playIntro() {
    play('music_quiz_intro.mp3');
  }
}
