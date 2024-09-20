import 'package:equatable/equatable.dart';

class SongEntity extends Equatable {
  final String id;
  final String title;
  final String artist;
  final String album;
  final String albumArt;
  final String url;
  final bool isFavourite;

  const SongEntity(
      {required this.id,
      required this.title,
      required this.artist,
      required this.album,
      required this.albumArt,
      required this.url,
      this.isFavourite = false});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SongEntity &&
        other.id == id &&
        other.title == title &&
        other.artist == artist &&
        other.album == album &&
        other.albumArt == albumArt &&
        other.url == url;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        artist.hashCode ^
        album.hashCode ^
        albumArt.hashCode ^
        url.hashCode;
  }

  @override
  List<Object> get props =>
      [id, title, artist, album, albumArt, url, isFavourite];
}
