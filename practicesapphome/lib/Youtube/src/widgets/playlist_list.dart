import 'package:flutter/material.dart';
import 'package:googleapis/youtube/v3.dart';

class PlaylistList extends StatelessWidget {
  const PlaylistList({
    required this.playlists,
    required this.onTap,
    super.key,
  });

  final List<Playlist> playlists;
  final void Function(Playlist) onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: playlists.length,
      itemBuilder: (context, index) {
        final playlist = playlists[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Image.network(
              playlist.snippet!.thumbnails!.default_!.url!,
            ),
            title: Text(playlist.snippet!.title!),
            subtitle: Text(playlist.snippet!.description!),
            onTap: () => onTap(playlist),
          ),
        );
      },
    );
  }
}