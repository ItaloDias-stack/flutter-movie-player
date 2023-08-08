import 'package:flutter/material.dart';
import 'package:flutter_movie_player/presentation/views/hello_world/hello_world_screen.dart';
import 'package:flutter_movie_player/presentation/views/player_screen/player_screen.dart';
import 'package:flutter_movie_player/presentation/views/subtitles_screen/subtitles_screen.dart';

final Map<String, WidgetBuilder> routes = {
  PlayerScreen.routeName: (context) => const PlayerScreen(),
  SubtitlesScreen.routeName: (context) => const SubtitlesScreen(),
  HelloWorldScreen.routeName: (context) => const HelloWorldScreen(),
};
