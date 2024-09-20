import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:panite_music/data/models/song/song_model.dart';
import 'package:panite_music/domain/entities/song/song.dart';
import 'package:panite_music/domain/usecases/song/is_favourite.dart';

import '../../../service_locator.dart';

abstract class SongFirebaseService {
  Future<Either> getNewsSongs();

  Future<Either> getPlaylist();

  Future<Either> addOrRemoveFavoriteSong(String songId);

  Future<bool> isFavoriteSong(String songId);
}

class SongFirebaseServiceImpl implements SongFirebaseService {
  final FirebaseAuth _firebaseAuth = sl<FirebaseAuth>();
  final FirebaseFirestore _firestore = sl<FirebaseFirestore>();

  @override
  Future<Either> getNewsSongs() async {
    try {
      List<SongEntity> songs = [];
      await Future.delayed(const Duration(seconds: 2));
      final result = await _firestore.collection('songs').get();
      final data = await Future.wait(result.docs.map(
        (e) async {
          bool isFavourite = await sl<IsFavouriteUsecase>().call(params: e.id);
          return SongModel.fromJson(
            {
              'id': e.id,
              ...e.data(),
              "isFavourite": isFavourite,
            },
          );
        },
      ).toList());
      songs = data.map((e) => e.toEntity()).toList();
      print(songs);
      return Right(songs);
    } catch (e) {
      return const Left('Failed to get songs');
    }
  }

  @override
  Future<Either> getPlaylist() async {
    try {
      List<SongEntity> songs = [];
      await Future.delayed(const Duration(seconds: 2));
      final result = await _firestore.collection('songs').get();
      final data = await Future.wait(result.docs.map(
        (e) async {
          bool isFavourite = await sl<IsFavouriteUsecase>().call(params: e.id);
          return SongModel.fromJson(
            {
              'id': e.id,
              ...e.data(),
              "isFavourite": isFavourite,
            },
          );
        },
      ).toList());
      songs = data.map((e) => e.toEntity()).toList();
      print(songs);
      return Right(songs);
    } catch (e) {
      return const Left('Failed to get Playlist');
    }
  }

  @override
  Future<Either> addOrRemoveFavoriteSong(String songId) async {
    try {
      final uid = _firebaseAuth.currentUser!.uid;

      QuerySnapshot favourite = await _firestore
          .collection('users')
          .doc(uid)
          .collection('favourites')
          .where("songId", isEqualTo: songId)
          .get();

      if (favourite.docs.isNotEmpty) {
        await _firestore
            .collection('users')
            .doc(uid)
            .collection('favourites')
            .doc(favourite.docs.first.id)
            .delete();
        return const Right(false);
      } else {
        await _firestore
            .collection('users')
            .doc(uid)
            .collection('favourites')
            .add({
          'songId': songId,
        });
        return const Right(true);
      }
    } catch (e) {
      return const Left('Failed to add or remove favourite song');
    }
  }

  @override
  Future<bool> isFavoriteSong(String songId) async {
    try {
      final uid = _firebaseAuth.currentUser!.uid;
      QuerySnapshot favourite = await _firestore
          .collection('users')
          .doc(uid)
          .collection('favourites')
          .where("songId", isEqualTo: songId)
          .get();
      return favourite.docs.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
