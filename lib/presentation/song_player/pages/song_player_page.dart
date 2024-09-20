import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panite_music/common/widgets/basic_app_bar.dart';
import 'package:panite_music/core/config/theme/app_colors.dart';
import 'package:panite_music/domain/entities/song/song.dart';
import 'package:panite_music/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:panite_music/presentation/song_player/bloc/song_player_state.dart';

import '../../../core/config/assets/app_assets.dart';

class SongPlayerPage extends StatelessWidget {
  final SongEntity song;
  const SongPlayerPage({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: const Text(
          'Now Playing',
          style: TextStyle(
            color: AppColor.grey,
            fontSize: 14,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => SongPlayerCubit()..loadSong(song.url),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage.assetNetwork(
                  placeholder: AppAssets.songPlaceholder,
                  image: song.albumArt,
                  width: MediaQuery.of(context).size.width,
                  imageCacheHeight:
                      (MediaQuery.of(context).size.height * 0.5).toInt(),
                  height: MediaQuery.of(context).size.height * 0.5,
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      AppAssets.songPlaceholder,
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    );
                  },
                  fadeInDuration: const Duration(milliseconds: 200),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        song.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        song.artist,
                        style: const TextStyle(
                          color: AppColor.grey,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(1000),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        song.isFavourite
                            ? Icons.favorite
                            : Icons.favorite_border_rounded,
                        size: 30,
                        color: AppColor.grey,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              BlocBuilder<SongPlayerCubit, SongPlayerState>(
                builder: (context, state) {
                  if (state is SongPlayerLoading) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  } else if (state is SongPlayerLoaded) {
                    final songCubit = context.read<SongPlayerCubit>();
                    return Column(
                      children: [
                        ProgressBar(
                          progress: state.songPosition,
                          total: state.songDuration,
                          buffered: state.bufferedPosition,
                          onSeek: (value) {
                            songCubit.seek(value);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(200),
                              onTap: () {
                                songCubit.playOrPauseSong();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(200),
                                  color: AppColor.primary,
                                ),
                                child: Icon(
                                  state.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow_rounded,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  }
                  const message = 'An error occurred';
                  return const Center(child: Text(message));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
