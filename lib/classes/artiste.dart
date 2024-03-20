class Artiste {
  final String id;
  final String followers;
  final String image;
  final String name;
  final String popularity;

  Artiste({
    required this.id,
    required this.followers,
    required this.image,
    required this.name,
    required this.popularity,
  });

  factory Artiste.fromJson(Map<String, dynamic> data) {
    return Artiste(
      id: data['id']?.toString() ?? "",
      followers: data['followers']['total']?.toString() ?? "",
      image: data['images']?[0]?['url'].toString() ?? "",
      name: data['name']?.toString() ?? "",
      popularity: data['popularity']?.toString() ?? "",
    );
  }

  @override
  String toString() {
    return name;
  }
}
