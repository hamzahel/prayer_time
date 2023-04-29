
import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';

final AudioPlayer player = AudioPlayer();

Future<void> initAudio(AudioPlayer player , AudioSource audio) async {
  final session = await AudioSession.instance;
  await session.configure(const AudioSessionConfiguration.speech());
  player.playbackEventStream.listen((event) {},
      onError: (Object e, StackTrace stackTrace) {
        print('A stream error occurred: $e');
      });
  try {
    await player.setAudioSource(audio);
    print("the audio is loading .....");
  } catch (e) {
    print("Error loading audio source: $e");
  }
}




