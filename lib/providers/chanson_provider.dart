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

// // Récupérer un album
// Future<Album> fetchSingleAlbum(String id) async {
//   Album album;

//   var url = Uri.parse('https://api.spotify.com/v1/albums/$id');

//   try {
//     var response = await http.get(
//       url,
//       headers: {
//         'Authorization': 'Bearer $token',
//       },
//     );

//     if (response.statusCode == 200) {
//       var jsonResponse = convert.jsonDecode(response.body);

//       album = Album.fromJson(jsonResponse);
//       return album;
//     } else {
//       throw Exception('Failed to load album: ${response.statusCode}');
//     }
//   } catch (e) {
//     throw Exception('Failed to load album: $e');
//   }
// }

