import 'package:just_audio/just_audio.dart';

class AudioService {
  late AudioPlayer _audioPlayer;

  AudioService() {
    _audioPlayer = AudioPlayer();
  }

  Future<void> playAudio(String url) async {
    await _audioPlayer.setUrl(url);
    _audioPlayer.play();
  }

}
