import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panite_music/domain/repository/song/song_repository.dart';
import 'package:panite_music/presentation/home/bloc/news_song_state.dart';
import 'package:panite_music/service_locator.dart';

class NewsSongCubit extends Cubit<NewsSongState> {
  NewsSongCubit() : super(const NewsSongInitial());

  Future<void> getNewsSong() async {
    try {
      emit(const NewsSongLoading());
      final songs = await sl<SongRepository>().getNewsSongs();
      songs.fold((l) => emit(NewsSongError(l.toString())),
          (r) => emit(NewsSongLoaded(r)));
    } on Exception catch (e) {
      emit(NewsSongError(e.toString()));
    }
  }
}
