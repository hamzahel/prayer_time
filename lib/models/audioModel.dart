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
    title: "Mehdi Yarrahi",
  ),),
  AudioSource.asset("assets/audio/azan2.mp3", tag: MediaItem(
    // Specify a unique ID for each media item:
    id: '2',
    // Metadata to display in the notification:
    title: "Mohammed Al Ghazali",
  )),
  AudioSource.asset("assets/audio/azan3.mp3", tag: MediaItem(
    // Specify a unique ID for each media item:
    id: '3',
    // Metadata to display in the notification:
    title: "Ali Ahmed Mulla",
  )),
  AudioSource.asset("assets/audio/azan4.mp3", tag: MediaItem(
    // Specify a unique ID for each media item:
    id: '4',
    // Metadata to display in the notification:
    title: "Kari Obaidullah",
  )),
  AudioSource.asset("assets/audio/azan5.mp3", tag: MediaItem(
    // Specify a unique ID for each media item:
    id: '5',
    // Metadata to display in the notification:
    title: "Mohamed Tarek",
  )),
  AudioSource.asset("assets/audio/azan6.mp3", tag: MediaItem(
    // Specify a unique ID for each media item:
    id: '6',
    // Metadata to display in the notification:
    title: "Edris Aslami",
  )),
  AudioSource.asset("assets/audio/azan7.mp3", tag: MediaItem(
    // Specify a unique ID for each media item:
    id: '7',
    // Metadata to display in the notification
    title: "Omar Hisham",
  )),
  AudioSource.asset("assets/audio/azan8.mp3", tag: MediaItem(
    // Specify a unique ID for each media item:
    id: '8',
    // Metadata to display in the notification:
    title: "Nasir al Qatami",
  )),
  AudioSource.asset("assets/audio/azan9.mp3", tag: MediaItem(
    // Specify a unique ID for each media item:
    id: '9',
    // Metadata to display in the notification:
    title: "Abdullah Al Zaili",
  )),
   AudioSource.asset("assets/audio/azan10.mp3", tag: MediaItem(
        // Specify a unique ID for each media item:
        id: '10',
        // Metadata to display in the notification:
        title: "Machari Rashed Al Affassy",
   )),
  AudioSource.asset("assets/audio/notification1.mp3", tag: MediaItem(
    // Specify a unique ID for each media item:
    id: '1',
    // Metadata to display in the notification:
    title: "notification1",
  ),),
  AudioSource.asset("assets/audio/notification2.mp3", tag: MediaItem(
    // Specify a unique ID for each media item:
    id: '2',
    // Metadata to display in the notification:
    title: "notification2",
  ),),
  AudioSource.asset("assets/audio/notification3.mp3", tag: MediaItem(
    // Specify a unique ID for each media item:
    id: '3',
    // Metadata to display in the notification:
    title: "notification3",
  ),),
  AudioSource.asset("assets/audio/notification4.mp3", tag: MediaItem(
    // Specify a unique ID for each media item:
    id: '4',
    // Metadata to display in the notification:
    title: "notification4",
  ),),

];


final notificationSounds = [
  AudioSource.asset("assets/audio/notification1.mp3", tag: MediaItem(
    // Specify a unique ID for each media item:
    id: '1',
    // Metadata to display in the notification:
    title: "notification1",
  ),),
  AudioSource.asset("assets/audio/notification2.mp3", tag: MediaItem(
    // Specify a unique ID for each media item:
    id: '2',
    // Metadata to display in the notification:
    title: "notification2",
  ),),
  AudioSource.asset("assets/audio/notification3.mp3", tag: MediaItem(
    // Specify a unique ID for each media item:
    id: '3',
    // Metadata to display in the notification:
    title: "notification3",
  ),),
  AudioSource.asset("assets/audio/notification4.mp3", tag: MediaItem(
    // Specify a unique ID for each media item:
    id: '4',
    // Metadata to display in the notification:
    title: "notification4",
  ),),
];


