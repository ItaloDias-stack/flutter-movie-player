import 'package:flutter/material.dart';
import 'package:flutter_movie_player/presentation/views/hello_world/hello_world_screen.dart';
import 'package:flutter_movie_player/presentation/views/player_screen/player_screen.dart';
import 'package:flutter_movie_player/utils/routes.dart';
import 'package:flutter_movie_player/utils/setup_get_it.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
      title: 'Player de vídeo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  PlayerScreen.routeName,
                );
              },
              child: const Text("Player com legenda"),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  HelloWorldScreen.routeName,
                );
              },
              child: const Text("Exemplo básico do uso da lib"),
            )
          ],
        ),
      ),
    );
  }
}
