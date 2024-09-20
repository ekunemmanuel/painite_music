import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panite_music/core/config/assets/app_assets.dart';
import 'package:panite_music/core/config/theme/app_colors.dart';
import 'package:panite_music/presentation/home/bloc/news_song_cubit.dart';
import 'package:panite_music/presentation/home/bloc/news_song_state.dart';

import '../../song_player/pages/song_player_page.dart';

class NewsSong extends StatelessWidget {
  const NewsSong({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewsSongCubit()..getNewsSong(),
      child: BlocBuilder<NewsSongCubit, NewsSongState>(
        builder: (context, state) {
          if (state is NewsSongLoading || state is NewsSongInitial) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state is NewsSongError) {
            return Text(state.message);
          }
          final songs = (state as NewsSongLoaded).songs;
          return ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: FadeInImage.assetNetwork(
                            placeholder: AppAssets.songPlaceholder,
                            image: songs[index].albumArt,
                            imageCacheHeight: 150,
                            width: 100,
                            height: 150,
                            fit: BoxFit.cover,
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                AppAssets.songPlaceholder,
                                width: 100,
                                height: 150,
                                fit: BoxFit.cover,
                              );
                            },
                            fadeInDuration: const Duration(milliseconds: 200),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            // transform: Matrix4.translationValues(10, 10, 0),
                            decoration: const BoxDecoration(),
                            child: Material(
                              color: AppColor.darkGrey,
                              shape: ShapeBorder.lerp(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                1,
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                    return SongPlayerPage(
                                      song: songs[index],
                                    );
                                  }));
                                },
                                borderRadius: BorderRadius.circular(10),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.play_arrow_rounded,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Text(
                      songs[index].title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      songs[index].artist,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              width: 10,
            ),
            itemCount: songs.length,
            scrollDirection: Axis.horizontal,
          );
        },
      ),
    );
  }
}
