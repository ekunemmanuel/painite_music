import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panite_music/presentation/home/bloc/playlist_cubit.dart';

import '../bloc/playlist_state.dart';
import 'song_tile.dart';

class Playlist extends StatelessWidget {
  const Playlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Playlists",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        BlocProvider(
            create: (context) => PlaylistCubit()..getPlaylist(),
            child: BlocBuilder<PlaylistCubit, PlaylistState>(
              builder: (context, state) {
                if (state is PlaylistLoading) {
                  return const SizedBox(
                    height: 100,
                    child: Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  );
                } else if (state is PlaylistError) {
                  return SizedBox(
                    height: 100,
                    child: Center(
                      child: Text(state.message),
                    ),
                  );
                }
                final playlist = (state as PlaylistLoaded).songs;
                return ListView.separated(
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return SongTile(song: playlist[index]);
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  itemCount: playlist.length,
                );
              },
            )),
      ],
    );
  }
}
