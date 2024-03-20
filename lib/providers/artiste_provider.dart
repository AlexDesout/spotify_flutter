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

      artiste = Artiste.fromJson(jsonResponse);
      return artiste;
    } else {
      throw Exception('Failed to load album: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load album: $e');
  }
}
