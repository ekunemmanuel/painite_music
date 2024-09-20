import 'package:equatable/equatable.dart';
import 'package:panite_music/domain/entities/song/song.dart';

abstract class NewsSongState extends Equatable {
  const NewsSongState();
}

class NewsSongInitial extends NewsSongState {
  const NewsSongInitial();

  @override
  List<Object> get props => [];
}

class NewsSongLoading extends NewsSongState {
  const NewsSongLoading();

  @override
  List<Object> get props => [];
}

class NewsSongLoaded extends NewsSongState {
  final List<SongEntity> songs;

  const NewsSongLoaded(this.songs);

  @override
  List<Object> get props => [songs];
}

class NewsSongError extends NewsSongState {
  final String message;

  const NewsSongError(this.message);

  @override
  List<Object> get props => [message];
}