import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class PlayAudio {
  AudioPlayer _audioPlayer;
  AudioCache _audioCache;
  String musicPath = "DVBBS.mp3";

  
  void play() async {
    _audioCache = AudioCache();
    // _audioCache.load(musicPath).then((value) => null);
    try {
      _audioPlayer = await _audioCache.play(musicPath);
    } catch (e) {
      print(e);
    }
  }

  void stop() async {
    _audioPlayer.stop();
    _audioCache.clear("DVBBS.mp3");
    _audioPlayer.dispose();
  }
}
