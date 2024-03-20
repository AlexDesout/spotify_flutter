class Album {
  final String id; // : albums/items/id
  final String idArtist; // : albums/items/artists/id
  final List artistNames; // : albums/items/artists/name
  final List artistIds; // : albums/items/artists/id
  final String cover; // : albums/items/images
  final String name; // : albums/items/name

  Album({
    required this.id,
    required this.idArtist,
    required this.artistNames,
    required this.artistIds,
    required this.cover,
    required this.name,
  });

  factory Album.fromJson(Map<String, dynamic> data) {
    List<String> artistNames = [];
    List<String> artistIds = [];
    List<dynamic>? artistsData = data['artists'];

    if (artistsData != null) {
      for (var artistData in artistsData) {
        String? artistName = artistData['name']?.toString();
        String? artistId = artistData['id']?.toString();
        if (artistName != null && artistId != null) {
          artistNames.add(artistName);
          artistIds.add(artistId);
        }
      }
    }

    return Album(
      id: data['id']?.toString() ?? "",
      idArtist: data['artists']?[0]?['id'].toString() ?? "",
      artistNames: artistNames,
      artistIds: artistIds,
      cover: data['images']?[0]?['url'].toString() ?? "",
      name: data['name']?.toString() ?? "",
    );
  }

  @override
  String toString() {
    return name;
  }
}
