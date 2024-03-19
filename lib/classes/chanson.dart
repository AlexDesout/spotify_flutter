// import 'dart:convert' as convert;

class Chanson {
  final String id; // : albums/items/id
  // final String idArtist; // : albums/items/artists/id
  final List artistNames; // : /items/artists/name
  final String name; // : albums/items/name

  Chanson({
    required this.id,
    // required this.idArtist,
    required this.artistNames,
    required this.name,
  });

  factory Chanson.fromJson(Map<String, dynamic> data) {
    List<String> artistNames = [];
    List<dynamic>? artistsData = data['artists'];

    if (artistsData != null) {
      for (var artistData in artistsData) {
        String? artistName = artistData['name']?.toString();
        if (artistName != null) {
          artistNames.add(artistName);
        }
      }
    }

    return Chanson(
      id: data['id']?.toString() ?? "",
      artistNames: artistNames,
      name: data['name']?.toString() ?? "",
    );
  }

  @override
  String toString() {
    return name;
  }
}
