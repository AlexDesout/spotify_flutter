import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projet_spotify_gorouter/classes/album.dart';
import 'package:projet_spotify_gorouter/classes/artiste.dart';
import 'package:projet_spotify_gorouter/classes/chanson.dart';
import 'package:projet_spotify_gorouter/providers/chanson_provider.dart';
import '../providers/album_provider.dart';
import '../providers/artiste_provider.dart';
// import 'package:just_audio/just_audio.dart';
import '../services/audio_player.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Album> _searchAlbums = [];
  List<Artiste> _searchArtistes = [];
  List<Chanson> _searchTracks = [];
  late TextEditingController _searchController;
  late List<bool> _isSelected;
  final AudioService _audioService = AudioService();

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _isSelected = [true, false, false];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _updateSelection(int index) {
    setState(() {
      for (int buttonIndex = 0;
          buttonIndex < _isSelected.length;
          buttonIndex++) {
        _isSelected[buttonIndex] = buttonIndex == index;
      }

      switch (index) {
        case 0:
          // Afficher les albums
          _searchAlbums.clear();
          break;
        case 1:
          _searchArtistes.clear();
          break;
        case 2:
          _searchTracks.clear();
          break;
      }
    });
  }

  void getResults(String input) async {
    _searchAlbums.clear();
    _searchArtistes.clear();
    _searchTracks.clear();

    if (input.isNotEmpty) {
      switch (_isSelected.indexOf(true)) {
        case 0:
          // Recherchez les albums
          List<Album> result = await fetchSearchAlbums(input);
          setState(() {
            _searchAlbums = result;
          });
          break;
        case 1:
          // Recherchez les artistes
          List<Artiste> result = await fetchSearchArtistes(input);
          setState(() {
            _searchArtistes = result;
          });
          break;
        case 2:
          // Recherchez les pistes
          List<Chanson> result = await fetchSearchTracks(input);
          setState(() {
            _searchTracks = result;
          });
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Screen'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ToggleButtons(
                isSelected: _isSelected,
                onPressed: _updateSelection,
                children: const <Widget>[
                  Text('Albums'),
                  Text('Artistes'),
                  Text('Pistes'),
                ],
              ),
            ],
          ),
          TextField(
            controller: _searchController,
            onChanged: getResults,
            decoration: const InputDecoration(
              hintText: 'Search...',
              border: OutlineInputBorder(),
            ),
          ),
          Expanded(
            child: _isSelected[0]
                ? ListView.builder(
                    itemCount: _searchAlbums.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white,
                        margin: const EdgeInsets.only(top: 20.0),
                        child: ListTile(
                          leading: Image.network(_searchAlbums[index].cover),
                          title: Text(_searchAlbums[index].name),
                          subtitle: Text(_searchAlbums[index].artistNames[0]),
                          onTap: () {
                            context.go(
                                "/b/albumdetails/${_searchAlbums[index].id}");
                          },
                        ),
                      );
                    },
                  )
                : _isSelected[1]
                    ? ListView.builder(
                        itemCount: _searchArtistes.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.white,
                            margin: const EdgeInsets.only(top: 20.0),
                            child: ListTile(
                              leading:
                                  Image.network(_searchArtistes[index].image),
                              title: Text(_searchArtistes[index].name),
                              subtitle: Text(
                                  "popularité : ${_searchArtistes[index].popularity}"),
                              onTap: () {
                                context.go(
                                    "/b/artistedetails/${_searchArtistes[index].id}");
                              },
                            ),
                          );
                        },
                      )
                    : ListView.builder(
                        itemCount: _searchTracks.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.white,
                            margin: const EdgeInsets.only(top: 20.0),
                            child: ListTile(
                              title: Text(_searchTracks[index].name),
                              subtitle: Text(_searchTracks[index].url),
                              trailing: IconButton(
                                icon: const Icon(Icons.play_arrow),
                                onPressed: () {
                                  _audioService
                                      .playAudio(_searchTracks[index].url);
                                },
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
