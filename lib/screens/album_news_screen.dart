import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projet_spotify_gorouter/classes/album.dart';
import '../providers/album_provider.dart';

class AlbumNewsScreen extends StatefulWidget {
  const AlbumNewsScreen({Key? key}) : super(key: key);

  @override
  _AlbumNewsScreenState createState() => _AlbumNewsScreenState();
}

class _AlbumNewsScreenState extends State<AlbumNewsScreen> {
  late List<Album> _albums = []; // State variable to hold the list of albums

  @override
  void initState() {
    super.initState();
    // You can initialize state variables here or perform any setup required
    // For example, you could fetch initial data from the network
    // _albums = fetchNewAlbums(); // If fetchNewAlbums() is synchronous

    loadData();
  }

  void loadData() async {
    List<Album> liste = await fetchNewAlbums();

    setState(() {
      _albums = liste;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nouveaux albums"),
      ),
      body: ListView.builder(
        itemCount: _albums.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white,
            margin: const EdgeInsets.only(top: 20.00),
            child: ListTile(
              leading: Image.network(
                _albums[index].cover,
              ),
              title: Text(_albums[index].name),
              subtitle: Text(_albums[index].artistNames[0]),
              onTap: () {
                context.go("/a/albumdetails/${_albums[index].id}");
              },
            ),
          );
        },
      ),
    );
  }
}
