import 'package:just_audio/just_audio.dart';

class AudioModel {
  AudioModel({required this.title, required this.src});

  String title;
  AudioSource src;
}

final List<AudioModel> audios = [
  AudioModel(src: AudioSource.asset("assets/audio/azan1.mp3"), title: "Azan1"),
  AudioModel(src: AudioSource.asset("assets/audio/azan2.mp3"), title: "Azan2"),
  AudioModel(src: AudioSource.asset("assets/audio/azan3.mp3"), title: "Azan3"),
  AudioModel(src: AudioSource.asset("assets/audio/azan4.mp3"), title: "Azan4"),
  AudioModel(src: AudioSource.asset("assets/audio/azan5.mp3"), title: "Azan5"),
  AudioModel(src: AudioSource.asset("assets/audio/azan6.mp3"), title: "Azan6"),
  AudioModel(src: AudioSource.asset("assets/audio/azan7.mp3"), title: "Azan7"),
  AudioModel(src: AudioSource.asset("assets/audio/azan8.mp3"), title: "Azan8"),
  AudioModel(src: AudioSource.asset("assets/audio/azan9.mp3"), title: "Azan9"),
  AudioModel(
      src: AudioSource.asset("assets/audio/azan10.mp3"), title: "Azan10"),
];
