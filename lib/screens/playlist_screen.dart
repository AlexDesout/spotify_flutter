import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projet_spotify_gorouter/classes/playlist.dart';
import 'package:provider/provider.dart';
import '../providers/playlist_provider_sql.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureProvider<List<Playlist>>(
      create: (_) {
        var playlistProvider =
            Provider.of<PlaylistProvider>(context, listen: false);
        return playlistProvider.loadPlaylists();
      },
      initialData: [],
      child: _PlaylistScreenContent(),
    );
  }
}

class _PlaylistScreenContent extends StatelessWidget {
  const _PlaylistScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var playlists = Provider.of<List<Playlist>>(context);
    print(playlists);

    return Scaffold(
      appBar: AppBar(title: const Text('Playlist Screen')),
      body: playlists.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: playlists.length,
              itemBuilder: (context, index) {
                var playlist = playlists[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(playlist.name),
                    subtitle:
                        Text('Number of tracks: ${playlist.tracklist.length}'),
                    trailing: PopupMenuButton<String>(
                      icon: Icon(Icons.more_vert),
                      itemBuilder: (context) => [
                        PopupMenuItem<String>(
                          value: 'edit',
                          child: Text('Edit'),
                        ),
                        PopupMenuItem<String>(
                          value: 'delete',
                          child: Text('Delete'),
                        ),
                      ],
                      onSelected: (String value) {
                        if (value == 'edit') {
                          // Action d'édition
                        } else if (value == 'delete') {
                          // Action de suppression
                        }
                      },
                    ),
                    onTap: () {
                      // Handle playlist tap
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Ouvrir le formulaire de création de playlist
          _showCreatePlaylistForm(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showCreatePlaylistForm(BuildContext context) {
    TextEditingController playlistNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Create Playlist'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: playlistNameController,
              decoration: InputDecoration(labelText: 'Playlist Name'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              String playlistName = playlistNameController.text;
              if (playlistName.isNotEmpty) {

                Navigator.of(context).pop(); // Fermer la boîte de dialogue
              } else {
                // Afficher un message d'erreur si le nom est vide
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please enter a playlist name.'),
                  ),
                );
              }
            },
            child: Text('Create'),
          ),
        ],
      ),
    );
  }
}

