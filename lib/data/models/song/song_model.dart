import 'package:equatable/equatable.dart';
import 'package:panite_music/domain/entities/song/song.dart';

class SongModel extends Equatable {
  final String id;
  final String title;
  final String artist;
  final String album;
  final String imageUrl;
  final String songUrl;
  final bool isFavourite;

  const SongModel(
      {required this.id,
      required this.title,
      required this.artist,
      required this.album,
      required this.imageUrl,
      required this.songUrl,
      required this.isFavourite});

  SongModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        artist = json['artist'],
        album = json['album'],
        imageUrl = json['imageUrl'],
        songUrl = json['songUrl'],
        isFavourite = json["isFavourite"];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'album': album,
      'imageUrl': imageUrl,
      'songUrl': songUrl,
      "isFavourite": isFavourite,
    };
  }

  @override
  List<Object?> get props => [id, title, artist, album, imageUrl, songUrl];
}

extension SongModelX on SongModel {
  SongEntity toEntity() {
    return SongEntity(
      id: id,
      title: title,
      artist: artist,
      album: album,
      albumArt: imageUrl,
      url: songUrl,
      isFavourite: isFavourite,
    );
  }
}
