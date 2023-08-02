import 'package:flutter/material.dart';
import 'package:flutter_movie_player/presentation/stores/player_store.dart';
import 'package:get_it/get_it.dart';

class PlayerScreen extends StatefulWidget {
  static const routeName = "player_screen";
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final store = GetIt.I.get<PlayerStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
