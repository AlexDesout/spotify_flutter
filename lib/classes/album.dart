// import 'dart:convert' as convert;

class Album {
  final String id; // : albums/items/id
  final String idArtist; // : albums/items/artists/id
  final String nameArtist; // : albums/items/artists/name
  final String cover; // : albums/items/images
  final String name; // : albums/items/name

  Album({ 
    required this.id,
    required this.idArtist,
    required this.nameArtist,
    required this.cover,
    required this.name,
  });

  factory Album.fromJson(Map<String, dynamic> data) {
    return Album(
      id: data['id']?.toString() ?? "",
      idArtist: data['artists']?[0]?['id'].toString() ?? "",
      nameArtist: data['artists']?[0]?['name'].toString() ?? "",
      cover: data['images']?[0]?['url'].toString() ?? "",
      name: data['name']?.toString() ?? "",
    );
  }

  @override
  String toString() {
    return name;
  }
}
