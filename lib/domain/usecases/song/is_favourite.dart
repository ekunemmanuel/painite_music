import 'package:panite_music/core/usecases/usecase.dart';
import 'package:panite_music/domain/repository/song/song_repository.dart';
import 'package:panite_music/service_locator.dart';

class IsFavouriteUsecase implements Usecase<bool, String> {
  @override
  Future<bool> call({String? params}) async {
    return sl<SongRepository>().isFavoriteSong(params!);
  }
}
