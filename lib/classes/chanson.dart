import 'dart:convert';

class Chanson {
  final String id;
  final List<String> artistNames;
  final String name;
  final String url;

  Chanson({
    required this.id,
    required this.artistNames,
    required this.name,
    required this.url,
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
      url: data['preview_url']?.toString() ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'artistNames': artistNames,
      'name': name,
      'url': url,
    };
  }

  factory Chanson.fromMap(Map<String, dynamic> map) {
    return Chanson(
      id: map['id'],
      artistNames: (map['artistNames'] as String).split(', '),
      name: map['name'],
      url: map['url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'artistNames': artistNames.join(', '),
      'name': name,
      'url': url,
    };
  }

  @override
  String toString() {
    return name;
  }
}
