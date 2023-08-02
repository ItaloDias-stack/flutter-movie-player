import 'package:flutter/material.dart';
import 'package:flutter_movie_player/presentation/views/player_screen/player_screen.dart';

final Map<String, WidgetBuilder> routes = {
  PlayerScreen.routeName: (context) => const PlayerScreen(),
};
