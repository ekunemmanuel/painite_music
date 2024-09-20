import 'package:equatable/equatable.dart';

abstract class SongPlayerState extends Equatable {}

class SongPlayerInitial extends SongPlayerState {
  @override
  List<Object?> get props => [];
}

class SongPlayerLoading extends SongPlayerState {
  @override
  List<Object?> get props => [];
}

class SongPlayerError extends SongPlayerState {
  @override
  List<Object?> get props => [];
}

class SongPlayerLoaded extends SongPlayerState {
  final Duration songDuration;
  final Duration songPosition;
  final Duration bufferedPosition;
  final bool isPlaying;

  SongPlayerLoaded({
    required this.songDuration,
    required this.songPosition,
    required this.bufferedPosition,
    required this.isPlaying,
  });

  @override
  List<Object?> get props => [
        songDuration,
        songPosition,
        bufferedPosition,
        isPlaying,
      ];
}
