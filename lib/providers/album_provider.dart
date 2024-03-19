import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import '../classes/album.dart';

const token = 'BQBvV3Sd_eDBTX4KfLt_j-PboF17A40EADg-_1wOYmDNdIMfYeTFpy1FL2ee2w3x5cQbmc1D2Nw9M69mPlCUCOaTnH9WN_bz5w5P8fJgJclBfSlz1fE';


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

