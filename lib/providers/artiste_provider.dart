import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import '../classes/artiste.dart';
import '../token.dart';

// Information sur un artiste
Future<Artiste> fetchArtistDetails(String id) async {
  Artiste artiste;

  var url = Uri.parse('https://api.spotify.com/v1/artists/$id');

  try {
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      // print(jsonResponse);

      artiste = Artiste.fromJson(jsonResponse);
      return artiste;
    } else {
      throw Exception('Failed to load album: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load album: $e');
  }
}

// Chercher une liste d'artistes
Future<List<Artiste>> fetchSearchArtistes(String query) async {
  List<Artiste> searchArtistes = [];

  var url = Uri.parse(
      'https://api.spotify.com/v1/search?q=${Uri.encodeQueryComponent(query)}&type=artist');

  try {
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);

      var artistesJson = jsonResponse['artists']['items'];

      for (var artisteData in artistesJson) {
        var artiste = Artiste.fromJson(artisteData);
        searchArtistes.add(artiste);
      }

      return searchArtistes;
    } else {
      throw Exception('Failed to load albums: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load albums: $e');
  }
}
