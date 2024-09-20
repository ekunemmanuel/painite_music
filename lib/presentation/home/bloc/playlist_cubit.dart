import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repository/song/song_repository.dart';
import '../../../service_locator.dart';
import 'playlist_state.dart';

class PlaylistCubit extends Cubit<PlaylistState> {
  PlaylistCubit() : super(PlaylistLoading());

  Future<void> getPlaylist() async {
    try {
      emit(PlaylistLoading());
      final songs = await sl<SongRepository>().getPlaylist();
      songs.fold((l) => emit(PlaylistError(l.toString())),
          (r) => emit(PlaylistLoaded(r)));
    } on Exception catch (e) {
      emit(PlaylistError(e.toString()));
    }
  }
}
