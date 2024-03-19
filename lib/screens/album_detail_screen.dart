import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../classes/album.dart';
import '../providers/album_provider.dart';

/// The details screen
class AlbumDetailScreen extends StatefulWidget {
  /// Constructs a [AlbumDetailScreen]

  final String id;
  const AlbumDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  _AlbumDetailScreenState createState() => _AlbumDetailScreenState();
}

class _AlbumDetailScreenState extends State<AlbumDetailScreen> {
  late Album _albums; // State variable to hold the list of albums

  @override
  void initState() {
    super.initState();

    loadData();
  }

  void loadData() async {
    Album album = await fetchSingleAlbum(widget.id);

    setState(() {
      _albums = album;
    });
    print(album);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Album Details Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/a'),
              child: const Text('Go back'),
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
