import 'package:equatable/equatable.dart';

import '../../../domain/entities/song/song.dart';

abstract class PlaylistState extends Equatable {}

class PlaylistLoading extends PlaylistState {
  @override
  List<Object?> get props => [];
}

class PlaylistLoaded extends PlaylistState {
  final List<SongEntity> songs;

  PlaylistLoaded(this.songs);

  @override
  List<Object> get props => [songs];
}

class PlaylistError extends PlaylistState {
  final String message;

  PlaylistError(this.message);

  @override
  List<Object> get props => [message];
}
