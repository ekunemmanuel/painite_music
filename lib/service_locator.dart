import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:panite_music/domain/usecases/song/add_or_remove_favourite.dart';
import 'package:panite_music/domain/usecases/song/is_favourite.dart';
import 'package:panite_music/presentation/song_player/bloc/song_player_cubit.dart';

import 'data/repository/auth/auth_repository_impl.dart';
import 'data/repository/song/song_repository.dart';
import 'data/sources/auth/auth_firebase_service.dart';
import 'data/sources/songs/song_firebase_service.dart';
import 'domain/repository/auth/auth.dart';
import 'domain/repository/song/song_repository.dart';
import 'domain/usecases/song/get_news_song.dart';
import 'domain/usecases/auth/signin_usecase.dart';
import 'domain/usecases/auth/signup_usecase.dart';
import 'domain/usecases/song/get_playlist.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  sl.registerSingleton<FirebaseAuth>(firebaseAuth);
  sl.registerSingleton<FirebaseFirestore>(firebaseFirestore);
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());
  sl.registerSingleton<SongFirebaseService>(SongFirebaseServiceImpl());

  sl.registerSingleton<AudioPlayer>(AudioPlayer());
  // sl.registerFactory<SongPlayerCubit>(()=>SongPlayerCubit());

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<SongRepository>(SongRepositoryImpl());
  sl.registerSingleton<SignupUsecase>(SignupUsecase());
  sl.registerSingleton<SigninUsecase>(SigninUsecase());
  sl.registerSingleton<GetNewsSongUsecase>(GetNewsSongUsecase());
  sl.registerSingleton<GetPlaylistUsecase>(GetPlaylistUsecase());
  sl.registerSingleton<AddOrRemoveFavouriteUsecase>(AddOrRemoveFavouriteUsecase());
  sl.registerSingleton<IsFavouriteUsecase>(IsFavouriteUsecase());
}
