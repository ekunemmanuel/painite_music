import 'package:dartz/dartz.dart';
import 'package:panite_music/core/usecases/usecase.dart';
import 'package:panite_music/domain/repository/song/song_repository.dart';
import 'package:panite_music/service_locator.dart';

class GetPlaylistUsecase implements Usecase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return sl<SongRepository>().getPlaylist();
  }
}
