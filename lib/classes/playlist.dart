import 'package:projet_spotify_gorouter/classes/chanson.dart';

class Playlist {
  final String id;
  final String name;
  final List<Chanson> tracklist;

  Playlist({
    required this.id,
    required this.name,
    required this.tracklist,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'tracklist': tracklist.map((chanson) => chanson.toMap()).toList(),
    };
  }

factory Playlist.fromMap(Map<String, dynamic> map) {
  return Playlist(
    id: map['id'],
    name: map['name'],
    tracklist: (map['tracklist'] as String?)?.split(', ').map((track) => Chanson(name: track, id: track, artistNames: [], url: "")).toList() ?? [],
  );
}


}
