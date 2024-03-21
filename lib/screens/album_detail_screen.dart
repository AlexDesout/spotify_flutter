import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projet_spotify_gorouter/services/audio_player.dart';
import '../classes/album.dart';
import '../classes/chanson.dart';
import '../providers/album_provider.dart';
import '../providers/chanson_provider.dart';

/// The details screen
class AlbumDetailScreen extends StatefulWidget {
  final String id;
  const AlbumDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  _AlbumDetailScreenState createState() => _AlbumDetailScreenState();
}

class _AlbumDetailScreenState extends State<AlbumDetailScreen> {
  late Album _album = Album(
      id: '',
      idArtist: '',
      artistNames: [],
      artistIds: [],
      cover: '',
      name: '');
  late List<Chanson> _tracklist = [];
  final AudioService _audioService = AudioService();

  @override
  void initState() {
    super.initState();

    loadData();
  }

  void loadData() async {
    Album album = await fetchSingleAlbum(widget.id);
    List<Chanson> trackList = await fetchAlbumTracks(widget.id);

    setState(() {
      _album = album;
      _tracklist = trackList;
    });

    // print(_album.artistNames);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Détails")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              _album.cover,
              height: 300.00,
              width: 300.00,
            ),
            Text(
              _album.name,
              style:
                  const TextStyle(fontSize: 20.00, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Artistes :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Liste des artistes
                  Wrap(
                    children: List.generate(_album.artistNames.length, (index) {
                      String artistName = _album.artistNames[index];
                      String artistId = _album.artistIds[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: GestureDetector(
                          onTap: () {
                            context.go('/a/artistedetails/$artistId');
                          },
                          child: Chip(label: Text(artistName)),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Affichage de la tracklist
            Expanded(
              child: ListView.builder(
                itemCount: _tracklist.length,
                itemBuilder: (context, index) {
                  String artists = _tracklist[index].artistNames.join(', ');

                  return ListTile(
                    title: Text(_tracklist[index].name),
                    subtitle: Text(artists),
                    trailing: IconButton(
                      icon: const Icon(Icons.play_arrow),
                      onPressed: () {
                        // Appel de la fonction d'écoute audio
                        _audioService.playAudio(_tracklist[index].url);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
