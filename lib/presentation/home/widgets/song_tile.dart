import 'package:flutter/material.dart';

import '../../../core/config/theme/app_colors.dart';
import '../../../domain/entities/song/song.dart';
import '../../song_player/pages/song_player_page.dart';

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.song,
  });

  final SongEntity song;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(right: 10),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            const Text("00:00"),
            const SizedBox(width: 10),
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
            ),
          ],
        ),
      ),
      leading: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200),
          color: AppColor.darkGrey.withOpacity(.3),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(200),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return SongPlayerPage(
                song: song,
              );
            }));
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.play_arrow_rounded),
          ),
        ),
      ),
      title: Text(
        song.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      subtitle: Text(
        song.artist,
        style: const TextStyle(
          color: AppColor.grey,
          fontSize: 12,
        ),
      ),
    );
  }
}
