import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import '../../../service_locator.dart';
import 'song_player_state.dart';

class SongPlayerCubit extends Cubit<SongPlayerState> {
  AudioPlayer player = AudioPlayerService().player;
  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;
  Duration bufferedPosition = Duration.zero;

  SongPlayerCubit() : super(SongPlayerLoading()) {
    _listenToPlayer();
  }

  Future<void> loadSong(String songUrl) async {
    try {
      emit(SongPlayerLoading());

      await Future.delayed(const Duration(seconds: 2));
      final result = await player.setUrl(songUrl);
      // print("result: $result");
      // Manually check duration after loading
      if (result != null) {
        songDuration = result;
        updateSongPlayer();
      }
    } catch (e) {
      emit(SongPlayerError());
    }
  }

  Future<void> playOrPauseSong() async {
    if (player.playing) {
      await player.pause();
      updateSongPlayer();
    } else {
      await player.play();
      updateSongPlayer();
    }
  }

  void _listenToPlayer() {
    player.positionStream.listen((event) {
      songPosition = event;
      updateSongPlayer();
    });

    player.bufferedPositionStream.listen((event) {
      bufferedPosition = event;
      updateSongPlayer();
    });

    player.playbackEventStream.listen((event) {
      bufferedPosition = event.bufferedPosition;
      updateSongPlayer();

      if (event.processingState == ProcessingState.completed) {
        player.seek(Duration.zero);
        player.pause();
      } else if (event.processingState == ProcessingState.buffering) {
        emit(SongPlayerLoading());
      } else if (event.processingState == ProcessingState.ready &&
          player.playing) {
        updateSongPlayer();
      } else if (event.processingState == ProcessingState.ready &&
          !player.playing) {
        updateSongPlayer();
      }
    });
  }

  void updateSongPlayer() {
    // print("Updating song player: "
    //     "Duration: $songDuration, "
    //     "Position: $songPosition, "
    //     "Buffered: $bufferedPosition, "
    //     "Playing: ${player.playing}");

    emit(SongPlayerLoaded(
      songDuration: songDuration,
      songPosition: songPosition,
      bufferedPosition: bufferedPosition,
      isPlaying: player.playing,
    ));
  }

  Future<void> seek(Duration position) async {
    await player.seek(position);
  }

  @override
  Future<void> close() async {
    // await player.dispose();
    return super.close();
  }
}


class AudioPlayerService {
  static final AudioPlayerService _instance = AudioPlayerService._internal();
  final AudioPlayer player = AudioPlayer();

  factory AudioPlayerService() {
    return _instance;
  }

  AudioPlayerService._internal();
}