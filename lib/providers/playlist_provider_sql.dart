import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:projet_spotify_gorouter/classes/chanson.dart';
import 'package:projet_spotify_gorouter/classes/playlist.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite_ffi;

class PlaylistProvider with ChangeNotifier {
  List<Playlist> _playlists = [];
  late Database db;

  List<Playlist> get playlists => _playlists;

  PlaylistProvider() {
    sqflite_ffi.sqfliteFfiInit();
    loadPlaylists();
  }

  Future<List<Playlist>> loadPlaylists() async {
    await open();
    final List<Map<String, dynamic>> maps = await db.query('playlists');
    _playlists = List.generate(maps.length, (i) {
      return Playlist.fromMap({
        'id': maps[i]['id'],
        'name': maps[i]['name'],
        'tracklist': maps[i]['tracklist'],
      });
    });
    notifyListeners();
    return _playlists;
  }

  // -- Connexion + création BD
  Future<void> open() async {
    final documentsDirectory = await getDatabasesPath();
    final path = join(documentsDirectory, "playlists.db");

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
      CREATE TABLE playlists (
        id TEXT PRIMARY KEY,
        name TEXT,
        tracklist TEXT
      )
    ''');
          await insertTestData();
        });
  }

  Future<void> insertTestData() async {
    List<Chanson> chansonsPlaylist1 = [
      Chanson(id: '1', name: 'Chanson 1', artistNames: ['Serpent'], url: 'aaaa'),
      Chanson(id: '2', name: 'Chanson 2', artistNames: ['Serpent'], url: 'aaaa'),
      Chanson(id: '3', name: 'Chanson 3', artistNames: ['Serpent'], url: 'aaaa'),
    ];

    List<Chanson> chansonsPlaylist2 = [
      Chanson(id: '4', name: 'Chanson 4', artistNames: ['Serpent'], url: 'aaaa'),
      Chanson(id: '5', name: 'Chanson 5', artistNames: ['Serpent'], url: 'aaaa'),
      Chanson(id: '6', name: 'Chanson 6', artistNames: ['Serpent'], url: 'aaaa'),
    ];

    String tracklistPlaylist1 = jsonEncode(chansonsPlaylist1.map((chanson) => chanson.toJson()).toList());
    String tracklistPlaylist2 = jsonEncode(chansonsPlaylist2.map((chanson) => chanson.toJson()).toList());

    await db.transaction((txn) async {
      await txn.rawInsert('INSERT INTO playlists(id, name, tracklist) VALUES(?, ?, ?)',
          ['1', 'Ma playlist 1', tracklistPlaylist1]);
      await txn.rawInsert('INSERT INTO playlists(id, name, tracklist) VALUES(?, ?, ?)',
          ['2', 'Ma playlist 2', tracklistPlaylist2]);
    });

    notifyListeners();
  }

  Future<void> addPlaylist(String name, List<Chanson> tracklist) async {
    String tracklistJson = jsonEncode(tracklist.map((chanson) => chanson.toJson()).toList());
    await db.insert('playlists', {
      'name': name,
      'tracklist': tracklistJson,
    });
    await loadPlaylists(); // Recharger les playlists après l'ajout de la nouvelle
  }
}
