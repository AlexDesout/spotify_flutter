import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projet_spotify_gorouter/classes/chanson.dart';
import 'package:projet_spotify_gorouter/providers/chanson_provider.dart';
import '../classes/artiste.dart';
import '../providers/artiste_provider.dart';

class ArtisteDetailScreen extends StatefulWidget {
  final String idArtist;
  const ArtisteDetailScreen({Key? key, required this.idArtist})
      : super(key: key);

  @override
  _ArtisteDetailScreenState createState() => _ArtisteDetailScreenState();
}

class _ArtisteDetailScreenState extends State<ArtisteDetailScreen> {
  late Artiste _artiste =
      Artiste(id: '', followers: '', image: '', name: '', popularity: '');
  late List<Chanson> _topTracks = [];

  @override
  void initState() {
    super.initState();

    loadData();
  }

  void loadData() async {
    Artiste artiste = await fetchArtistDetails(widget.idArtist);
    List<Chanson> topTracks = await fetchArtistTopTracks(widget.idArtist);

    setState(() {
      _artiste = artiste;
      _topTracks = topTracks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Artiste Details Screen')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 200.00,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    _artiste.image,
                    height: 200.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Image de l'artiste

            const SizedBox(height: 20.0),

            Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Centrer verticalement
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Centrer horizontalement
                children: [
                  // Nom de l'artiste
                  Text(
                    _artiste.name,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                      height:
                          8.0), // Ajouter un petit espace entre les éléments

                  // Popularité de l'artiste
                  Text(
                    "Popularité : ${_artiste.popularity}",
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(
                      height:
                          4.0), // Ajouter un petit espace entre les éléments

                  // Nombre d'abonnés de l'artiste
                  Text(
                    "${_artiste.followers} abonnés",
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 20.0),

                  const Text(
                    "Top-tracks :",
                    style: TextStyle(
                        fontSize: 18.00,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            // Liste des chansons
            Expanded(
              child: ListView.separated(
                itemCount: _topTracks.length,
                separatorBuilder: (context, index) =>
                    const Divider(), // Séparateur entre les chansons
                itemBuilder: (context, index) {
                  String artists = _topTracks[index].artistNames.join(', ');

                  return ListTile(
                    title: Text(_topTracks[index].name),
                    subtitle: Text(artists),
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


 // child: ElevatedButton(
        //   onPressed: () => context.go('/a/albumdetails'),
        //   child: const Text('Go back'),

        // ),