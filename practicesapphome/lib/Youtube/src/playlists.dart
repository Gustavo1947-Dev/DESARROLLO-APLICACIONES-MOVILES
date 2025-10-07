import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'widgets/playlist_list.dart';

class Playlists extends StatelessWidget {
  const Playlists({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterDev Playlists'),
      ),
      body: Consumer<FlutterDevPlaylists>(
        builder: (context, playlistState, child) {
          if (playlistState.playlists.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return PlaylistList(
            playlists: playlistState.playlists,
            onTap: (playlist) {
              GoRouter.of(context).go(
                '/playlist/${playlist.id}?title=${playlist.snippet!.title!}',
              );
            },
          );
        },
      ),
    );
  }
}
