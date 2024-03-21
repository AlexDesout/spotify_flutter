import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import '../classes/album.dart';
import '../token.dart';

// Récupérer les derniers albums
Future<List<Album>> fetchNewAlbums() async {
  List<Album> newAlbums = [];

  var url = Uri.parse('https://api.spotify.com/v1/browse/new-releases');

  try {
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);

      var albumsJson = jsonResponse['albums']['items'];

      for (var albumData in albumsJson) {
        var album = Album.fromJson(albumData);
        newAlbums.add(album);
      }

      return newAlbums;
    } else {
      throw Exception('Failed to load albums: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load albums: $e');
  }
}

// Récupérer un album
Future<Album> fetchSingleAlbum(String id) async {
  Album album;

  var url = Uri.parse('https://api.spotify.com/v1/albums/$id');

  try {
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);

      album = Album.fromJson(jsonResponse);
      return album;
    } else {
      throw Exception('Failed to load album: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load album: $e');
  }
}

// Chercher une liste d'album
Future<List<Album>> fetchSearchAlbums(String query) async {
  List<Album> searchAlbums = [];

  var url = Uri.parse('https://api.spotify.com/v1/search?q=${Uri.encodeQueryComponent(query)}&type=album');
  // print(url);

  try {
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);

      var albumsJson = jsonResponse['albums']['items'];

      for (var albumData in albumsJson) {
        var album = Album.fromJson(albumData);
        searchAlbums.add(album);
      }

      return searchAlbums;
    } else {
      throw Exception('Failed to load albums: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load albums: $e');
  }
}
