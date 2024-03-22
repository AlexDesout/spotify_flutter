import 'package:flutter/material.dart';
import 'package:projet_spotify_gorouter/router/router_config.dart';
import 'package:provider/provider.dart';
import 'package:projet_spotify_gorouter/providers/playlist_provider_sql.dart';
// module supplémentaire pour utilisez SQFlite sur le web
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
// car le module SQFLite ne supporte pas le web
import 'package:sqflite/sqflite.dart';

void main() {
  databaseFactory = databaseFactoryFfiWeb;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlaylistProvider()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
            brightness: Brightness.light,
          ),
        ),
      ),
    );
  }
}
