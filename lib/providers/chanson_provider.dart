import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import '../classes/chanson.dart';
import '../token.dart';

// Récupérer une tracklist
Future<List<Chanson>> fetchAlbumTracks(String id) async {
  List<Chanson> trackList = [];

  var url = Uri.parse('https://api.spotify.com/v1/albums/$id/tracks');

  try {
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);

      var chansonsJson = jsonResponse['items'];

      for (var trackData in chansonsJson) {
        var track = Chanson.fromJson(trackData);
        trackList.add(track);
      }

      return trackList;
    } else {
      throw Exception('Failed to load albums: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load albums: $e');
  }
}

// Top tracks d'un artiste
Future<List<Chanson>> fetchArtistTopTracks(String id) async {
  List<Chanson> topTrack = [];

  var url = Uri.parse('https://api.spotify.com/v1/artists/$id/top-tracks');

  try {
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);

      var chansonsJson = jsonResponse['tracks'];

      for (var trackData in chansonsJson) {
        var track = Chanson.fromJson(trackData);
        topTrack.add(track);
      }

      return topTrack;
    } else {
      throw Exception('Failed to load albums: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load albums: $e');
  }
}


// Chercher une liste de tracks
Future<List<Chanson>> fetchSearchTracks(String query) async {
  List<Chanson> searchTracks = [];

  var url = Uri.parse(
      'https://api.spotify.com/v1/search?q=${Uri.encodeQueryComponent(query)}&type=track');
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

      var tracksJson = jsonResponse['tracks']['items'];

      for (var trackData in tracksJson) {
        var track = Chanson.fromJson(trackData);
        searchTracks.add(track);
      }

      return searchTracks;
    } else {
      throw Exception('Failed to load albums: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load albums: $e');
  }
}

