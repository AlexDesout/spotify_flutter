import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../classes/album.dart';
import '../classes/chanson.dart';
import '../providers/album_provider.dart';
import '../providers/chanson_provider.dart';

/// The details screen
class AlbumDetailScreen extends StatefulWidget {
  /// Constructs a [AlbumDetailScreen]

  final String id;
  const AlbumDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  _AlbumDetailScreenState createState() => _AlbumDetailScreenState();
}

class _AlbumDetailScreenState extends State<AlbumDetailScreen> {
  late Album _album;
  late List<Chanson> _tracklist;

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
                    children: _album.artistNames.map((artist) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Chip(label: Text(artist)),
                      );
                    }).toList(),
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
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () => context.go('/a/artistedetails'),
              child: const Text('Go Artiste Detail'),
            ),
          ],
        ),
      ),
    );
  }
}
