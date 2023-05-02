
import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pray_time/models/audioModel.dart';

final AudioPlayer player = AudioPlayer();

Future<void> initAudio(AudioPlayer audioPlayer, AudioSource source) async {
  final session = await AudioSession.instance;
  await session.configure(const AudioSessionConfiguration.speech());
  // Listen to errors during playback.
  player.playbackEventStream.listen((event) {},
      onError: (Object e, StackTrace stackTrace) {
        print('A stream error occurred: $e');
      });
  try {
    await audioPlayer.setAudioSource(source);
  } catch (e, stackTrace) {
    // Catch load errors: 404, invalid url ...
    print("Error loading playlist: $e");
    print(stackTrace);
  }
}
