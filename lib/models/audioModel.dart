import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class AudioModel {
  AudioModel({required this.title, required this.src});

  String title;
  AudioSource src;
}

final audios = [
  AudioSource.asset("assets/audio/azan1.mp3", tag: MediaItem(
    // Specify a unique ID for each media item:
    id: '1',
    // Metadata to display in the notification:
    album: "Album name",
    title: "Song name",
    artUri: Uri.parse('https://example.com/albumart.jpg'),
  ),),
  AudioSource.asset("assets/audio/azan2.mp3", tag: MediaItem(
    // Specify a unique ID for each media item:
    id: '2',
    // Metadata to display in the notification:
    album: "Album name",
    title: "Song name",
    artUri: Uri.parse('https://example.com/albumart.jpg'),
  )),
  AudioSource.asset("assets/audio/azan3.mp3", tag: MediaItem(
    // Specify a unique ID for each media item:
    id: '3',
    // Metadata to display in the notification:
    album: "Album name",
    title: "Song name",
    artUri: Uri.parse('https://example.com/albumart.jpg'),
  )),
  AudioSource.asset("assets/audio/azan4.mp3", tag: MediaItem(
    // Specify a unique ID for each media item:
    id: '4',
    // Metadata to display in the notification:
    album: "Album name",
    title: "Song name",
    artUri: Uri.parse('https://example.com/albumart.jpg'),
  )),
  AudioSource.asset("assets/audio/azan5.mp3", tag: MediaItem(
    // Specify a unique ID for each media item:
    id: '5',
    // Metadata to display in the notification:
    album: "Album name",
    title: "Song name",
    artUri: Uri.parse('https://example.com/albumart.jpg'),
  )),
  AudioSource.asset("assets/audio/azan6.mp3", tag: MediaItem(
    // Specify a unique ID for each media item:
    id: '6',
    // Metadata to display in the notification:
    album: "Album name",
    title: "Song name",
    artUri: Uri.parse('https://example.com/albumart.jpg'),
  )),
  AudioSource.asset("assets/audio/azan7.mp3", tag: MediaItem(
    // Specify a unique ID for each media item:
    id: '7',
    // Metadata to display in the notification:
    album: "Album name",
    title: "Song name",
    artUri: Uri.parse('https://example.com/albumart.jpg'),
  )),
  AudioSource.asset("assets/audio/azan8.mp3", tag: MediaItem(
    // Specify a unique ID for each media item:
    id: '8',
    // Metadata to display in the notification:
    album: "Album name",
    title: "Song name",
    artUri: Uri.parse('https://example.com/albumart.jpg'),
  )),
  AudioSource.asset("assets/audio/azan9.mp3", tag: MediaItem(
    // Specify a unique ID for each media item:
    id: '9',
    // Metadata to display in the notification:
    album: "Album name",
    title: "Song name",
    artUri: Uri.parse('https://example.com/albumart.jpg'),
  )),
   AudioSource.asset("assets/audio/azan10.mp3", tag: MediaItem(
        // Specify a unique ID for each media item:
        id: '10',
        // Metadata to display in the notification:
        album: "Album name",
        title: "Song name",
        artUri: Uri.parse('https://example.com/albumart.jpg'),
      )),
];
//
// final List<AudioModel> audios = [
//   AudioModel(src:  "assets/audio/azan1.mp3", title: "Azan1"),
//   AudioModel(src: "assets/audio/azan2.mp3", title: "Azan2"),
//   AudioModel(src: "assets/audio/azan3.mp3", title: "Azan3"),
//   AudioModel(src: "assets/audio/azan4.mp3", title: "Azan4"),
//   AudioModel(src: "assets/audio/azan5.mp3", title: "Azan5"),
//   AudioModel(src: "assets/audio/azan6.mp3", title: "Azan6"),
//   AudioModel(src: "assets/audio/azan7.mp3", title: "Azan7"),
//   AudioModel(src: "assets/audio/azan8.mp3", title: "Azan8"),
//   AudioModel(src: "assets/audio/azan9.mp3", title: "Azan9"),
//   AudioModel(src: "assets/audio/azan10.mp3", title: "Azan10"),
// ];
