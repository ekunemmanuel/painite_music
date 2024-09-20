import 'package:dartz/dartz.dart';
import 'package:panite_music/data/sources/songs/song_firebase_service.dart';
import 'package:panite_music/domain/repository/song/song_repository.dart';
import 'package:panite_music/service_locator.dart';

class SongRepositoryImpl extends SongRepository {
  @override
  Future<Either> getNewsSongs() async {
    return await sl<SongFirebaseService>().getNewsSongs();
  }

  @override
  Future<Either> getPlaylist() async {
    return await sl<SongFirebaseService>().getPlaylist();
  }

  @override
  Future<Either> addOrRemoveFavoriteSong(String songId) async {
    return await sl<SongFirebaseService>().addOrRemoveFavoriteSong(songId);
  }

  @override
  Future<bool> isFavoriteSong(String songId) async {
    return await sl<SongFirebaseService>().isFavoriteSong(songId);
  }
}
