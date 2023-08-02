import 'package:flutter_movie_player/presentation/stores/player_store.dart';
import 'package:get_it/get_it.dart';

void setupGetIt() {
  GetIt.I.registerSingleton<PlayerStore>(PlayerStore());
}
