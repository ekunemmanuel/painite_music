import 'package:dartz/dartz.dart';
import 'package:panite_music/core/usecases/usecase.dart';
import 'package:panite_music/domain/repository/song/song_repository.dart';
import 'package:panite_music/service_locator.dart';

class AddOrRemoveFavouriteUsecase implements Usecase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return sl<SongRepository>().addOrRemoveFavoriteSong(params!);
  }
}
